import 'package:collection/collection.dart';
import 'package:erp_client_1/features/danhmuc/taikhoan/presentation/ui/widget/taikhoan_no_px_combobox.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:trina_grid/trina_grid.dart';

import '../../../../../../core/widgets/app_table/app_table.dart';
import '../../../../../danhmuc/dvt/presentation/ui/widget/dvt_combobox.dart';
import '../../../../../danhmuc/hanghoa/presentation/ui/state/hanghoa_lookup_provider.dart';
import '../../../../../danhmuc/hanghoa/presentation/ui/widget/hanghoa_combobox.dart';
import '../../../../../danhmuc/taikhoan/presentation/ui/widget/taikhoan_co_px_combobox.dart';

class PhieuXuatCTTable extends ConsumerWidget {
  const PhieuXuatCTTable({super.key, this.onLoaded, this.changedThanhTien, this.khoa = false});
  final void Function(TrinaGridOnLoadedEvent)? onLoaded;
  final void Function()? changedThanhTien;
  final bool khoa;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppTable(
      onLoaded: onLoaded,
      mode: khoa ? TrinaGridMode.readOnly : TrinaGridMode.normal,

      onChange: (re){
        final field = re.column.field;
        if(field == "DonGia"){
          re.row.cells['ThanhTien']?.value = re.cell.value*re.row.cells['SoLg']?.value;
          changedThanhTien?.call();
        }else if(field == "SoLg"){
          re.row.cells['ThanhTien']?.value = re.cell.value*re.row.cells['DonGia']?.value;
          changedThanhTien?.call();
        }
      },
      columns: [
        AppTableColumn(
          title: ["#", 'stt'],
          width: 35,
          renderer: (re) => AppTableCell.textNum("${re.rowIdx + 1}"),
          readOnly: true,
        ),
        AppTableColumn(
          title: ['', 'delete'],
          width: 25,
          padding: 0,
          showFilter: false,
          renderer: (re) {
            return AppTableCell.delete(() {
              re.stateManager.setCurrentCell(re.cell,re.rowIdx);
              re.stateManager.removeCurrentRow();
              changedThanhTien?.call();
            },enabled: !re.stateManager.mode.isReadOnly);
          },
        ),
        AppTableColumn(title: ["Mã hàng", 'MaHH'], width: 150,renderer: (re){
          final id = re.cell.value;
          final maHH = ref.read(hangHoaLookupProvider).value?.firstWhereOrNull((e)=>e.id==id);
          re.stateManager.notifyListeners();
          return HangHoaCombobox(
            enabled: !re.stateManager.mode.isReadOnly,
            selected: maHH?.maHH,
            onTap: (){
              re.stateManager.setCurrentCell(re.cell, re.rowIdx);

            },
            noBorder: true,
            onChanged: (val){
              final hh = ref.read(hangHoaLookupProvider).value?.firstWhereOrNull((e)=>e.maHH==val);
              re.row.cells['TenHH']?.value = hh?.tenHH??"";
              re.row.cells['DVT']?.value = hh?.dvt;
              re.row.cells['DonGia']?.value = hh?.giaBan;
              re.row.cells['TKKho']?.value=hh?.tkKho;
              re.row.cells['TKgv']?.value= '632';
              if(re.row.cells['SoLg']?.value == 0){
                re.row.cells['SoLg']?.value = 1;
              }
              re.row.cells['ThanhTien']?.value = re.row.cells['DonGia']?.value*re.row.cells['SoLg']?.value;
              changedThanhTien?.call();


              re.cell.value = hh?.id;
              re.stateManager.notifyListeners();
            },
          );
        }),
        AppTableColumn(title: ["Tên hàng hóa – vật tư", 'TenHH'], width: 250, isEdit: true),
        AppTableColumn(
          title: ["ĐVT", 'DVT'],
          width: 90,
          padding: 0,
          renderer: (re) {
            return DvtCombobox(
              enabled: !re.stateManager.mode.isReadOnly,
              selected: re.cell.value,
              noBorder: true,
              onTap: (){
                re.stateManager.setCurrentCell(re.cell, re.rowIdx);

              },
              onChanged: (val) {
                re.cell.value = val;
                re.stateManager.notifyListeners();
              },
            );
          },
        ),
        AppTableColumn(
          title: ["Đơn giá", 'DonGia'],
          columnAlign: ColumnAlign.right,
          width: 120,
          isEdit: true,
          columnType: ColumnType.num,
        ),
        AppTableColumn(
          title: ["SL", 'SoLg'],
          isEdit: true,
          width: 90,
          columnAlign: ColumnAlign.right,
          columnType: ColumnType.num,
        ),
        AppTableColumn(
          title: ["Thành tiền", 'ThanhTien'],
          columnAlign: ColumnAlign.right,
          width: 120,
          columnType: ColumnType.num,
          readOnly: true,
        ),
        AppTableColumn(
          title: ["TK nợ", 'TKgv'],
          width: 90,
          padding: 0,
          renderer: (re) {
            return TaiKhoanNoPxCombobox(

              noBorder: true,
              enabled: !re.stateManager.mode.isReadOnly,

              selected: re.cell.value,
              onChanged: (val) {
                re.cell.value = val;
                re.stateManager.notifyListeners();
              },
            );
          },
        ),
        AppTableColumn(
          title: ["TK có", 'TKKho'],
          width: 90,
          padding: 0,
          renderer: (re) {
            return TaiKhoanCoPxCombobox(
              noBorder: true,
              enabled: !re.stateManager.mode.isReadOnly,

              selected: re.cell.value,
              onChanged: (val) {
                re.cell.value = val;
                re.stateManager.notifyListeners();
              },
            );
          },
        ),
      ],
    );
  }
}