import 'package:erp_client_1/core/constain/app_color.dart';
import 'package:erp_client_1/core/widgets/app_header.dart';
import 'package:erp_client_1/core/widgets/app_table/app_table.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/presentation/ui/state/nhanvien_lookup_state.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/presentation/ui/widget/nhanvien_combobox.dart';
import 'package:erp_client_1/features/tienluong/chamcong/data/model/update_socong_model.dart';
import 'package:erp_client_1/features/tienluong/chamcong/presentation/notifier/chamcong_notifier.dart';
import 'package:erp_client_1/features/tienluong/chamcong/presentation/ui/state/chamcong_table_manager.dart';
import 'package:erp_client_1/features/tienluong/chamcong/presentation/ui/widget/ma_chamcong_combobox.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/widgets/widget.dart';

class ChamCongScreen extends ConsumerStatefulWidget {
  const ChamCongScreen({super.key});

  @override
  ConsumerState createState() => _ChamCongScreenState();
}

class _ChamCongScreenState extends ConsumerState<ChamCongScreen> {
  int thang = DateTime.now().month;
  final txtNam = TextEditingController(text: (DateTime.now().year).toString());
  late ChamCongTableManager _manager;

  bool isInit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

      ref.listenManual(chamCongProvider, (_, next) {
        if(isInit){
          next.whenOrNull(
              data: (val) {

                _manager.loadView(val);
                _manager.closeLoading();
              },
              error: (e, s) {
                showInfo(context, e.toString());
                _manager.closeLoading();
              },
              loading: (){
                _manager.showLoading();
              }
          );
        }

      });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chamCongProvider);
    return Scaffold(
      footers: [AppFooter()],
      headers: [
        AppHeader(title: "Bảng chấm công"),
        AppContainerBorder(
          child: AppBar(
            trailing: [
              AppNewButton(
                text: "Thêm dòng",
                onPressed: () {
                  ref.read(chamCongProvider.notifier).addRow(thang, int.tryParse(txtNam.text) ?? DateTime.now().year);
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
                  _manager.changedThang(thang, txtNam.text);
                  ref.read(chamCongProvider.notifier).get(thang, int.tryParse(txtNam.text) ?? DateTime.now().year);
                },
              ),
            ],
          ),
        ),
      ],
      child: state.when(
        skipLoadingOnReload: true,
        data: (val) {
          return AppTable(
            onLoaded: (e) {
              _manager = ChamCongTableManager(e.stateManager);
              _manager.loadView(val);
              isInit = true;
            },
            columnHeight: 40,
            columns: [
              AppTableColumn(
                title: ['#', 'stt'],
                width: 35,
                frozen: true,
                readOnly: true,
                renderer: (re) => AppTableCell.textNum("${re.rowIdx + 1}"),
              ),
              AppTableColumn(
                title: ['', 'delete'],
                width: 25,
                renderer: (re) => AppTableCell.delete(() {
                  _manager.setCurrent(re);
                  showQuestion(
                    context,
                    onPressed: () async {
                      try {
                        final result = await ref.read(chamCongProvider.notifier).delete(re.cell.value);
                        if (result > 0) {
                          _manager.delete(re);
                        }
                      } catch (e) {
                        showInfo(context, e.toString());
                      }
                    },
                  );
                }),
                frozen: true,
              ),
              AppTableColumn(
                title: ['Mã NV', 'MaNV'],
                frozen: true,
                padding: 0,
                width: 90,
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
                        await ref.read(chamCongProvider.notifier).updateMaNV(val, id);
                      } catch (e) {
                        showInfo(context, e.toString());
                      }
                    },
                  );
                },
              ),
              AppTableColumn(title: ['Tên nhân viên', 'TenNV'], width: 140, frozen: true, readOnly: true),
              AppTableColumn(
                title: ['Cộng', 'TongCong'],
                width: 70,
                columnType: ColumnType.num,
                columnAlign: ColumnAlign.center,
                frozen: true,
                readOnly: true,
              ),
              ...[
                for (int i = 1; i <= 31; i++)
                  AppTableColumn(
                    titleRenderer: (re) {
                      final n = int.tryParse(re.column.title) ?? -1;
                      if (n == -1) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.gray.shade100,
                            border: Border(right: BorderSide(color: AppColor.border300)),
                          ),
                        );
                      }
                      return Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.gray.shade100,
                          border: Border(right: BorderSide(color: AppColor.border300)),
                        ),
                        child: Basic(
                          subtitleAlignment: Alignment.center,
                          titleAlignment: Alignment.center,
                          title: Text('$n'),
                          subtitle: Text(getThu(thang, txtNam.text, n)),
                        ),
                      );
                    },
                    title: [ckNgay(i, thang, txtNam.text) ? '$i' : '', '$i'],

                    width: 60,
                    padding: 0,
                    renderer: (re) {
                      if (re.column.title == '') return SizedBox();
                      // return Text(re.cell.value);
                      return MaChamCongCombobox(
                        onTap: (){
                          _manager.setCurrent(re);
                        },
                        selectedValue: re.cell.value,
                        onChanged: (val) async {
                          re.cell.value = val;
                          final bangCongId = re.row.cells['delete']?.value;
                          final date = DateTime(int.tryParse(txtNam.text) ?? DateTime.now().year, thang, i);
                          final result = await ref
                              .read(chamCongProvider.notifier)
                              .updateSoCong(UpdateSoCongModel(bangCongId: bangCongId, ngay: date, kyHieu: val));
                          re.row.cells['TongCong']?.value = result;
                          re.stateManager.notifyListeners();
                        },
                      );
                      // return SizedBox();
                      // return AppCombobox(
                      //   value: re.cell.value == '' ? null : re.cell.value,
                      //   noSearch: true,
                      //   noBorder: true,
                      //   // items: _controller.lstMaCC.map((e) => ComboboxItem(value: e, text: [e])).toList(),
                      //   onChanged: (val) {
                      //     re.cell.value = val;
                      //     _controller.onChanged(re, selectThang, txtNam.text);
                      //     re.stateManager.notifyListeners();
                      //   },
                      // );
                    },
                  ),
              ],
            ],
          );
        },
        error: (e, s) => Center(child: Text(e.toString())),
        loading: () => Center(child: CircularProgressIndicator(size: 50)),
      ),
    );
  }

  bool ckNgay(int ngay, int thang, String nam) {
    final date = DateTime(int.parse(nam), thang + 1, 0).day;
    return date >= ngay;
  }

  String getThu(int thang, String nam, int ngay) {
    final data = DateTime(int.tryParse(nam) ?? DateTime.now().year, thang, ngay).weekday + 1;
    return data == 8 ? "CN" : "T$data";
  }
}
