import 'package:erp_client_1/core/constain/app_color.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/data/model/nhanvien_edit_model.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/data/model/nhanvien_request_model.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/presentation/notifier/nhanvien_edit_notifier.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/presentation/notifier/nhanvien_get_edit_notifier.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/presentation/notifier/nhanvien_view_notifier.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/presentation/ui/state/pcgt_table_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/utils/num_helper.dart';
import '../../../../../core/widgets/widget.dart';
import '../notifier/pcgt_view_notifier.dart';

class NhanVienFormDialog extends ConsumerStatefulWidget {
  const NhanVienFormDialog({super.key, this.id});

  final int? id;

  @override
  ConsumerState createState() => _NhanVienFormDialogState();
}

class _NhanVienFormDialogState extends ConsumerState<NhanVienFormDialog> {
  late PCGTTableManager _pcgtTableManager;
  bool isInit = false;
  bool themTiep = false;

  final txtMaNV = TextEditingController();
  final txtHoTen = TextEditingController();
  final txtDienThoai = TextEditingController();
  final txtCCCD = TextEditingController();
  final txtMST = TextEditingController();
  final txtDiaChi = TextEditingController();
  final txtGhiChu = TextEditingController();

  final txtChucDanh = TextEditingController();
  final txtTrinhDo = TextEditingController();
  final txtChuyenMon = TextEditingController();
  final txtLuongCB = TextEditingController(text: '0');
  bool gioiTinh = false;
  bool thoiVu = true;
  bool khongCuTru = true;
  bool coCamKet = false;
  bool theoDoi = true;
  DateTime? ngaySinh;
  DateTime? ngayVaoLam;

  String capitalizeFirstLetter(String input) {
    if (input.isEmpty) return input; // Kiểm tra chuỗi rỗng
    final x = input.split(' ').map((e) => e[0].toUpperCase() + e.substring(1));

    return x.join(' ');
  }

  NhanVienRequestModel _model() {
    return NhanVienRequestModel(
      maNV: txtMaNV.text,
      thoiVu: thoiVu,
      khongCuTru: khongCuTru,
      coCK: coCamKet,
      dienThoai: txtDienThoai.text,
      ghiChu: txtGhiChu.text,
      diaChi: txtDiaChi.text,
      cccd: txtCCCD.text,
      chucDanh: txtChucDanh.text,
      chuyenMon: txtChuyenMon.text,
      luongCB: NumHelper.stringToDouble(txtLuongCB.text),
      mst: txtMST.text,
      ngaySinh: ngaySinh,
      ngayVao: ngayVaoLam,
      tenNV: txtHoTen.text,
      trinhDo: txtTrinhDo.text,
      gioiTinh: gioiTinh,
      isActive: theoDoi,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_){
      ref.read(pcgtViewProvider.notifier).getView(id: widget.id);
      ref.read(nhanVienGetEditProvider.notifier).get(id: widget.id);
    });

    // if (widget.id != null) {
    //   // getEdit(widget.id!);
    //
    //
    // }

    ref.listenManual(nhanVienGetEditProvider, (_, next){
      next.whenOrNull(
        data: (val){
          if(val!=null){
            getEdit(val);
          }
        }
      );

    });


