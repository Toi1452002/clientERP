import 'package:collection/collection.dart';
import 'package:erp_client_1/core/constain/app_color.dart';
import 'package:erp_client_1/core/widgets/app_button.dart';
import 'package:erp_client_1/core/widgets/app_header.dart';
import 'package:erp_client_1/core/widgets/app_table/app_table.dart';
import 'package:erp_client_1/core/widgets/app_textfield.dart';
import 'package:erp_client_1/core/widgets/app_tngay_dngay.dart';
import 'package:erp_client_1/features/congno/presentation/notifier/somuahang_notifier.dart';
import 'package:erp_client_1/features/congno/presentation/ui/state/somuahang_table_manger.dart';
import 'package:erp_client_1/features/danhmuc/khach/data/model/khach_lookup_model.dart';
import 'package:erp_client_1/features/danhmuc/khach/presentation/ui/state/khach_lookup_state.dart';
import 'package:erp_client_1/features/danhmuc/khach/presentation/ui/widget/nhacung_combobox.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/num_helper.dart';

class SoMuaHangScreen extends ConsumerStatefulWidget {
  const SoMuaHangScreen({super.key});

  @override
  ConsumerState createState() => _SoMuaHangScreenState();
}

class _SoMuaHangScreenState extends ConsumerState<SoMuaHangScreen> {
  late SoMuaHangTableManager _manager;
  String? maKH;
  final txtTenKH = TextEditingController();
  DateTime tN = DateTime.now().copyWith(day: 1);
  DateTime dN = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(soMuaHangProvider);
    return Scaffold(
      backgroundColor: AppColor.background,
      footers: [AppFooter()],
      headers: [
        AppHeader(title: "Sổ mua hàng"),
        AppBar(
          leading: [
            AppTngayDngay(
              onSubmit: (tn, dn) {
                tN = tn;
                dN = dn;
                ref.read(soMuaHangProvider.notifier).get(maKH, tN, dN);
              },
            ),
          ],
        ),
        AppBar(
          leading: [
            Text("Mã NC").medium,
            Gap(8),
            SizedBox(
              width: 100,
              child: NhaCungCombobx(
                clear: false,
                selected: maKH,
                onChanged: (val) {
                  setState(() {
                    maKH = val;
                  });
                  if (maKH == null) {
                    txtTenKH.clear();
                  } else {
                    final k = ref.read(khachLookupProvider(LoaiKH.NhaCung)).value;
                    final tmp = k?.firstWhereOrNull((e) => e.maKH == val);
                    if (tmp != null) {
                      txtTenKH.text = tmp.tenKH;
                    }
                  }

                  ref.read(soMuaHangProvider.notifier).get(maKH, tN, dN);
                },
              ),
            ),
            SizedBox(width: 250, child: AppTextField(readOnly: true, controller: txtTenKH)),
          ],
        ),
        Divider(color: AppColor.border300),
      ],
      child: state.when(
        data: (val) {
          return Scaffold(
            headers: [
              Container(
                decoration: BoxDecoration(border: Border.all(color: AppColor.border)),
                child: AppBar(
                  leading: [AppPrintButton()],
                  trailing: [
                    Text('Nợ đầu kỳ: '),
                    Text(NumHelper.numFormat(val?.noDky), style: TextStyle(fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ],
            footers: [
              Container(
                decoration: BoxDecoration(border: Border.all(color: AppColor.border)),

                child: AppBar(
                  trailing: [
                    Text('Nợ cuối kỳ: '),
                    Text(NumHelper.numFormat(val?.noCKy), style: TextStyle(fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ],
            child: AppTable(
              onLoaded: (e) {
                _manager = SoMuaHangTableManager(e.stateManager);
                if (val != null) {
                  _manager.loadView(val.soMuaHang);
                }
              },
              columns: [
                AppTableColumn(
                  title: ['', 'stt'],
                  width: 35,
                  readOnly: true,
                  renderer: (re) => AppTableCell.textNum("${re.rowIdx + 1}"),
                ),
                AppTableColumn(
                  title: ['Ngày', 'Ngay'],
                  width: 90,
                  columnType: ColumnType.date,
                  renderer: (re) => AppTableCell.textBlue(re.cell.value).withAlign(Alignment.center),
                ),
                AppTableColumn(
                  title: ['Phiếu', 'Phieu'],
                  width: 90,
                  renderer: (re) => AppTableCell.textRed(re.cell.value),
                ),
                AppTableColumn(
                  title: ['Tên hàng hóa', 'DienGiai'],
                  width: 250,
                  renderer: (re) => AppTableCell.textBlue(re.cell.value),
                ),
                AppTableColumn(
                  title: ['ĐVT', 'DVT'],
                  width: 80,
                  renderer: (re) => AppTableCell.textBlue(re.cell.value),
                ),
                AppTableColumn(
                  title: ['Số lg', 'SoLg'],
                  width: 80,
                  renderer: (re) =>
                      AppTableCell.textBlue(NumHelper.numFormat(re.cell.value)).withAlign(Alignment.centerRight),
                ),
                AppTableColumn(
                  title: ['Đơn giá', 'DonGia'],
                  width: 120,
                  renderer: (re) =>
                      AppTableCell.textBlue(NumHelper.numFormat(re.cell.value)).withAlign(Alignment.centerRight),
                ),
                AppTableColumn(
                  title: ['Nợ', 'TienMua'],
                  columnType: ColumnType.num,
                  width: 120,
                  renderer: (re) =>
                      AppTableCell.textBlue(NumHelper.numFormat(re.cell.value)).withAlign(Alignment.centerRight),
                  showFooter: true,
                ),
                AppTableColumn(
                  title: ['Có', 'TienTra'],
                  width: 120,
                  columnType: ColumnType.num,
                  renderer: (re) =>
                      AppTableCell.textBlue(NumHelper.numFormat(re.cell.value)).withAlign(Alignment.centerRight),
                  showFooter: true,
                ),
              ],
            ),
          );
        },
        error: (e, s) => Center(child: Text(e.toString())),
        loading: () => Center(child: CircularProgressIndicator(size: 50)),
      ),
    );
  }
}
