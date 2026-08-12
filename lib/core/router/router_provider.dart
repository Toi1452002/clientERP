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
import 'package:erp_client_1/features/system/auth/presentation/notifier/auth_notifier.dart';
import 'package:erp_client_1/features/system/auth/presentation/ui/login_screen.dart';
import 'package:erp_client_1/features/system/home/presentation/ui/home_screen.dart';
import 'package:erp_client_1/features/system/home/presentation/ui/splash_screen.dart';
import 'package:erp_client_1/features/system/home/presentation/ui/widget/shell_widget.dart';
import 'package:erp_client_1/features/system/menu_permission/presentation/ui/menu_permission_screen.dart';
import 'package:erp_client_1/features/system/ttdn/presentation/ui/ttdn_screen.dart';
import 'package:erp_client_1/features/system/users/presentation/ui/user_screen.dart';
import 'package:erp_client_1/features/thuchi/report/presentation/ui/bke_phieuthu_screen.dart';
import 'package:erp_client_1/features/thuchi/report/presentation/ui/bke_so_quy_tg_screen.dart';
import 'package:erp_client_1/features/thuchi/report/presentation/ui/bke_so_quy_tm_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/thuchi/report/presentation/ui/bke_phieuchi_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    onException: (context, state, router) {
      print('object');
    },
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

      return null;
    },
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return ShellWidget(child: child);
        },
        routes: [
          GoRoute(path: "/", name: RouterName.home, builder: (_, _) => HomeScreen()),
          GoRoute(path: "/danh-sach-khach", name: RouterName.khach, builder: (_, _) => KhachScreen()),
          GoRoute(path: "/danh-sach-hang-hoa", name: RouterName.hangHoa, builder: (_, _) => HangHoaScreen()),
          GoRoute(path: "/danh-sach-nhan-vien", name: RouterName.nhanVien, builder: (_, _) => NhanVienScreen()),
          GoRoute(path: "/danh-sach-tai-khoan", name: RouterName.taiKhoan, builder: (_, _) => TaiKhoanScreen()),
          GoRoute(path: "/danh-sach-no-dau-ky", name: RouterName.dkyKhachHang, builder: (_, _) => DKyKhachHangScreen()),
          GoRoute(path: "/danh-sach-ton-dau-ky", name: RouterName.dkyHangHoa, builder: (_, _) => DKyHangHoaScreen()),
          GoRoute(path: "/danh-sach-dau-ky-tai-khoan", name: RouterName.dkyTaiKhoan, builder: (_, _) => DKyTaiKhoanScreen()),
          GoRoute(path: "/users", name: RouterName.users, builder: (_, _) => UserScreen()),
          GoRoute(
            path: "/phan-quyen-nguoi-dung",
            name: RouterName.menuPermission,
            builder: (_, _) => MenuPermissionScreen(),
          ),
          GoRoute(
            path: "/bang-ke-hoa-don-mua-hang",
            name: RouterName.bkeHoaDonMua,
            builder: (_, _) => BkeHoaDonMuaScreen(),
          ),
          GoRoute(
            path: "/bang-ke-hoa-don-ban-hang",
            name: RouterName.bkeHoaDonBan,
            builder: (_, _) => BkeHoaDonBanScreen(),
          ),
          GoRoute(path: "/bang-ke-hang-ban", name: RouterName.bkeHangBan, builder: (_, _) => BKeHangBanScreen()),
          GoRoute(path: "/bang-ke-phieu-thu", name: RouterName.bkePhieuThu, builder: (_, _) => BKePhieuThuScreen()),
          GoRoute(path: "/bang-ke-phieu-chi", name: RouterName.bkePhieuChi, builder: (_, _) => BKePhieuChiScreen()),
          GoRoute(path: "/bang-ke-so-quy-tien-mat", name: RouterName.bkeQuyTM, builder: (_, _) => BKeSoQuyTMScreen()),
          GoRoute(path: "/bang-ke-so-quy-tien-gui", name: RouterName.bkeQuyTG, builder: (_, _) => BKeSoQuyTGScreen()),
          GoRoute(path: "/thong-tin-doanh-nghiep", name: RouterName.ttdn, builder: (_, _) => TTDNScreen()),
          GoRoute(path: "/so-mua-hang", name: RouterName.soMuaHang, builder: (_,_)=>SoMuaHangScreen()),
          GoRoute(path: "/so-ban-hang", name: RouterName.soBanHang, builder: (_,_)=>SoBanHangScreen()),
          GoRoute(path: "/tong-hop-cong-no", name: RouterName.tongHopCongNo, builder: (_,_)=>TongHopCongNoScreen()),
          GoRoute(path: "/bang-ke-hang-nhap", name: RouterName.bKeHangNhap, builder: (_,_)=>BKeHangNhapScreen()),
          GoRoute(path: "/bang-ke-hang-xuat", name: RouterName.bKeHangXuat, builder: (_,_)=>BKeHangXuatScreen()),
          GoRoute(path: "/nhap-xuat-ton-kho", name: RouterName.bKeNhapXuatTon, builder: (_,_)=>NhapXuatTonScreen()),
        ],
      ),

      GoRoute(path: "/login", name: RouterName.login, builder: (_, _) => LoginScreen()),
      GoRoute(path: "/splash", name: RouterName.splash, builder: (_, _) => SplashScreen()),
    ],
  );
});
