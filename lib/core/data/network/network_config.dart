import 'dart:convert';
// import 'dart:io';

import 'package:flutter/services.dart';

class NetworkConfig {
  static late String apiUrl;

  static Future<void> load() async {
    final jsonString =
    await rootBundle.loadString('assets/config/appsettings.json');

    final json = jsonDecode(jsonString);

    apiUrl = json['ApiUrl'];
  }
}