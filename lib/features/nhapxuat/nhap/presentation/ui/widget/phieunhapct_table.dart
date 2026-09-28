import 'package:collection/collection.dart';
import 'package:erp_client_1/features/danhmuc/hanghoa/data/model/hanghoa_lookup_model.dart';
import 'package:erp_client_1/features/nhapxuat/nhap/data/model/phieunhapct_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:trina_grid/trina_grid.dart';

import '../../../../../../core/widgets/app_table/app_table.dart';
import '../../../../../danhmuc/dvt/presentation/ui/widget/dvt_combobox.dart';
import '../../../../../danhmuc/hanghoa/presentation/ui/state/hanghoa_lookup_provider.dart';
import '../../../../../danhmuc/hanghoa/presentation/ui/widget/hanghoa_combobox.dart';
import '../../../../../danhmuc/taikhoan/presentation/ui/widget/taikhoan_kho_combobox.dart';
import '../state/phieunhapct_table_manager.dart';

class PhieuNhapCTTable extends ConsumerWidget {
  const PhieuNhapCTTable({super.key, this.onLoaded, this.changedThanhTien, this.khoa = false});

  // late PhieuNhapCTTableManager state;
  final void Function(TrinaGridOnLoadedEvent)? onLoaded;
  final void Function()? changedThanhTien;
  final bool khoa;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppTable(
      onLoaded: onLoaded,
      mode: khoa ? TrinaGridMode.readOnly : TrinaGridMode.normal,

      onChange: (re) {
        final field = re.column.field;
        if (field == "DonGia") {
          re.row.cells['ThanhTien']?.value = re.cell.value * re.row.cells['SoLg']?.value;
          changedThanhTien?.call();
        } else if (field == "SoLg") {
          re.row.cells['ThanhTien']?.value = re.cell.value * re.row.cells['DonGia']?.value;
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
              re.stateManager.setCurrentCell(re.cell, re.rowIdx);
              re.stateManager.removeCurrentRow();
              changedThanhTien?.call();
            }, enabled: !re.stateManager.mode.isReadOnly);
          },
        ),
        AppTableColumn(
          title: ["Mã hàng", 'MaHH'],
          width: 150,
          renderer: (re) {
            final id = re.cell.value;
            final hangHoaState = ref.read(hangHoaLookupProvider);
            final hangHoaModel = hangHoaState.value?.firstWhereOrNull((e)=>e.id == id);

            re.stateManager.notifyListeners();
            return HangHoaCombobox(
              enabled: !re.stateManager.mode.isReadOnly,
              selected: hangHoaModel?.maHH,
              onTap: (){
                re.stateManager.setCurrentCell(re.cell, re.rowIdx);
              },
              noBorder: true,
              onChanged: (val) {
                final hh = ref.read(hangHoaLookupProvider).value?.firstWhereOrNull((e) => e.maHH == val);
                re.row.cells['TenHH']?.value = hh?.tenHH ?? "";
                re.row.cells['DVT']?.value = hh?.dvt;
                re.row.cells['DonGia']?.value = hh?.giaBan;
                re.row.cells['TKKho']?.value = hh?.tkKho;
                if (re.row.cells['SoLg']?.value == 0) {
                  re.row.cells['SoLg']?.value = 1;
                }
                re.row.cells['ThanhTien']?.value = re.row.cells['DonGia']?.value ?? 0 * re.row.cells['SoLg']?.value ?? 0;
                changedThanhTien?.call();

                re.cell.value = hh?.id;
                re.stateManager.notifyListeners();
              },
            );
          },
        ),
        AppTableColumn(title: ["Tên hàng hóa – vật tư", 'TenHH'], width: 300, isEdit: true),
        AppTableColumn(
          title: ["ĐVT", 'DVT'],
          width: 90,
          padding: 0,
          renderer: (re) {
            return DvtCombobox(
              onTap: (){
                re.stateManager.setCurrentCell(re.cell, re.rowIdx);

              },
              enabled: !re.stateManager.mode.isReadOnly,
              selected: re.cell.value,
              noBorder: true,
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
          title: ["TK kho", 'TKKho'],
          width: 90,
          padding: 0,
          renderer: (re) {
            return TaiKhoanKhoCombobox(
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
