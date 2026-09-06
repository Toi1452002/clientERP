import 'package:erp_client_1/core/constain/app_color.dart';
import 'package:erp_client_1/core/widgets/app_dialog.dart';
import 'package:erp_client_1/core/widgets/app_table/app_table.dart';
import 'package:erp_client_1/features/danhmuc/manghiepvu/data/model/manghiepvu_request_model.dart';
import 'package:erp_client_1/features/danhmuc/manghiepvu/presentation/notifier/manghiepvu_notifier.dart';
import 'package:erp_client_1/features/danhmuc/manghiepvu/presentation/ui/state/manghiepvu_table_manager.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/widgets/widget.dart';

class MaNghiepVuScreen extends ConsumerStatefulWidget {
  const MaNghiepVuScreen({super.key});

  @override
  ConsumerState createState() => _MaNghiepVuScreenState();
}

class _MaNghiepVuScreenState extends ConsumerState<MaNghiepVuScreen> {
  late MaNghiepVuTableManager _manager;
  final txtMa = TextEditingController();
  final txtMoTa = TextEditingController();

  MaNghiepVuRequestModel _model() => MaNghiepVuRequestModel(maNV: txtMa.text, moTa: txtMoTa.text);

  Future<void> onSubmit() async {
    if (txtMa.text.trim().isEmpty || txtMoTa.text.trim().isEmpty) {
      showInfo(context, "Nhập đầy đủ thông tin");
      return;
    }
    try {
      await ref.read(maNghiepVuProvider.notifier).add(_model());
      txtMa.clear();
      txtMoTa.clear();
    } catch (e) {
      if(context.mounted) showInfo(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(maNghiepVuProvider);
    return DialogWindows(
      width: 440,
      height: 500,
      title: 'Danh sách mã nghiệp vụ',
      child: Scaffold(
        backgroundColor: AppColor.background,
        child: Scaffold(
          headers: [
            Container(
              decoration: BoxDecoration(border: Border.all(color: AppColor.border)),
              padding: EdgeInsets.all(5),
              child: AppRow(
                columnWidths: {0: 100, 2: 40},
                items: [
                  AppTextField(hintText: 'Nhập mã', controller: txtMa),
                  AppTextField(hintText: 'Nhập mô tả', controller: txtMoTa, onSubmitted: (val) => onSubmit()),
                  AppAddButton(
                    onPressed: () {
                      onSubmit();
                    },
                  ),
                ],
              ),
            ),
          ],
          child: state.when(
            data: (val) {
              return AppTable(
                onLoaded: (e) {
                  _manager = MaNghiepVuTableManager(e.stateManager);
                  _manager.loadView(val);
                },
                onChange: (re) async{
                  final field = re.column.field;
                  final id = re.row.cells['delete']?.value;
                  try{
                    if(field == "MaNV"){
                      await ref.read(maNghiepVuProvider.notifier).updateMaNV(re.cell.value, id);
                    }else if (field=="MoTa"){
                      await ref.read(maNghiepVuProvider.notifier).updateMoTa(re.cell.value, id);
                    }
                  }catch(e){
                    showInfo(context, e.toString());
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
                      try {
                        await ref.read(maNghiepVuProvider.notifier).delete(re.cell.value);
                        _manager.delete(re);
                      } catch (e) {
                        if(context.mounted) showInfo(context, e.toString());
                      }
                    }),
                  ),
                  AppTableColumn(title: ['Mã', 'MaNV'], width: 100, isEdit: true),
                  AppTableColumn(title: ['Mô tả', 'MoTa'], width: 195, isEdit:  true),

                ],
              );
            },
            error: (e, s) => Center(child: Text(e.toString())),
            loading: () => Center(child: CircularProgressIndicator(size: 50)),
          ),
        ),
      ),
    );
  }
}
