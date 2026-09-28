import 'package:dio/dio.dart';

Future<Map<String, dynamic>> loadConfigWeb() async {
  final response = await Dio().get(
    'config.json',
  );
  if (response.statusCode != 200) {
    throw Exception('Không tải được appsettings.json');
  }
  return response.data;
  // return jsonDecode(response.data);
}
