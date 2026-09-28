import 'dart:convert';
import 'package:erp_client_1/core/data/network/load_config_desktop.dart';
import 'package:erp_client_1/core/data/network/load_config_web.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
class NetworkConfig {
  static late String apiUrl;
  static late String version;

  static Future<void> load() async {
    // final jsonString = await rootBundle.loadString('assets/config/appsettings.json');
    //
    // final json = jsonDecode(jsonString);
    final json = kIsWeb ? await loadConfigWeb(): await loadConfig();
    apiUrl = json['ApiUrl'];
    version = json['Version'];
  }
}



