import 'package:erp_client_1/core/constain/app_color.dart';
import 'package:erp_client_1/features/danhmuc/khach/data/model/khach_edit_model.dart';
import 'package:erp_client_1/features/danhmuc/khach/presentation/notifier/khach_edit_notifier.dart';
import 'package:erp_client_1/features/danhmuc/khach/presentation/notifier/khach_get_edit_notifier.dart';
import 'package:erp_client_1/features/danhmuc/khach/presentation/notifier/khach_view_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../../../core/widgets/widget.dart';
import '../../data/model/khach_request_model.dart';

class KhachFormDialog extends ConsumerStatefulWidget {
  final int? id;

  const KhachFormDialog({super.key, this.id});

  @override
  ConsumerState createState() => _KhachFormDialogState();
}

class _KhachFormDialogState extends ConsumerState<KhachFormDialog> {
  String loaiKH = "KH";
  bool theoDoi = true;
  final txtMaKH = TextEditingController();
  final txtTenKH = TextEditingController();
  final txtDiaChi = TextEditingController();
  final txtDienThoai = TextEditingController();
  final txtDiDong = TextEditingController();
  final txtFax = TextEditingController();
  final txtEmail = TextEditingController();
  final txtMST = TextEditingController();
  final txtSTK = TextEditingController();
  final txtNganHang = TextEditingController();
  final txtGhiChu = TextEditingController();

  bool themTiep = false;



  Future<void> loadKhach(KhachEditModel result) async {
    txtMaKH.text = result.maKH;
    txtTenKH.text = result.tenKH;
    txtDiaChi.text = result.diaChi ?? '';
    txtDienThoai.text = result.dienThoai ?? "";
    txtDiDong.text = result.diDong ?? "";
    txtFax.text = result.fax ?? "";
    txtEmail.text = result.email ?? "";
    txtMST.text = result.mst ?? "";
    txtSTK.text = result.soTK ?? "";
    txtNganHang.text = result.nganHang ?? "";
    txtGhiChu.text = result.ghiChu ?? "";
    loaiKH = result.loaiKH ?? "";
    theoDoi = result.isActive;
    setState(() {});
  }

