import 'package:erp_client_1/features/tienluong/bangluong/data/model/bangluong_update_model.dart';
import 'package:erp_client_1/features/tienluong/bangluong/data/repository/bangluong_repository.dart';
import 'package:erp_client_1/features/tienluong/bangluong/presentation/notifier/bangluong_view_notifier.dart';
import 'package:erp_client_1/features/tienluong/bangluong/presentation/ui/dialog/pcgt_chitiet_dialog.dart';
import 'package:erp_client_1/features/tienluong/bangluong/presentation/ui/state/bangluong_table_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../../../core/utils/num_helper.dart';
import '../../../../../core/widgets/widget.dart';
import '../../../../danhmuc/nhanvien/presentation/ui/state/nhanvien_lookup_state.dart';
import '../../../../danhmuc/nhanvien/presentation/ui/widget/nhanvien_combobox.dart';

class BangLuongScreen extends ConsumerStatefulWidget {
  const BangLuongScreen({super.key});

  @override
  ConsumerState createState() => _BangLuongScreenState();
}

class _BangLuongScreenState extends ConsumerState<BangLuongScreen> {
  int thang = DateTime.now().month;
  final txtNam = TextEditingController(text: (DateTime.now().year).toString());

  late BangLuongTableManager _manager;

  bool isInit = false;
  int idUpdate = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ref.listenManual(bangLuongViewNotifier, (_, next) {
      if (isInit) {
        next.whenOrNull(
          data: (val) {

            if(idUpdate==0){
              _manager.loadView(val);
            }else{
              if(val.indexWhere((e)=>e.id == idUpdate)!=-1){
                _manager.updateRow(idUpdate, val.firstWhere((e)=>e.id ==idUpdate));
              }
            }
            idUpdate=0;
            _manager.closeLoading();
          },
          error: (e, s) {
            showInfo(context, e.toString());
            _manager.closeLoading();
            idUpdate=0;
          },
          loading: () {
            _manager.showLoading();
            idUpdate=0;
          },
        );
      }
    });
  }

  Future<void> updateCell(int id, BangLuongUpdateModel model, String field) async{
    try{
      idUpdate = id;
      await ref.read(bangLuongViewNotifier.notifier).updateCell(model, id, field);
    }catch(e){
      await showInfo(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bangLuongViewNotifier);
    return Scaffold(
      footers: [AppFooter()],
      headers: [
        AppHeader(title: "Bảng thanh toán lương"),
        AppContainerBorder(
          child: AppBar(
            trailing: [
              AppNewButton(
                text: "Thêm dòng",
                onPressed: () async {
                  // try {
                    await ref
                        .read(bangLuongViewNotifier.notifier)
                        .addRow(thang, int.tryParse(txtNam.text) ?? DateTime.now().year);
                  // } catch (e) {
                  //   showInfo(context, e.toString());
                  // }
                },
              ),
            ],
            leading: [
              Text("Tháng").medium,
              SizedBox(
                width: 60,
                child: AppCombobox(
                  enabledClear: false,
                  items: [
                    for (int i = 1; i <= 12; i++) ComboboxItem(value: i, text: [i.toString()]),
                  ],
                  value: thang,
                  onChanged: (val) {
                    setState(() {
                      thang = val;
                    });
                  },
                ),
              ),
              // Gap(10),
              AppTextField(isNumber: true, controller: txtNam).sized(width: 60),
              Gap(10),
              OutlineButton(
                child: Text("Thực hiện"),
                onPressed: () {
                  // _manager.changedThang(thang, txtNam.text);
                  ref.read(bangLuongViewNotifier.notifier).get(thang, int.tryParse(txtNam.text) ?? DateTime.now().year);
                },
              ),
            ],
          ),
        ),
      ],
      child: state.when(
        skipLoadingOnReload: true,
        skipLoadingOnRefresh: false,
        data: (val) {
          return AppTable(
            onRowDoubleTap: (re){
              final maNV = re.row.cells['MaNV']?.value;
              final field = re.cell.column.field;
              if(['PC1', 'PC2', 'GT', 'BH'].contains(field)) {
                showAppDialog(context, child: PCGTChiTietDialog(maNV: maNV, maPC: field));
              }
            },
            columnHeight: 40,
            onLoaded: (e) {
              _manager = BangLuongTableManager(e.stateManager);
              _manager.loadView(val);
              isInit = true;
            },
            onChange: (e) async{
              final id = e.row.cells['delete']?.value;
              await updateCell(id, _manager.toModel(e.row), e.column.field);
            },
            columns: [
              AppTableColumn(
                title: ['#', 'stt'],
                frozen: true,
                width: 35,
                readOnly: true,
                renderer: (re) => AppTableCell.textNum("${re.rowIdx + 1}"),
              ),
              AppTableColumn(
                title: ['', 'delete'],
                width: 25,
                frozen: true,
                renderer: (re) => AppTableCell.delete(() {
                  _manager.setCurrent(re);
                  showQuestion(context,onPressed: () async{
                    final result = await ref.read(bangLuongViewNotifier.notifier).delete(re.cell.value);
                    if(result>0){
                      _manager.delete(re);
                    }
                  });
                }),
              ),
              AppTableColumn(
                title: ['Mã NV', 'MaNV'],
                frozen: true,
                width: 80,
                renderer: (re) {
                  return NhanVienCombobox(
                    selected: re.cell.value,
                    noBorder: true,
                    enabledClear: false,
                    onChanged: (val) async {
                      re.cell.value = val;
                      final tenNV = ref.read(nhanVienLookupProvider).value?.firstWhere((e) => e.maNV == val).tenNV;
                      re.row.cells['TenNV']?.value = tenNV;
                      re.stateManager.notifyListeners();

                      try {
                        final id = re.row.cells['delete']?.value;
                        await updateCell(id, _manager.toModel(re.row), "MaNV");
                      } catch (e) {
                        showInfo(context, e.toString());
                      }
                    },
                  );
                },
              ),
              AppTableColumn(
                title: ['Tên nhân viên', 'TenNV'],
                frozen: true,
                width: 150,
                readOnly: true,
                renderer: (re) => AppTableCell.textBlue(re.cell.value),
              ),
              AppTableColumn(
                title: ['Chức vụ', 'ChucVu'],
                width: 80,
                readOnly: true,
                renderer: (re) => AppTableCell.textBlue(re.cell.value),
              ),
              AppTableColumn(
                title: ['Lương CB', 'LuongCoBan'],
                width: 80,
                showFooter: true,
                columnType: ColumnType.num,
                isEdit: true,
                titleRenderer: (re) => CustomTitle('Lương\ncơ bản'),
                columnAlign: ColumnAlign.right,
              ),
              AppTableColumn(
                title: ['Phụ cấp có BH', 'PC1'],
                width: 80,
                showFooter: true,
                readOnly: true,
                columnType: ColumnType.num,
                renderer: (re) =>
                    AppTableCell.textRed(NumHelper.numFormat(re.cell.value)).withAlign(Alignment.centerRight),
                titleRenderer: (re) {
                  return CustomTitle('Phụ cấp\ncó BH');
                },
              ),
              AppTableColumn(
                title: ['Phụ cấp không BH', 'PC2'],
                width: 80,
                showFooter: true,
                readOnly: true,

                columnType: ColumnType.num,
                renderer: (re) =>
                    AppTableCell.textRed(NumHelper.numFormat(re.cell.value)).withAlign(Alignment.centerRight),
                titleRenderer: (re) {
                  return CustomTitle('Phụ cấp\nkhông BH');
                },
              ),
              AppTableColumn(
                title: ['Lương BHXH', 'LuongBHXH'],
                width: 80,
                showFooter: true,
                readOnly: true,
                columnType: ColumnType.num,
                renderer: (re) =>
                    AppTableCell.textBlue(NumHelper.numFormat(re.cell.value)).withAlign(Alignment.centerRight),
                titleRenderer: (re) => CustomTitle('Lương\nBHXH'),
              ),
              AppTableColumn(
                title: ['Bảo hiểm nhân viên', 'BH'],
                width: 100,
                showFooter: true,
                readOnly: true,
                columnType: ColumnType.num,
                renderer: (re) =>
                    AppTableCell.textRed(NumHelper.numFormat(re.cell.value)).withAlign(Alignment.centerRight),
                titleRenderer: (re) => CustomTitle('Bảo hiểm\nnhân viên'),
              ),
              AppTableColumn(
                title: ['Ngày công', 'NgayCong'],
                width: 50,
                columnAlign: ColumnAlign.center,
                isEdit: true,
                columnType: ColumnType.num,
                titleRenderer: (re) => CustomTitle('Ngày\ncông'),
              ),
              AppTableColumn(
                title: ['Lương thời gian', 'LuongThoiGian'],
                width: 80,
                showFooter: true,
                readOnly: true,
                columnType: ColumnType.num,
                renderer: (re) =>
                    AppTableCell.textBlue(NumHelper.numFormat(re.cell.value)).withAlign(Alignment.centerRight),
                titleRenderer: (re) => CustomTitle('Lương thời\ngian'),
              ),

              AppTableColumn(
                title: ['Tong thu nhap', 'TongThuNhap'],
                width: 100,
                readOnly: true,
                showFooter: true,
                columnType: ColumnType.num,
                renderer: (re) =>
                    AppTableCell.textBlue(NumHelper.numFormat(re.cell.value)).withAlign(Alignment.centerRight),
                titleRenderer: (re) => CustomTitle('Tổng thu\nnhập'),
              ),
              AppTableColumn(
                title: ['Các khoản\ngiảm', 'GT'],
                width: 80,
                readOnly: true,
                showFooter: true,
                columnType: ColumnType.num,
                renderer: (re) =>
                    AppTableCell.textRed(NumHelper.numFormat(re.cell.value)).withAlign(Alignment.centerRight),
                titleRenderer: (re) => CustomTitle('Giảm trừ\nTNCN'),
              ),
              AppTableColumn(
                title: ['Thu nhập chịu thuế', 'TNchiuThue'],
                width: 120,
                readOnly: true,
                showFooter: true,
                columnType: ColumnType.num,
                renderer: (re) =>
                    AppTableCell.textBlue(NumHelper.numFormat(re.cell.value)).withAlign(Alignment.centerRight),
                titleRenderer: (re) => CustomTitle('Thu nhập\nchịu thuế'),
              ),
              AppTableColumn(
                title: ['Thu nhập\ntính thuế', 'TNtinhThue'],
                width: 80,
                readOnly: true,
                showFooter: true,
                columnType: ColumnType.num,
                renderer: (re) =>
                    AppTableCell.textBlue(NumHelper.numFormat(re.cell.value)).withAlign(Alignment.centerRight),
                titleRenderer: (re) => CustomTitle('Thu nhập\ntính thuế'),
              ),
              AppTableColumn(
                title: ['Thuế\nTNCN', 'ThueCN'],
                width: 80,
                showFooter: true,
                readOnly: true,
                columnType: ColumnType.num,
                renderer: (re) =>
                    AppTableCell.textBlue(NumHelper.numFormat(re.cell.value)).withAlign(Alignment.centerRight),
                titleRenderer: (re) => CustomTitle('Thuế\nTNCN'),
              ),
              AppTableColumn(
                title: ['Thực lãnh', 'ThucLanh'],
                width: 85,
                showFooter: true,
                readOnly: true,
                columnType: ColumnType.num,
                renderer: (re) =>
                    AppTableCell.textBlue(NumHelper.numFormat(re.cell.value)).withAlign(Alignment.centerRight),
              ),
              AppTableColumn(
                title: ['Tạm ứng', 'TamUng'],
                width: 80,
                showFooter: true,
                isEdit: true,
                columnType: ColumnType.num,
                columnAlign: ColumnAlign.right,
              ),
              AppTableColumn(
                title: ['Còn lại', 'ConLai'],
                width: 80,
                showFooter: true,
                readOnly: true,
                columnType: ColumnType.num,
                renderer: (re) =>
                    AppTableCell.textBlue(NumHelper.numFormat(re.cell.value)).withAlign(Alignment.centerRight),
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
