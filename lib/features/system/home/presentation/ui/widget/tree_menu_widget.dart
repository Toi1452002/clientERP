import 'package:erp_client_1/core/router/router_name.dart';
import 'package:erp_client_1/core/router/tabbed_view_builder.dart';
import 'package:erp_client_1/core/widgets/app_dialog.dart';
import 'package:erp_client_1/features/danhmuc/manghiepvu/presentation/ui/manghiepvu_screen.dart';
import 'package:erp_client_1/features/nhapxuat/nhap/presentation/ui/phieunhap_screen.dart';
import 'package:erp_client_1/features/nhapxuat/xuat/presentation/ui/phieuxuat_screen.dart';
import 'package:erp_client_1/features/system/home/presentation/notifier/menu_notifier.dart';
import 'package:erp_client_1/features/system/home/presentation/notifier/tabbed_notifier.dart';
import 'package:erp_client_1/features/thuchi/chi/presentation/ui/phieuchi_screen.dart';
import 'package:erp_client_1/features/thuchi/thu/presentation/ui/phieuthu_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class TreeMenuWidget extends ConsumerWidget {
  const TreeMenuWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(menuProvider);
    return state.when(
      data: (value) {
        return TreeView(
          nodes: value,
          allowMultiSelect: false,
          expandIcon: true,
          onSelectionChanged: TreeView.defaultSelectionHandler(value, (value) {
            ref.read(menuProvider.notifier).setValue(value);
          }),
          builder: (context, node) {
            return TreeItemView(
              onExpand: TreeView.defaultItemExpandHandler(value, node, (value) {
                ref.read(menuProvider.notifier).setValue(value);
              }),
              onPressed: () {
                final name = node.data;
                final code = ref.read(menuDataProvider).firstWhere((e) => e.name == name).code;
                if ([
                  RouterName.users,
                  RouterName.menuPermission,
                  RouterName.khach,
                  RouterName.hangHoa,
                  RouterName.nhanVien,
                  RouterName.taiKhoan,
                  RouterName.bkeHoaDonMua,
                  RouterName.bkeHoaDonBan,
                  RouterName.bkeHangBan,
                  RouterName.bkePhieuChi,
                  RouterName.bkePhieuThu,
                  RouterName.bkeQuyTM,
                  RouterName.bkeQuyTG,
                  RouterName.ttdn,
                  RouterName.dkyKhachHang,
                  RouterName.dkyHangHoa,
                  RouterName.dkyTaiKhoan,
                  RouterName.soMuaHang,
                  RouterName.soBanHang,
                  RouterName.tongHopCongNo,
                  RouterName.bKeHangNhap,
                  RouterName.bKeHangXuat,
                  RouterName.bKeNhapXuatTon,
                  RouterName.soNhatKyChung,
                  RouterName.soCaiTaiKhoan,
                  RouterName.soCTTK,
                  RouterName.bangCDPS,
                  RouterName.bangCDKT,
                  RouterName.bangKQKD,
                  RouterName.bangLCTT,
                  RouterName.bangTMTC,
                  RouterName.bangTNDNtt,
                  RouterName.bangTNDN,
                  RouterName.bangTNCN,
                  RouterName.bangChuyenLo,
                  RouterName.soThue,
                  RouterName.tscd,
                  RouterName.ccdc,
                  RouterName.chamCong,
                  RouterName.bangLuong
                ].contains(code)) {
                  // context.goNamed(code);
                  // ref.read(tabbedProvider.notifier).addTab(name);
                  ref.read(tabbedProvider.notifier).addTab(code,name,tabbedView(code));
                }

                else if(code=="TC_T"){
                  showAppDialog(context, child: PhieuThuScreen());
                }else if(code == "TC_C"){
                  showAppDialog(context, child: PhieuChiScreen());
                }else if(code == "NX_N"){
                  showAppDialog(context, child: PhieuNhapScreen());
                }else if(code == "NX_X"){
                  showAppDialog(context, child: PhieuXuatScreen());
                }else if(code == "DM_MNV"){
                  showAppDialog(context, child: MaNghiepVuScreen());
                }
              },
              child: Text(node.data),
            );
          },
        );
      },
      error: (e, s) {
        return Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text(e.toString())]);
      },
      loading: () => Center(child: CircularProgressIndicator(size: 50)),
    );
  }
}
