import 'package:erp_client_1/core/constain/app_color.dart';
import 'package:erp_client_1/core/widgets/app_alert.dart';
import 'package:erp_client_1/core/widgets/app_button.dart';
import 'package:erp_client_1/core/widgets/app_combobox.dart';
import 'package:erp_client_1/core/widgets/app_container_border.dart';
import 'package:erp_client_1/core/widgets/app_dialog.dart';
import 'package:erp_client_1/core/widgets/app_header.dart';
import 'package:erp_client_1/core/widgets/app_select_date.dart';
import 'package:erp_client_1/core/widgets/app_table/app_table.dart';
import 'package:erp_client_1/core/widgets/app_tngay_dngay.dart';
import 'package:erp_client_1/features/danhmuc/taikhoan/presentation/ui/widget/taikhoan_xl0_combobox.dart';
import 'package:erp_client_1/features/ketchuyen/presentation/notifier/ketchuyen_view_notifier.dart';
import 'package:erp_client_1/features/ketchuyen/presentation/ui/state/ketchuyen_table_manager.dart';
import 'package:erp_client_1/features/ketchuyen/presentation/ui/widget/buttoan_combobox.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class KetChuyenScreen extends ConsumerStatefulWidget {
  const KetChuyenScreen({super.key});

  @override
  ConsumerState createState() => _KetChuyenScreenState();
}

class _KetChuyenScreenState extends ConsumerState<KetChuyenScreen> {
  bool xemBKe = false;
  int ketChuyen = 1;
  String? butToan;

