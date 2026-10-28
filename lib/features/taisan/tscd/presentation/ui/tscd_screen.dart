import 'dart:math';

import 'package:collection/collection.dart';
import 'package:erp_client_1/core/widgets/widget.dart';
import 'package:erp_client_1/features/danhmuc/hanghoa/presentation/ui/state/hanghoa_lookup_provider.dart';
import 'package:erp_client_1/features/danhmuc/hanghoa/presentation/ui/widget/hanghoa_combobox.dart';
import 'package:erp_client_1/features/danhmuc/taikhoan/presentation/ui/widget/taikhoan_chiphi_combobox.dart';
import 'package:erp_client_1/features/taisan/tscd/data/model/tscd_update_model.dart';
import 'package:erp_client_1/features/taisan/tscd/presentation/notifier/tscd_view_notifier.dart';
import 'package:erp_client_1/features/taisan/tscd/presentation/ui/state/tscd_table_manager.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trina_grid/trina_grid.dart';

import '../../../../../core/utils/num_helper.dart';
import '../../../../danhmuc/taikhoan/presentation/ui/widget/taikhoan_haomon_combobox.dart';

class TSCDScreen extends ConsumerStatefulWidget {
  const TSCDScreen({super.key});

  @override
  ConsumerState createState() => _TSCDScreenState();
}

