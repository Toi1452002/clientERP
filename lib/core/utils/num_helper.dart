import 'package:intl/intl.dart';

class NumHelper {
  NumHelper._();

  static String numFormat(dynamic value, {bool lamTron = true}) {
    if (value == null || value.toString().trim().isEmpty) {
      return '';
    }

    try {
      final num number;

      if (value is num) {
        number = value;
      } else {
        final str = value.toString().replaceAll(',', '');
        number = num.parse(str);
      }

      final format = lamTron ? NumberFormat('#,##0', 'en_US') : NumberFormat('#,##0.##', 'en_US');

      return format.format(number);
    } catch (_) {
      return value.toString();
    }
  }

  static double stringToDouble(
      dynamic value, {
        bool keepDot = false,
      }) {
    if (value == null) return 0;

    String text = value.toString().trim();

    if (text.isEmpty) return 0;

    if (keepDot) {
      text = text.replaceAll(',', '.');
    } else {
      text = text.replaceAll(',', '');
    }

    return double.tryParse(text) ?? 0;
  }

  static String readMoney(int number) {
    if (number == 0) return 'Không đồng';

    final List<String> digits = [
      'không', 'một', 'hai', 'ba', 'bốn',
      'năm', 'sáu', 'bảy', 'tám', 'chín'
    ];
    final List<String> units = ['', 'nghìn', 'triệu', 'tỷ'];

    String result = '';
    bool isNegative = number < 0;
    number = number.abs();

    List<int> groups = [];
    while (number > 0) {
      groups.add(number % 1000);
      number ~/= 1000;
    }

    for (int i = groups.length - 1; i >= 0; i--) {
      int group = groups[i];
      if (group == 0 && i > 0) continue;

      String groupText = '';
      int hundreds = group ~/ 100;
      int tens = (group % 100) ~/ 10;
      int ones = group % 10;

      if (hundreds > 0) {
        groupText += '${digits[hundreds]} trăm ';
      }

      if (tens > 1) {
        groupText += '${digits[tens]} mươi ';
        if (ones == 1) {
          groupText += 'mốt ';
        } else if (ones == 5) {
          groupText += 'lăm ';
        } else if (ones > 0) {
          groupText += '${digits[ones]} ';
        }
      } else if (tens == 1) {
        groupText += 'mười ';
        if (ones == 1) {
          groupText += 'một ';
        } else if (ones == 5) {
          groupText += 'lăm ';
        } else if (ones > 0) {
          groupText += '${digits[ones]} ';
        }
      } else if (ones > 0) {
        if (hundreds > 0 || (tens > 0 && i < groups.length - 1)) {
          groupText += 'lẻ ';
        }
        // Chỉ đọc "lăm" nếu có hàng chục hoặc trăm trong cùng nhóm
        if (ones == 5 && (hundreds > 0 || tens > 0)) {
          groupText += 'lăm ';
        } else {
          groupText += '${digits[ones]} ';
        }
      }

      if (groupText.isNotEmpty) {
        groupText += '${units[i]} ';
      }

      result += groupText;
    }

    result = result.trim();
    result = '${result[0].toUpperCase()}${result.substring(1)} đồng';
    if (isNegative) {
      result = 'Âm $result';
    }

    return result;
  }
}
