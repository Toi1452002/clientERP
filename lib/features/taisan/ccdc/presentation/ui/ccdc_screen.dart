
import 'package:collection/collection.dart';
import 'package:erp_client_1/core/widgets/widget.dart';
import 'package:erp_client_1/features/danhmuc/hanghoa/presentation/ui/state/hanghoa_lookup_provider.dart';
import 'package:erp_client_1/features/danhmuc/hanghoa/presentation/ui/widget/hanghoa_combobox.dart';
import 'package:erp_client_1/features/danhmuc/taikhoan/presentation/ui/widget/taikhoan_chiphi_combobox.dart';
import 'package:erp_client_1/features/taisan/ccdc/presentation/ui/state/ccdc_table_manager.dart';
import 'package:erp_client_1/features/taisan/ccdc/data/model/ccdc_update_model.dart';
import 'package:erp_client_1/features/taisan/ccdc/presentation/notifier/ccdc_view_notifier.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trina_grid/trina_grid.dart';

import '../../../../../core/utils/num_helper.dart';
import '../../../../danhmuc/taikhoan/presentation/ui/widget/taikhoan_haomon_combobox.dart';

class CCDCScreen extends ConsumerStatefulWidget {
  const CCDCScreen({super.key});

  @override
  ConsumerState createState() => _CCDCScreenState();
}

class _CCDCScreenState extends ConsumerState<CCDCScreen> {
  late CCDCTableManager _manager;
  DateTime? tuNgay;
  bool isInit=false;
  int idUpdate = 0;
  bool isTinhToan = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ref.listenManual(ccdcViewProvider, (_, next) {
      if(isInit){
        next.whenOrNull(
          data: (val) {
            tuNgay = ref.read(ccdcViewProvider.notifier).ngayDau();
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

  Future<void> update(int id, CCDCUpdateModel model, {bool isHH = false}) async {
    try {
      idUpdate = id;
      await ref.read(ccdcViewProvider.notifier).updateCCDC(id, model, isHH: isHH);
    } catch (e) {
      await showInfo(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(ccdcViewProvider);
    return Scaffold(
      footers: [AppFooter()],
      headers: [
        AppHeader(title: "Bảng phân bổ CCDC"),
        AppContainerBorder(
          child: AppBar(
            leading: [AppTngayDngay(tuNgay: tuNgay, onSubmit: (a, b) async {
              try{
                isTinhToan = true;
                await ref.read(ccdcViewProvider.notifier).tinhToan(b);
              }catch(e){
                showInfo(context, e.toString());
              }
            })],
            trailing: [AppNewButton(text: "Thêm dòng", onPressed: () async{
              try{
                final result = await ref.read(ccdcViewProvider.notifier).addRow();
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
              _manager = CCDCTableManager(e.stateManager);
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
                    final result = await ref.read(ccdcViewProvider.notifier).deleteRow(re.cell.value);
                    if(result!=0){
                      _manager.delete(re);
                    }
                  }catch(e){
                    showInfo(context, e.toString());
                  }
                });

              })),
              AppTableColumn(
                title: ['Mã DC', 'HangHoaId'],
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
                title: ['Tên công cụ dụng cụ', 'TenHH'],
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
                title: ['Số lượng', 'SoLuong'],
                width: 40,
                isEdit: true,
                columnAlign: ColumnAlign.center,
                columnType: ColumnType.num,
                titleRenderer: (re) => CustomTitle('Số\nlượng'),
              ),
              AppTableColumn(
                title: ['Giá trị', 'GiaTri'],
                width: 100,
                showFooter: true,
                isEdit: true,
                columnType: ColumnType.num,
                columnAlign: ColumnAlign.right,
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
                title: ['Số tháng phân bổ', 'SoThangPB'],
                width: 70,
                isEdit: true,
                columnType: ColumnType.num,
                columnAlign: ColumnAlign.center,
                titleRenderer: (re) => CustomTitle('Số tháng\nphân bổ'),
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