class _TSCDScreenState extends ConsumerState<TSCDScreen> {
  late TSCDTableManager _manager;
  DateTime? tuNgay;
  bool isInit=false;
  int idUpdate = 0;
  bool isTinhToan = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ref.listenManual(tscdViewProvider, (_, next) {
      if(isInit){
        next.whenOrNull(
          data: (val) {
            tuNgay = ref.read(tscdViewProvider.notifier).ngayDau();
            _manager.closeLoading();
            // _manager.loadView(val);
            if(val.indexWhere((e)=>e.id==idUpdate)!=-1){
              _manager.updateRow(idUpdate, val.firstWhere((e)=>e.id==idUpdate));
              idUpdate = 0;
            }
            if(isTinhToan){
              _manager.loadView(val);
              isTinhToan = false;
            }
          },
          loading: () {
            _manager.showLoading();
          },
        );
      }

    });
  }

  Future<void> update(int id, TSCDUpdateModel model, {bool isHH = false}) async {
    try {
      idUpdate = id;
      await ref.read(tscdViewProvider.notifier).updateTSCD(id, model, isHH: isHH);
    } catch (e) {
      await showInfo(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(tscdViewProvider);
    return Scaffold(
      footers: [AppFooter()],
      headers: [
        // AppHeader(title: "Bảng khấu hao TSCĐ"),
        AppContainerBorder(
          child: AppBar(
            leading: [AppTngayDngay(tuNgay: tuNgay, onSubmit: (a, b) async {
              try{
                isTinhToan = true;
                await ref.read(tscdViewProvider.notifier).tinhToan(b);
              }catch(e){
                showInfo(context, e.toString());
              }
            })],
            trailing: [AppNewButton(text: "Thêm dòng", onPressed: () async{
              try{
                final result = await ref.read(tscdViewProvider.notifier).addRow();
                _manager.addRow(result);
              }catch(e){
                showInfo(context, e.toString());
              }
            })],
          ),
        ),
      ],
      child: state.when(
        skipLoadingOnReload: true,
        data: (val) {
          return AppTable(
            onChange: (event) async {
              final id = event.row.cells['delete']?.value;
              await update(id, _manager.toModel(event.row));
            },

            onLoaded: (e) {
              _manager = TSCDTableManager(e.stateManager);
              _manager.loadView(val);
              isInit=true;
            },
            columns: [
              AppTableColumn(
                title: ['#', 'stt'],
                width: 35,
                readOnly: true,
                renderer: (re) => AppTableCell.textNum("${re.rowIdx + 1}"),
              ),
              AppTableColumn(title: ['', 'delete'], width: 25, renderer: (re) => AppTableCell.delete(() {
                _manager.setCurrent(re);
                showQuestion(context,onPressed: () async {
                  try{
                    final result = await ref.read(tscdViewProvider.notifier).deleteRow(re.cell.value);
                    if(result!=0){
                      _manager.delete(re);
                    }
                  }catch(e){
                    showInfo(context, e.toString());
                  }
                });

              })),
              AppTableColumn(
                title: ['Mã TS', 'HangHoaId'],
                width: 90,
                padding: 0,
                renderer: (re) {
                  final maHH = ref.read(hangHoaLookupProvider).value?.firstWhereOrNull((e) => e.id == re.cell.value);
                  re.stateManager.notifyListeners();
                  return HangHoaCombobox(
                    noDVT: true,
                    noBorder: true,
                    selected: maHH?.maHH,

                    onChanged: (val) async {
                      final hh = ref.read(hangHoaLookupProvider).value?.firstWhereOrNull((e) => e.maHH == val);
                      re.cell.value = hh?.id;
                      re.stateManager.notifyListeners();
                      final id = re.row.cells['delete']?.value;
                      await update(id, _manager.toModel(re.row),isHH: true);
                    },
                  );
                },
              ),
              AppTableColumn(
                title: ['Mô tả tài sản cố định', 'TenHH'],
                width: 190,
                readOnly: true,
                renderer: (re) => AppTableCell.textBlue(re.cell.value),
              ),
              AppTableColumn(
                title: ['Bộ phận sử dụng', 'BoPhanSD'],
                width: 80,
                isEdit: true,
                titleRenderer: (re) => CustomTitle('Bộ phận\nsử dụng'),
              ),
              AppTableColumn(
                title: ['Nguyên giá (giá mua+chi)', 'NguyenGia'],
                width: 100,
                showFooter: true,
                isEdit: true,
                columnType: ColumnType.num,
                columnAlign: ColumnAlign.right,
                titleRenderer: (re) => CustomTitle('Nguyên giá\n(giá mua+chi)'),
              ),
              AppTableColumn(title: ['Ngày mua', 'NgayMua'], width: 90, isEdit: true, columnAlign: ColumnAlign.center),
              AppTableColumn(
                title: ['Ngày đưa vào sử dụng', 'NgaySD'],
                width: 90,
                isEdit: true,
                columnAlign: ColumnAlign.center,
                titleRenderer: (re) => CustomTitle('Ngày đưa\nvào sử dụng'),
              ),
              AppTableColumn(
                title: ['Số năm phân bổ', 'SoNamPB'],
                width: 70,
                isEdit: true,
                columnType: ColumnType.num,
                columnAlign: ColumnAlign.center,
                titleRenderer: (re) => CustomTitle('Số năm\nphân bổ'),
              ),
              AppTableColumn(
                title: ['Số tháng phân bổ', 'SoThangPB'],
                width: 70,
                readOnly: true,
                columnType: ColumnType.num,
                columnAlign: ColumnAlign.center,
                titleRenderer: (re) => CustomTitle('Số tháng\nphân bổ'),
                renderer: (re) => AppTableCell.textBlue(re.cell.value.toString()).withAlign(Alignment.center),
              ),
              AppTableColumn(
                title: ['Tháng này', 'GiaTriKhauHao'],
                width: 100,
                readOnly: true,
                columnType: ColumnType.num,
                renderer: (re) =>
                    AppTableCell.textBlue(NumHelper.numFormat(re.cell.value)).withAlign(Alignment.centerRight),
              ),
              AppTableColumn(
                title: ['Lũy kế', 'LuyKe'],
                width: 100,
                columnType: ColumnType.num,
                readOnly: true,
                renderer: (re) =>
                    AppTableCell.textBlue(NumHelper.numFormat(re.cell.value)).withAlign(Alignment.centerRight),
              ),
              AppTableColumn(
                title: ['Giá trị còn lại', 'GiaTriConLai'],
                width: 110,
                showFooter: true,
                columnType: ColumnType.num,
                readOnly: true,
                renderer: (re) =>
                    AppTableCell.textBlue(NumHelper.numFormat(re.cell.value)).withAlign(Alignment.centerRight),
              ),
              AppTableColumn(
                title: ['TK chi phí', 'TKChiPhi'],
                width: 70,
                padding: 0,
                titleRenderer: (re) => CustomTitle('TK chi\nphí'),
                renderer: (re) => TaiKhoanChiPhiCombobox(
                  selected: re.cell.value,
                  noBorder: true,
                  onChanged: (val) async {
                    re.cell.value = val;
                    re.stateManager.notifyListeners();
                    final id = re.row.cells['delete']?.value;
                    await update(id, _manager.toModel(re.row));
                  },
                ),
              ),
              AppTableColumn(
                title: ['TK hao mòn', 'TKHaoMon'],
                titleRenderer: (re) => CustomTitle('TK hao\nmòn'),
                width: 70,
                padding: 0,
                renderer: (re) => TaiKhoanHaoMonCombobox(
                  selected: re.cell.value,
                  noBorder: true,
                  onChanged: (val) async {
                    re.cell.value = val;
                    re.stateManager.notifyListeners();
                    final id = re.row.cells['delete']?.value;
                    await update(id, _manager.toModel(re.row));
                  },
                ),
              ),
            ],
            columnGroups: [
              TrinaColumnGroup(
                backgroundColor: Colors.gray.shade100,
                title: 'Giá trị khấu hao',
                fields: ['GiaTriKhauHao', 'LuyKe'],
              ),
            ],
          );
        },
        error: (e, s) => Center(child: Text(e.toString())),
        loading: () => Center(child: CircularProgressIndicator(size: 50)),
      ),
    );
  }
}
