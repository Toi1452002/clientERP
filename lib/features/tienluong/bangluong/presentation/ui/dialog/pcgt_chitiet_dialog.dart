import 'package:erp_client_1/core/widgets/app_dialog.dart';
import 'package:erp_client_1/core/widgets/app_table/app_table.dart';
import 'package:erp_client_1/features/tienluong/bangluong/presentation/notifier/pcgt_chitiet_notifier.dart';
import 'package:erp_client_1/features/tienluong/bangluong/presentation/ui/state/pcgt_chitiet_table_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class PCGTChiTietDialog extends ConsumerStatefulWidget {
  final String? maNV;
  final String maPC;
  const PCGTChiTietDialog({super.key, required this.maNV, required this.maPC});

  @override
  ConsumerState createState() => _PCGTChiTietDialogState();
}

class _PCGTChiTietDialogState extends ConsumerState<PCGTChiTietDialog> {
  late PCGTChiTietTablemanager _manager;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      if(widget.maNV!=null){
        ref.read(pcgtChiTietNotifier.notifier).get(widget.maNV!, widget.maPC);

      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(pcgtChiTietNotifier);
    return DialogWindows(
      width: 400, height: 400, title: 'PHỤ CẤP và GIẢM TRỪ',
      child: Scaffold(
        child: state.when(
          data: (val) {
            return AppTable(
              onLoaded: (e){
                _manager = PCGTChiTietTablemanager(e.stateManager);
                _manager.loadView(val);
              },
              columns: [
                AppTableColumn(
                  title: ['#', 'stt'],
                  width: 30,
                  readOnly: true,
                  renderer: (re) => AppTableCell.textNum("${re.rowIdx + 1}"),
                ),
                AppTableColumn(
                  title: ['Mô tả', 'MoTa'],
                  width: 150,
                  renderer: (re) => AppTableCell.textBlue(re.cell.value),
                ),
                AppTableColumn(
                  title: ['Tiêu chuẩn', 'SoTieuChuan'],
                  width: 100,
                  columnType: ColumnType.num,
                  showFooter: true,
                ),
                AppTableColumn(title: ['Thực tế', 'SoThucTe'], width: 80, columnType: ColumnType.num, showFooter: true),
              ],
            );
          },
          error: (e, s) => Center(child: Text(e.toString())),
          loading: () => Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
