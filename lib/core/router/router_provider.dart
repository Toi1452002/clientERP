import 'package:erp_client_1/core/router/router_name.dart';
import 'package:erp_client_1/features/congno/presentation/ui/sobanhang_screen.dart';
import 'package:erp_client_1/features/congno/presentation/ui/somuahang_screen.dart';
import 'package:erp_client_1/features/congno/presentation/ui/tonghopcongno_screen.dart';
import 'package:erp_client_1/features/danhmuc/dauky/presentation/ui/dky_hanghoa_screen.dart';
import 'package:erp_client_1/features/danhmuc/dauky/presentation/ui/dky_khachhang_screen.dart';
import 'package:erp_client_1/features/danhmuc/dauky/presentation/ui/dky_taikhoan_screen.dart';
import 'package:erp_client_1/features/danhmuc/hanghoa/presentation/ui/hanghoa_screen.dart';
import 'package:erp_client_1/features/danhmuc/khach/presentation/ui/khach_screen.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/presentation/ui/nhanvien_screen.dart';
import 'package:erp_client_1/features/danhmuc/taikhoan/presentation/ui/taikhoan_screen.dart';
import 'package:erp_client_1/features/kho/presentation/ui/bke_hangnhap_screen.dart';
import 'package:erp_client_1/features/kho/presentation/ui/bke_hangxuat_screen.dart';
import 'package:erp_client_1/features/kho/presentation/ui/nhapxuatton_screen.dart';
import 'package:erp_client_1/features/nhapxuat/report/presentation/ui/bke_hangban_screen.dart';
import 'package:erp_client_1/features/nhapxuat/report/presentation/ui/bke_hoadon_ban_screen.dart';
import 'package:erp_client_1/features/nhapxuat/report/presentation/ui/bke_hoadon_mua_screen.dart';
import 'package:erp_client_1/features/soketoan/baocaotaichinh/presentation/ui/bang_cdkt_screen.dart';
import 'package:erp_client_1/features/soketoan/baocaotaichinh/presentation/ui/bang_cdps_screen.dart';
import 'package:erp_client_1/features/soketoan/baocaotaichinh/presentation/ui/bang_kqkd_screen.dart';
import 'package:erp_client_1/features/soketoan/baocaotaichinh/presentation/ui/bang_lctt_screen.dart';
import 'package:erp_client_1/features/soketoan/baocaotaichinh/presentation/ui/bang_tmtc_screen.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/presentation/ui/chuyenlo_screen.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/presentation/ui/sothue_view.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/presentation/ui/tncn_screen.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/presentation/ui/tndn_screen.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/presentation/ui/tndn_tt_screen.dart';
import 'package:erp_client_1/features/soketoan/nhatky/presentation/ui/nhatkychung_screen.dart';
import 'package:erp_client_1/features/soketoan/nhatky/presentation/ui/socaitk_screen.dart';
import 'package:erp_client_1/features/soketoan/nhatky/presentation/ui/socttk_screen.dart';
import 'package:erp_client_1/features/system/auth/presentation/notifier/auth_notifier.dart';
import 'package:erp_client_1/features/system/auth/presentation/ui/login_screen.dart';
import 'package:erp_client_1/features/system/home/presentation/notifier/menu_notifier.dart';
import 'package:erp_client_1/features/system/home/presentation/ui/home_screen.dart';
import 'package:erp_client_1/features/system/home/presentation/ui/splash_screen.dart';
import 'package:erp_client_1/features/system/home/presentation/ui/widget/shell_widget.dart';
import 'package:erp_client_1/features/system/menu_permission/presentation/ui/menu_permission_screen.dart';
import 'package:erp_client_1/features/system/ttdn/presentation/ui/ttdn_screen.dart';
import 'package:erp_client_1/features/system/users/presentation/ui/user_screen.dart';
import 'package:erp_client_1/features/taisan/ccdc/presentation/ui/ccdc_screen.dart';
import 'package:erp_client_1/features/taisan/tscd/presentation/ui/tscd_screen.dart';
import 'package:erp_client_1/features/thuchi/report/presentation/ui/bke_phieuthu_screen.dart';
import 'package:erp_client_1/features/thuchi/report/presentation/ui/bke_so_quy_tg_screen.dart';
import 'package:erp_client_1/features/thuchi/report/presentation/ui/bke_so_quy_tm_screen.dart';
import 'package:erp_client_1/features/tienluong/bangluong/presentation/ui/bangluong_screen.dart';
import 'package:erp_client_1/features/tienluong/chamcong/presentation/ui/chamcong_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/thuchi/report/presentation/ui/bke_phieuchi_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: "/",
    redirect: (context, state) {
      final auth = ref.watch(authNotifierProvider);
      final isLogin = state.matchedLocation == '/login';
      final isAuthenticated = auth.value != null;
      if (!isAuthenticated) {
        // no login
        return isLogin ? null : "/login";
      }

      if (isLogin) {
        return '/';
      }
      final nameMenu = state.topRoute?.name;
      if(nameMenu!=RouterName.home){
        final menu = ref.read(menuDataProvider);
        if(menu.indexWhere((e)=>e.code==nameMenu)==-1){
          return '/';
        }
      }
      return null;
    },
    routes: [
      GoRoute(path: "/", name: RouterName.home, builder: (_, _) => ShellWidget()),
      // ShellRoute(
      //
      //   builder: (context, state, child) {
      //     return ShellWidget(child: child);
      //   },
      //   routes: [
      //     GoRoute(path: "/", name: RouterName.home, builder: (_, _) => HomeScreen()),
      //     GoRoute(path: "/danh-sach-khach", name: RouterName.khach, builder: (_, _) => KhachScreen()),
      //     GoRoute(path: "/danh-sach-hang-hoa", name: RouterName.hangHoa, builder: (_, _) => HangHoaScreen()),
      //     GoRoute(path: "/danh-sach-nhan-vien", name: RouterName.nhanVien, builder: (_, _) => NhanVienScreen()),
      //     GoRoute(path: "/danh-sach-tai-khoan", name: RouterName.taiKhoan, builder: (_, _) => TaiKhoanScreen()),
      //     GoRoute(path: "/danh-sach-no-dau-ky", name: RouterName.dkyKhachHang, builder: (_, _) => DKyKhachHangScreen()),
      //     GoRoute(path: "/danh-sach-ton-dau-ky", name: RouterName.dkyHangHoa, builder: (_, _) => DKyHangHoaScreen()),
      //     GoRoute(path: "/danh-sach-dau-ky-tai-khoan", name: RouterName.dkyTaiKhoan, builder: (_, _) => DKyTaiKhoanScreen()),
      //     GoRoute(path: "/users", name: RouterName.users, builder: (_, _) => UserScreen()),
      //     GoRoute(
      //       path: "/phan-quyen-nguoi-dung",
      //       name: RouterName.menuPermission,
      //       builder: (_, _) => MenuPermissionScreen(),
      //     ),
      //     GoRoute(
      //       path: "/bang-ke-hoa-don-mua-hang",
      //       name: RouterName.bkeHoaDonMua,
      //       builder: (_, _) => BkeHoaDonMuaScreen(),
      //     ),
      //     GoRoute(
      //       path: "/bang-ke-hoa-don-ban-hang",
      //       name: RouterName.bkeHoaDonBan,
      //       builder: (_, _) => BkeHoaDonBanScreen(),
      //     ),
      //     GoRoute(path: "/bang-ke-hang-ban", name: RouterName.bkeHangBan, builder: (_, _) => BKeHangBanScreen()),
      //     GoRoute(path: "/bang-ke-phieu-thu", name: RouterName.bkePhieuThu, builder: (_, _) => BKePhieuThuScreen()),
      //     GoRoute(path: "/bang-ke-phieu-chi", name: RouterName.bkePhieuChi, builder: (_, _) => BKePhieuChiScreen()),
      //     GoRoute(path: "/bang-ke-so-quy-tien-mat", name: RouterName.bkeQuyTM, builder: (_, _) => BKeSoQuyTMScreen()),
      //     GoRoute(path: "/bang-ke-so-quy-tien-gui", name: RouterName.bkeQuyTG, builder: (_, _) => BKeSoQuyTGScreen()),
      //     GoRoute(path: "/thong-tin-doanh-nghiep", name: RouterName.ttdn, builder: (_, _) => TTDNScreen()),
      //     GoRoute(path: "/so-mua-hang", name: RouterName.soMuaHang, builder: (_,_)=>SoMuaHangScreen()),
      //     GoRoute(path: "/so-ban-hang", name: RouterName.soBanHang, builder: (_,_)=>SoBanHangScreen()),
      //     GoRoute(path: "/tong-hop-cong-no", name: RouterName.tongHopCongNo, builder: (_,_)=>TongHopCongNoScreen()),
      //     GoRoute(path: "/bang-ke-hang-nhap", name: RouterName.bKeHangNhap, builder: (_,_)=>BKeHangNhapScreen()),
      //     GoRoute(path: "/bang-ke-hang-xuat", name: RouterName.bKeHangXuat, builder: (_,_)=>BKeHangXuatScreen()),
      //     GoRoute(path: "/nhap-xuat-ton-kho", name: RouterName.bKeNhapXuatTon, builder: (_,_)=>NhapXuatTonScreen()),
      //
      //     //SoKeToan
      //     GoRoute(path: "/so-nhat-ky-chung", name: RouterName.soNhatKyChung, builder: (_,_)=>NhatKyChungScreen()),
      //     GoRoute(path: "/so-cai-tai-khoan", name: RouterName.soCaiTaiKhoan, builder: (_,_)=>SoCaiTKScreen()),
      //     GoRoute(path: "/so-chi-tiet-tai-khoan", name: RouterName.soCTTK, builder: (_,_)=>SoCTTKScreen()),
      //
      //
      //     GoRoute(path: "/bang-can-doi-phat-sinh", name: RouterName.bangCDPS, builder: (_,_)=>BangCDPSScreen()),
      //     GoRoute(path: "/bang-can-doi-ke-toan", name: RouterName.bangCDKT, builder: (_,_)=>BangCDKTScreen()),
      //     GoRoute(path: "/bao-cao-ket-quan-kinh-doanh", name: RouterName.bangKQKD, builder: (_,_)=>BangKQKDScreen()),
      //     GoRoute(path: "/bao-cao-luu-chuyen-tien-te", name: RouterName.bangLCTT, builder: (_,_)=>BangLCTTScreen()),
      //     GoRoute(path: "/bao-cao-thuyet-minh-tai-chinh", name: RouterName.bangTMTC, builder: (_,_)=>BangTMTCScreen()),
      //     GoRoute(path: "/bao-cao-thue-tam-tinh", name: RouterName.bangTNDNtt, builder: (_,_)=>TNDNttScreen()),
      //     GoRoute(path: "/bao-cao-thue-tndn", name: RouterName.bangTNDN, builder: (_,_)=>TNDNScreen()),
      //     GoRoute(path: "/bao-cao-thue-tncn", name: RouterName.bangTNCN, builder: (_,_)=>TNCNScreen()),
      //     GoRoute(path: "/chuyen-lo", name: RouterName.bangChuyenLo, builder: (_,_)=>ChuyenLoScreen()),
      //     GoRoute(path: "/so-thue", name: RouterName.soThue, builder: (_,_)=>SoThueView()),
      //
      //
      //     GoRoute(path: "/tscd", name: RouterName.tscd, builder: (_,_)=>TSCDScreen()),
      //     GoRoute(path: "/ccdc", name: RouterName.ccdc, builder: (_,_)=>CCDCScreen()),
      //
      //
      //     GoRoute(path: "/cham-cong", name: RouterName.chamCong, builder: (_,_)=>ChamCongScreen()),
      //     GoRoute(path: "/bang-luong", name: RouterName.bangLuong, builder: (_,_)=>BangLuongScreen()),
      //
      //
      //
      //   ],
      // ),

      GoRoute(path: "/login", name: RouterName.login, builder: (_, _) => LoginScreen()),
      // GoRoute(path: "/splash", name: RouterName.splash, builder: (_, _) => SplashScreen()),
    ],
  );
});
