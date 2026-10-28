import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

Future<Map<String, dynamic>> loadConfig() async {
  // final exePath = Platform.resolvedExecutable;
  // final exeFolder = File(exePath).parent.path;
  // final file = File(
  //   '$exeFolder/config.json',
  // );
  final jsonString = await rootBundle.loadString('assets/config/appsettings.json');


  // if (!await file.exists()) {
  //   throw Exception('Không tìm thấy config.json');
  // }

  return jsonDecode(jsonString);
}