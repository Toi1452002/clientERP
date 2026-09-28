import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../../../../core/widgets/widget.dart';
import '../../notifier/manghiepvu_edit_notifier.dart';
import '../../notifier/manghiepvu_notifier.dart';
import '../state/manghiepvu_table_manager.dart';


class ManNghiepVuTable extends ConsumerStatefulWidget {
  const ManNghiepVuTable({super.key});

  @override
  ConsumerState createState() => _ManNghiepVuTableState();
}

class _ManNghiepVuTableState extends ConsumerState<ManNghiepVuTable> {
  late MaNghiepVuTableManager _manager;
  bool isInit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.listenManual(maNghiepVuEditProvider, (_, next) {
      if (isInit) {
        next.whenOrNull(
            data: (val) {

              if(val!=null){
                ref.read(maNghiepVuProvider.notifier).changedRow(val);
              }
              _manager.closeLoading();
            },
            loading: () {
              _manager.showLoading();
            },
            error: (e,s){
              _manager.closeLoading();
            }
        );
      }
    });

    ref.listenManual(maNghiepVuProvider, (_, next){
      if (isInit) {
        next.whenOrNull(
            data: (val) {
              _manager.loadView(val);
              _manager.closeLoading();
            },
            loading: () {
              _manager.showLoading();
            },
            error: (e,s){
              // isInit = false;
              _manager.closeLoading();
            }
        );
      }

    });
  }


  @override
  Widget build(BuildContext context) {
    final state = ref.watch(maNghiepVuProvider);

    return state.when(
      skipLoadingOnReload: isInit,
      skipLoadingOnRefresh: isInit,
      data: (val) {
        return AppTable(
          onLoaded: (e) {
            _manager = MaNghiepVuTableManager(e.stateManager);
            _manager.loadView(val);
            isInit = true;
          },
          onChange: (re) async{
            final id = re.row.cells['delete']?.value;
            // await Future.delayed(Duration(seconds: 1));
            final field = re.column.field;
            await Future.delayed(Duration(microseconds: 100));
            if(field == "MaNV" || field == "MoTa"){
              await ref.read(maNghiepVuEditProvider.notifier).updateRow(_manager.toMap(re.row), id);
            }
          },
          columns: [
            AppTableColumn(
              title: ['#', 'stt'],
              width: 35,
              renderer: (re) => AppTableCell.textNum("${re.rowIdx + 1}"),
              readOnly: true,
            ),
            AppTableColumn(
              title: ['', 'delete'],
              width: 25,
              renderer: (re) => AppTableCell.delete(() async {
                _manager.setCurrent(re);
                _manager.showLoading();
                showQuestion(context,onPressed: () async{
                  try {
                    await ref.read(maNghiepVuProvider.notifier).delete(re.cell.value);
                  } catch (e) {
                    if (context.mounted) showInfo(context, e.toString());
                  }
                });
                _manager.closeLoading();
              }),
            ),
            AppTableColumn(title: ['Mã', 'MaNV'], width: 100, isEdit: true),
            AppTableColumn(title: ['Mô tả', 'MoTa'], width: 195, isEdit: true),
          ],
        );
      },
      error: (e, s) => Center(child: Text(e.toString())),
      loading: () => Center(child: CircularProgressIndicator(size: 50)),
    );
  }
}
