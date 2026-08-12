import 'package:shadcn_flutter/shadcn_flutter.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(child: Center(child: CircularProgressIndicator(),));
  }
}
