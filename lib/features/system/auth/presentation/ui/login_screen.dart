import 'package:erp_client_1/core/data/network/network_config.dart';
import 'package:erp_client_1/features/system/auth/presentation/notifier/auth_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../../../../../core/widgets/widget.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final txtUsername = TextEditingController();
  final txtPassword = TextEditingController();

  String? error;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authNotifierProvider);


    return Scaffold(
      backgroundColor: Colors.cyan[700],
      child: Container(
        decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.cyan[800], Colors.cyan.shade200])),
        child: Row(
          children: [
            Expanded(child: SizedBox(), flex: 4),
            Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(50),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Phần mềm kế toán',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.cyan[700]),
                    ),
                    Text("Phiên bản: ${NetworkConfig.version}", style: TextStyle(color: Colors.gray)).medium,
                    Gap(150),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Log In', style: TextStyle(fontSize: 25)).medium,
                        Gap(30),
                        AppTextField(hintText: "Nhập vào tài khoản", controller: txtUsername, autofocus: true),
                        Gap(10),
                        AppTextField(hintText: "Nhập vào mật khẩu", controller: txtPassword, obscureText: true),
                        Gap(10),
                        Builder(
                          builder: (context) {
                            if (state.isLoading) {
                              return Center(child: CircularProgressIndicator(size: 20));
                            }
                            return PrimaryButton(
                              child: Text(
                                'Đăng nhập',
                                style: TextStyle(color: Colors.white),
                              ).withAlign(Alignment.center),
                              onPressed: () {
                                ref.read(authNotifierProvider.notifier).login(txtUsername.text, txtPassword.text);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    Spacer(),
                    if (state.hasError)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(state.error.toString(), style: TextStyle(color: Colors.red)),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
