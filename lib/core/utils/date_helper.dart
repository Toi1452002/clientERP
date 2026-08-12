import 'package:intl/intl.dart';

class DateHelper {
  DateHelper._();
  static String yM(dynamic date) {
    return DateFormat('yyyy-MM').format(date);
  }

  static int ngayCuoiThang(int nam, int thang) {
    return DateTime(nam, thang + 1, 0).day;
  }
  static String? getDateLastMonth(int thang, int nam) {
    final date = DateTime(nam, thang + 1, 0).day;
    return yMd(DateTime(nam, thang, date));
  }
  static String? dMy(dynamic date, {bool time = false}) {
    if (date == null) return null;

    DateTime? dt;

    if (date is DateTime) {
      dt = date;
    } else if (date is String) {
      dt = DateTime.tryParse(date);
    }

    if (dt == null) return date.toString();

    return DateFormat(time ? 'dd/MM/yyyy HH:mm:ss' : 'dd/MM/yyyy').format(dt);
  }
  static int getQuarterNow() { // Hàm lấy quý hiện tại
    int month = DateTime.now().month;
    int quarter = ((month - 1) ~/ 3) + 1;
    return quarter;
  }

  static String formatMonth(int thang) {
    if(thang.toString().length==1) return '0$thang';
    return '$thang';
  }
  static DateTime? stringToDate(String date) {
    final lstChar = ['/','.','-','_',','];
    List parts = [];
    for(String x in lstChar){
      if(date.contains(x)){
        parts = date.split(x);
        break;
      }

    }
    // final parts = date.split('/');

    if (parts.length != 3) return null;

    final day = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final year = int.tryParse(parts[2]);

    if (day == null || month == null || year == null) {
      return null;
    }

    try {
      final dt = DateTime(year, month, day);

      // kiểm tra ngày hợp lệ
      if (dt.day != day || dt.month != month || dt.year != year) {
        return null;
      }

      return dt;
    } catch (_) {
      return null;
    }
  }

  static dynamic dateNow({bool sql = true, bool hasTime = false}) {
    if(sql) {
      if(hasTime) return DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
      return DateFormat('yyyy-MM-dd').format(DateTime.now());
    }
    else{
      if(hasTime) return DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now());
      return DateFormat('dd/MM/yyyy').format(DateTime.now());
    }
  }
  static String? yMd(dynamic date) {
    if (date == null) return null;

    if (date is DateTime) {
      return DateFormat('yyyy-MM-dd').format(date);
    }

    if (date is String) {
      final parts = date.split('/');

      if (parts.length != 3) {
        return date;
      }

      final day = parts[0].padLeft(2, '0');
      final month = parts[1].padLeft(2, '0');
      final year = parts[2];

      return '$year-$month-$day';
    }

    return date.toString();
  }

  static String? luiThang(String thang) {
    final date = DateTime.tryParse(thang);
    int newMonth = date!.month - 1;
    int newYear = date.year;

    // Nếu tháng giảm về 0, chuyển về tháng 12 của năm trước
    if (newMonth == 0) {
      newMonth = 12;
      newYear -= 1;
    }

    // Kiểm tra ngày hợp lệ (tránh trường hợp ngày không tồn tại trong tháng mới)
    int newDay = date.day;
    int daysInNewMonth = DateTime(newYear, newMonth + 1, 0).day;
    if (newDay > daysInNewMonth) {
      newDay = daysInNewMonth; // Lấy ngày cuối cùng của tháng mới
    }

    return yMd(DateTime(newYear, newMonth, newDay));
  }
  static String qDauThang(int quy){
    return ['01','04','07','10'][quy-1];
  }
  static String qCuoiThang(int quy){
    return ['03','06','09','12'][quy-1];
  }

  static int firstMQuy(int quy){
    return [1,4,7,10][quy-1];
  }
  static int lastMQuy(int quy){
    return [3,6,9,12][quy-1];
  }
}