    ref.listenManual(nhanVienEditProvider, (pre, next) {
      next.whenOrNull(
        data: (val) {
          if(val!=null){
            if(widget.id == null){
              ref.read(nhanVienViewProvider.notifier).add(val);
            }else{
              ref.read(nhanVienViewProvider.notifier).updateRow(val);
            }
          }
          if(themTiep){
            clear();
            ref.read(pcgtViewProvider.notifier).getView();
          }else{
            context.pop();
          }

        },
      );
    });
  }

  Future<void> getEdit(NhanVienEditModel nv) async {
    // NhanVienEditModel nv = await ref.read(nhanVienEditProvider.notifier).getById(id);
    // ref.read(pcgtViewProvider.notifier).getView(id: id);
    txtMaNV.text = nv.maNV;
    txtHoTen.text = nv.tenNV ?? '';
    ngaySinh = nv.ngaySinh;
    gioiTinh = nv.gioiTinh;
    txtDienThoai.text = nv.dienThoai ?? '';
    txtCCCD.text = nv.cccd ?? '';
    txtMST.text = nv.mst ?? '';
    txtDiaChi.text = nv.diaChi ?? '';
    txtGhiChu.text = nv.ghiChu ?? '';
    ngayVaoLam = nv.ngayVao;
    txtChucDanh.text = nv.chucDanh ?? "";
    txtTrinhDo.text = nv.trinhDo ?? '';
    txtChuyenMon.text = nv.chuyenMon ?? "";
    thoiVu = nv.thoiVu;
    khongCuTru = nv.khongCuTru;
    coCamKet = nv.coCK;
    theoDoi = nv.isActive;
    txtLuongCB.text = NumHelper.numFormat(nv.luongCB);
    setState(() {});
  }

  void clear(){
    txtMaNV.clear();
    txtHoTen.clear();
    ngaySinh = null;
    gioiTinh = false;
    txtDienThoai.clear();
    txtCCCD.clear();
    txtMST.clear();
    txtDiaChi.clear();
    txtGhiChu.clear();
    ngayVaoLam = null;
    txtChucDanh.clear();
    txtTrinhDo.clear();
    txtChuyenMon.clear();
    thoiVu = true;
    khongCuTru = true;
    coCamKet = false;
    theoDoi = true;
    txtLuongCB.text = '0';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final editState = ref.watch(nhanVienEditProvider);
    final getEditState = ref.watch(nhanVienGetEditProvider);
    return DialogWindows(
      width: 820,
      height: 460,
      title: 'THÔNG TIN NHÂN VIÊN',
      // beforeClose: (){
      //   ref.invalidate(pcgtViewProvider);
      //   context.pop();
      // },
      child: AppLoadingOverlay(
        isLoading: editState.isLoading,
        child: Scaffold(
          footers: [
            Divider(color: AppColor.border,),
            AppBar(
              leading: [
                if(editState.hasError) Text(editState.error.toString(),style: TextStyle(color: Colors.red),)
              ],
              trailing: [
                AppSaveButton(
                  text: 'Lưu & đóng',
                  onPressed: () async {
                    if(isInit){
                      themTiep = false;
                      if (widget.id == null) {
                        ref.read(nhanVienEditProvider.notifier).add(_model(), _pcgtTableManager.toRequest());
                      } else {
                        ref
                            .read(nhanVienEditProvider.notifier)
                            .updateNV(_model(), _pcgtTableManager.toRequest(), widget.id!);
                      }
                    }

                  },
                ),
                if(widget.id==null)AppSaveButton(
                  text: 'Lưu',
                  onPressed: (){
                    themTiep = true;
                    ref.read(nhanVienEditProvider.notifier).add(_model(), _pcgtTableManager.toRequest());
                  },
                )
              ],
            )
          ],
          child: Padding(
            padding: EdgeInsetsGeometry.zero,
            child: Row(
              // spacing: 10,
              children: [
                Expanded(
                  child: FocusTraversalGroup(
                    policy: WidgetOrderTraversalPolicy(),
                    child: AppLoadingOverlay(
                      isLoading: getEditState.isLoading,
                      child: Scaffold(

                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 10,
                            children: [
                              AppRow(
                                columnWidths: {0: 100, 1: 120, 2: 110},
                                items: [
                                  Text('Mã nhân viên').medium,
                                  AppTextField(controller: txtMaNV),
                                  Text('Họ và tên').medium.withPadding(left: 20),
                                  AppTextField(
                                    controller: txtHoTen,
                                    onFieldLeave: () {
                                      txtHoTen.text = capitalizeFirstLetter(txtHoTen.text);
                                    },
                                  ),
                                ],
                              ),
                              AppRow(
                                columnWidths: {0: 100, 1: 120, 2: 110},
                                items: [
                                  Text('Ngày sinh').medium,
                                  AppDateField(
                                    onChanged: (val) {
                                      ngaySinh = val;
                                    },
                                    value: ngaySinh,
                                  ),
                                  Text('Giới tính').medium.withPadding(left: 20),
                                  Checkbox(
                                    state: gioiTinh ? CheckboxState.checked : CheckboxState.unchecked,
                                    onChanged: (val) {
                                      setState(() {
                                        gioiTinh = val.index == 0;
                                      });
                                    },
                                    trailing: Text('Nữ'),
                                  ),
                                ],
                              ),
                              AppRow(
                                columnWidths: {0: 100, 1: 120, 2: 110},
                                items: [
                                  Text('CCCD').medium,
                                  AppTextField(controller: txtCCCD),
                                  Text('MST').medium.withPadding(left: 20),
                                  AppTextField(controller: txtMST),
                                ],
                              ),
                              AppRow(
                                columnWidths: {0: 100},
                                items: [
                                  Text('Địa chỉ').medium,
                                  AppTextField(controller: txtDiaChi),
                                ],
                              ),
                              AppRow(
                                columnWidths: {0: 100, 1: 120, 2: 110},
                                items: [
                                  Text('Điện thoại').medium,
                                  AppTextField(controller: txtDienThoai),
                                  Text('Chức danh').medium.withPadding(left: 20),
                                  AppTextField(controller: txtChucDanh),
                                ],
                              ),
                              AppRow(
                                columnWidths: {0: 100, 1: 120, 2: 110},
                                items: [
                                  Text('Trình độ').medium,
                                  AppTextField(controller: txtTrinhDo),
                                  Text('Chuyên môn').medium.withPadding(left: 20),
                                  AppTextField(controller: txtChuyenMon),
                                ],
                              ),
                              AppRow(
                                columnWidths: {0: 100, 1: 120, 2: 110},

                                items: [
                                  Text('Ngày vào làm').medium,
                                  AppDateField(
                                    value: ngayVaoLam,
                                    onChanged: (val) {
                                      ngayVaoLam = val;
                                    },
                                  ),
                                  Text('Lương cơ bản').medium.withPadding(left: 20),
                                  AppTextField(
                                    isDouble: true,
                                    textAlign: TextAlign.end,
                                    controller: txtLuongCB,
                                    onFieldLeave: () {
                                      txtLuongCB.text = NumHelper.numFormat(txtLuongCB.text);
                                    },
                                  ),
                                ],
                              ),
                              AppRow(
                                columnWidths: {0: 100},
                                items: [
                                  Text('Ghi chú').medium,
                                  AppTextField(controller: txtGhiChu),
                                ],
                              ),
                              AppRow(
                                items: [
                                  Checkbox(
                                    state: thoiVu ? CheckboxState.checked : CheckboxState.unchecked,
                                    onChanged: (val) {
                                      setState(() {
                                        thoiVu = val.index == 0;
                                      });
                                    },
                                    trailing: Text('Thời vụ'),
                                  ),
                                  Visibility(
                                    visible: thoiVu,
                                    child: Checkbox(
                                      state: khongCuTru ? CheckboxState.checked : CheckboxState.unchecked,
                                      onChanged: (val) {
                                        setState(() {
                                          khongCuTru = val.index == 0;
                                          coCamKet = !(val.index == 0);
                                        });
                                      },
                                      trailing: Text('Không cư trú'),
                                    ),
                                  ),
                                  Visibility(
                                    visible: !khongCuTru && thoiVu,
                                    child: Checkbox(
                                      state: coCamKet ? CheckboxState.checked : CheckboxState.unchecked,
                                      onChanged: (val) {
                                        setState(() {
                                          coCamKet = val.index == 0;
                                        });
                                      },
                                      trailing: Text('Có cam kết 08'),
                                    ),
                                  ),
                                ],
                              ),
                              Checkbox(
                                state: theoDoi ? CheckboxState.checked : CheckboxState.unchecked,
                                onChanged: (val) {
                                  setState(() {
                                    theoDoi = val.index == 0;
                                  });
                                },
                                trailing: Text('Đang làm việc'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColor.background,
                      border: Border(left: BorderSide(color: AppColor.border))
                    ),

                    padding: EdgeInsets.all(0),
                    child: Consumer(
                      builder: (context, ref, child) {
                        final state = ref.watch(pcgtViewProvider);
                        return state.when(
                          data: (val) {
                            return AppTable(
                              onLoaded: (e) {
                                _pcgtTableManager = PCGTTableManager(e.stateManager);
                                _pcgtTableManager.loadView(val);
                                isInit = true;
                              },
                              columns: [
                                AppTableColumn(
                                  title: ['', 'stt'],
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
                                  showFooter: true,
                                  columnType: ColumnType.num,
                                  columnAlign: ColumnAlign.right,
                                  isEdit: true,
                                  width: 90,
                                ),
                              ],
                            );
                          },
                          error: (e, s) => Center(child: Text(e.toString())),
                          loading: () => Center(child: CircularProgressIndicator(size: 50)),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
