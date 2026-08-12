import 'package:erp_client_1/core/router/router_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MainWidget extends ConsumerWidget {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(routerProvider);
    return ShadcnApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: goRouter,
      theme: ThemeData(
        colorScheme: ColorSchemes.lightNeutral.blue,
        density: Density.compactDensity,
        typography: Typography.geist(
            base: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Arial'),
            medium: TextStyle(fontWeight: FontWeight.w500,fontSize: 13)
        ),
      ),
    );
  }
}