  late KetChuyenTableManager _manager;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(ketChuyenViewProvider);
    return DialogWindows(
      width: 1100,
      height: 600,
      title: "Bút toán kết chuyển",
      child: Scaffold(
        footers: [
          // Divider(color: AppColor.border),
          AppContainerBorder(
            child: AppBar(
              trailing: [
                Checkbox(
                  state: xemBKe ? CheckboxState.checked : CheckboxState.unchecked,
                  onChanged: (val) {
                    setState(() {
                      xemBKe = val.index == 0;
                    });
                  },
                  leading: Text("Xem bảng kê"),
                ),
              ],
            ),
          ),
        ],
        headers: [
          if (!xemBKe)
            AppContainerBorder(
              child: AppBar(
                leading: [
                  SizedBox(
                    width: 230,
                    child: AppCombobox(
                      value: ketChuyen,
                      enabledClear: false,
                      onChanged: (val) {
                        setState(() {
                          ketChuyen = val;
                        });
                      },
                      items: [
                        ComboboxItem(value: 0, text: ['Kết chuyển thủ công']),
                        ComboboxItem(value: 1, text: ['Kết chuyển theo trình tự']),
                        ComboboxItem(value: 2, text: ['Kết chuyển tự động']),
                      ],
                    ),
                  ),
                  Gap(5),
                  Builder(
                    builder: (context) {
                      if (ketChuyen == 0) {
                        return AppNewButton(
                          onPressed: () async {
                            try {
                              final id = await ref.read(ketChuyenViewProvider.notifier).addRow();
                              if (id != 0) {
                                _manager.add(id);
                              }
                            } catch (e) {
                              if (context.mounted) showInfo(context, e.toString());
                            }
                          },
                          text: 'Thêm bút toán',
                        );
                      } else if (ketChuyen == 1) {
                        return SizedBox(
                          width: 340,
                          child: ButToanCombobox(
                            onChanged: (val) {
                              setState(() {
                                butToan = val;
                              });
                            },
                            selected: butToan,
                          ),
                        );
                      } else {
                        return Text(
                          '(T)02:Lương NV,03:TSCĐ,04:CCDC,05:Giá vốn;(Q)06:GTGC;(N)09:DT,10:CP,12:KQKD',
                          style: TextStyle(fontSize: 12, color: Colors.gray),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),

          AppContainerBorder(
            child: AppBar(
              leading: [
                Builder(
                  builder: (context) {
                    if (xemBKe) {
                      return AppTngayDngay(
                        onSubmit: (t, d) {
                          ref.read(ketChuyenViewProvider.notifier).get(t, d);
                        },
                      );
                    } else {
                      if (ketChuyen == 0) {
                        return SizedBox();
                      } else {
                        return AppSelectDate(
                          text: "Kết chuyển",
                          onSubmit: (t, d, type) {
                            if (ketChuyen == 1 && butToan != null) {
                              String bt = butToan!.substring(0, 2);
                              ref.read(ketChuyenViewProvider.notifier).ketChuyenTrinhTu(t, d, bt);
                            } else if (ketChuyen == 2) {
                              ///Ket chuyen Tu dong
                              if (type == 0) {
                                ref.read(ketChuyenViewProvider.notifier).ketChuyenTheoThang(t, d);
                              } else if (type == 2) {
                                ref.read(ketChuyenViewProvider.notifier).ketChuyenTheoNam(t, d);
                              }
                            }
                          },
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ],
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 0),
          child: state.when(
            data: (val) {
              return AppTable(
                onChange: (re) async {
                  try {
                    final id = re.row.cells['delete']?.value;
                    await ref.read(ketChuyenViewProvider.notifier).updateKetChuyen(_manager.toModel(re.row), id);
                  } catch (e) {
                    re.cell.value = re.oldValue;
                    if (context.mounted) showInfo(context, e.toString());
                  }
                },
                onLoaded: (e) {
                  _manager = KetChuyenTableManager(e.stateManager);
                  _manager.loadView(val);
                },
                columns: [
                  AppTableColumn(
                    title: ['#', 'stt'],
                    width: 35,
                    readOnly: true,
                    showFilter: false,
                    renderer: (re) => AppTableCell.textNum("${re.rowIdx + 1}"),
                  ),
                  AppTableColumn(
                    title: ['', 'delete'],
                    width: 25,
                    showFilter: false,
                    renderer: (re) => AppTableCell.delete(() {
                      _manager.setCurrent(re);
                      showQuestion(
                        context,
                        onPressed: () async {
                          final result = await ref.read(ketChuyenViewProvider.notifier).delete(re.cell.value);
                          if (result != 0) {
                            _manager.delete(re);
                          }
                        },
                      );
                    }),
                  ),
                  AppTableColumn(
                    title: ['Bút toán', 'ButToan'],
                    padding: 0,
                    width: 80,
                    renderer: (re) {
                      return ButToanCombobox(
                        isInTable: true,
                        selected: re.cell.value,
                        onChanged: (val) async {
                          re.cell.value = val;
                          try {
                            final id = re.row.cells["delete"]?.value;
                            await ref
                                .read(ketChuyenViewProvider.notifier)
                                .updateKetChuyen(_manager.toModel(re.row), id);
                          } catch (e) {
                            showInfo(context, e.toString());
                          }
                          re.stateManager.notifyListeners();
                        },
                      );
                    },
                  ),
                  AppTableColumn(
                    title: ['Ngày ghi sổ', 'Ngay'],
                    width: 100,
                    isEdit: true,
                    columnAlign: ColumnAlign.center,
                  ),
                  AppTableColumn(title: ['Chứng từ', 'SoCT'], isEdit: true, width: 120),
                  AppTableColumn(
                    title: ['Ngày CT', 'NgayCT'],
                    width: 90,
                    isEdit: true,
                    columnAlign: ColumnAlign.center,
                  ),
                  AppTableColumn(title: ['Diễn giải', 'DienGiai'], isEdit: true, width: 320),
                  AppTableColumn(
                    title: ['TK nợ', 'TKNo'],
                    width: 70,
                    padding: 0,
                    renderer: (re) {
                      return TaiKhoanXL0Combobox(
                        isInTable: true,
                        selected: re.cell.value,
                        onChanged: (val) async {
                          re.cell.value = val;
                          try {
                            final id = re.row.cells["delete"]?.value;
                            await ref
                                .read(ketChuyenViewProvider.notifier)
                                .updateKetChuyen(_manager.toModel(re.row), id);
                          } catch (e) {
                            showInfo(context, e.toString());
                          }
                          re.stateManager.notifyListeners();
                        },
                      );
                    },
                  ),
                  AppTableColumn(
                    title: ['TK có', 'TKCo'],
                    width: 70,
                    padding: 0,
                    renderer: (re) {
                      return TaiKhoanXL0Combobox(
                        selected: re.cell.value,
                        isInTable: true,
                        onChanged: (val) async {
                          re.cell.value = val;
                          try {
                            final id = re.row.cells["delete"]?.value;
                            await ref
                                .read(ketChuyenViewProvider.notifier)
                                .updateKetChuyen(_manager.toModel(re.row), id);
                          } catch (e) {
                            showInfo(context, e.toString());
                          }
                          re.stateManager.notifyListeners();
                        },
                      );
                    },
                  ),
                  AppTableColumn(
                    title: ['Số phát sinh', 'SoPS'],
                    width: 120,
                    showFooter: true,
                    columnAlign: ColumnAlign.right,
                    columnType: ColumnType.num,
                    isEdit: true,
                  ),
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
