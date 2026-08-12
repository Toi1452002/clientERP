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
    ref.listenManual(authNotifierProvider, (pre, next) {
      next.whenOrNull(
        data: (val) {
          ref.refresh(loginErrorState);
        },
        error: (e, s) {
          ref.read(loginErrorState.notifier).state = e.toString();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authNotifierProvider);
    final err = ref.watch(loginErrorState);
    return LoadingOverlay(
      isLoading: state.isLoading,
      child: Scaffold(
        backgroundColor: Colors.cyan[700],
        child: Center(
          child: Card(
            padding: EdgeInsets.all(20),
            boxShadow: [BoxShadow(color: Colors.cyan[800], blurRadius: 20)],
            fillColor: Colors.white.withValues(alpha: .9),
            filled: true,
            child: Column(
              spacing: 10,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Phần mềm kế toán',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.cyan[700]),
                ),
                Gap(5),
                AppTextField(hintText: "Username", controller: txtUsername, autofocus: true),
                AppTextField(hintText: "Password", controller: txtPassword, obscureText: true),
                Gap(5),
                PrimaryButton(
                  child: Text('Đăng nhập', style: TextStyle(color: Colors.white)).withAlign(Alignment.center),
                  onPressed: () {
                    ref.read(authNotifierProvider.notifier).login(txtUsername.text, txtPassword.text);
                  },
                ),
                if (err != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(err, style: TextStyle(color: Colors.red)),
                  ),
              ],
            ),
          ).sized(width: 350),
        ),
      ),
    );
  }
}
