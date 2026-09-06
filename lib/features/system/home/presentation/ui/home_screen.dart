import 'package:collection/collection.dart';
import 'package:erp_client_1/features/system/ttdn/presentation/notifier/ttdn_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ttdnState = ref.watch(ttdnProvider);
    return Scaffold(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/01.jpg'), fit: BoxFit.cover),
        ),
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: 700,
            height: 250,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .8),
              borderRadius: BorderRadius.circular(5),
            ),
            child: ttdnState.when(data: (val){
              final tenCty = val.firstWhereOrNull((e)=>e.ma=="TCT")?.noiDung;
              final diaChi = val.firstWhereOrNull((e)=>e.ma=="DC")?.noiDung;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('PHẦN MỀM KẾ TOÁN').h4(),
                  Text('PMN-KT Copyright by RBG - version 1.0').large(),
                  Text('Tên: $tenCty').medium(),
                  Text('ĐC:  $diaChi').medium(),
                  // Gap(10),
                  // Text('Người dùng: ${ref.read(authNotifierProvider).value?.info?.fullName}').medium(),
                  Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      OutlineButton(
                        child: Text('Thay đổi tài khoản người dùng'),
                        onPressed: () {
                          // showDoiTaiKhoan(context);
                        },
                      ),
                      // OutlineButton(
                      //   child: Text('Thoát phần mềm'),
                      //   onPressed: () {
                      //     exit(0);
                      //   },
                      // ),
                    ],
                  ),
                ],
              );
            }, error: (e,s)=>Center(child: Text(e.toString()),), loading: ()=>Center(child: CircularProgressIndicator(size: 50,),)),
          ),
        ),
      ),
      // headers: [
      //   AppBar(
      //     leading: [TextButton(child: Text('users'), onPressed: () => context.goNamed(RouterName.users))],
      //   ),
      // ],
      // child: Text('Home Screen'),
    );
  }
}