  KhachRequestModel _requestModel() => KhachRequestModel(
    maKH: txtMaKH.text.trim(),
    tenKH: txtTenKH.text.trim(),
    email: txtEmail.text.trim(),
    mst: txtMST.text,
    diaChi: txtDiaChi.text,
    ghiChu: txtGhiChu.text,
    dienThoai: txtDienThoai.text,
    diDong: txtDiDong.text,
    fax: txtFax.text,
    loaiKH: loaiKH,
    nganHang: txtNganHang.text,
    soTK: txtSTK.text,
    isActive: theoDoi,
  );

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_){
      ref.read(khachGetEditProvider.notifier).get(id:widget.id);
    });

    ref.listenManual(khachGetEditProvider, (_,next){
      next.whenOrNull(
        data: (val){
          if(val!=null){
            loadKhach(val);
          }
        },
        error: (e,s){
          showInfo(context, e.toString());
        }
      );
    });

    ref.listenManual(khachEditProvider, (pre, next) {
      next.whenOrNull(
        data: (val) {
          if(val!=null){
            if(widget.id==null){
              ref.read(khachViewProvider.notifier).add(val);
            }else{
              ref.read(khachViewProvider.notifier).updateRow(val);
            }
          }

          if(themTiep){
            clear();
          }else{
            context.pop();
          }

        },
      );
    });
  }

  void clear (){
    txtMaKH.clear();
    txtTenKH.clear();
    txtDiaChi.clear();
    txtDienThoai.clear();
    txtDiDong.clear();
    txtFax.clear();
    txtEmail.clear();
    txtMST.clear();
    txtSTK.clear();
    txtNganHang.clear();
    txtGhiChu.clear();
    loaiKH = "KH";
    theoDoi = true;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(khachEditProvider);
    final getState = ref.watch(khachGetEditProvider);
    return DialogWindows(
      width: 600,
      height: 400,
      title: 'THÔNG TIN KHÁCH HÀNG',
      child: AppLoadingOverlay(
        isLoading: state.isLoading || getState.isLoading,
        child: Scaffold(
          footers: [
            Divider(color: AppColor.border300,),
            AppBar(
              leading: [
                if(state.hasError) Text(state.error.toString(),style: TextStyle(color: Colors.red),)
              ],
              trailing: [
                AppSaveButton(
                  text: "Lưu & đóng",
                  onPressed: () async {
                    themTiep = false;
                    if (widget.id == null) {
                      ref.read(khachEditProvider.notifier).addKhach(_requestModel());
                    } else {
                      ref.read(khachEditProvider.notifier).updateKhach(_requestModel(), widget.id!);
                    }
                  },
                ),
                if (widget.id == null) AppSaveButton(
                  text: "Lưu",
                  onPressed: (){
                    themTiep = true;
                    ref.read(khachEditProvider.notifier).addKhach(_requestModel());
                  },
                )
              ],
            )
          ],
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                AppRow(
                  columnWidths: {0: 120, 2: 120},
                  items: [
                    Text('Mã khách hàng').medium,
                    AppTextField(controller: txtMaKH, isUpperCase: true,autofocus: true,),
                    Row(children: [Gap(20), Text('Loại khách').medium]),
                    AppCombobox(
                      enabledClear: false,
                      value: loaiKH,
                      onChanged: (val) => setState(() {
                        loaiKH = val;
                      }),
                      items: [
                        ComboboxItem(value: 'KH', text: ['Khách hàng']),
                        ComboboxItem(value: 'NC', text: ['Nhà cung']),
                        ComboboxItem(value: 'CH', text: ['Cả hai']),
                      ],
                    ),
                  ],
                ),
                AppRow(
                  columnWidths: {0: 120, 2: 120},
                  items: [
                    Text('Tên khách hàng').medium,
                    AppTextField(controller: txtTenKH),
                  ],
                ),
                AppRow(
                  columnWidths: {0: 120},
                  items: [
                    Text('Địa chỉ').medium,
                    AppTextField(controller: txtDiaChi),
                  ],
                ),
                AppRow(
                  columnWidths: {0: 120, 2: 120},
                  items: [
                    Text('Điện thoại').medium,
                    AppTextField(controller: txtDienThoai),
                    Row(children: [Gap(20), Text('Di động').medium]),
                    AppTextField(controller: txtDiDong),
                  ],
                ),
                AppRow(
                  columnWidths: {0: 120, 2: 120},
                  items: [
                    Text('Fax').medium,
                    AppTextField(controller: txtFax),
                    Row(children: [Gap(20), Text('Email').medium]),
                    AppTextField(controller: txtEmail),
                  ],
                ),
                AppRow(
                  columnWidths: {0: 120, 2: 120},
                  items: [
                    Text('Mã số thuế').medium,
                    AppTextField(controller: txtMST),
                    Row(children: [Gap(20), Text('Số tài khoản').medium]),
                    AppTextField(controller: txtSTK),
                  ],
                ),
                AppRow(
                  columnWidths: {0: 120},
                  items: [
                    Text('Ngân hàng').medium,
                    AppTextField(controller: txtNganHang),
                  ],
                ),
                AppRow(
                  columnWidths: {0: 120},
                  items: [
                    Text('Ghi chú').medium,
                    AppTextField(controller: txtGhiChu),
                  ],
                ),
                Checkbox(
                  state: theoDoi ? CheckboxState.checked : CheckboxState.unchecked,
                  onChanged: (val) => setState(() {
                    theoDoi = val.index == 0;
                  }),
                  trailing: Text('Khách đang theo dõi'),
                ).withPadding(left: 120),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
