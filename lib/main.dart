import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/data/network/network_config.dart';
import 'main_widget.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await NetworkConfig.load();
  runApp(ProviderScope(child: MainWidget()));
}