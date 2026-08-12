import 'package:shadcn_flutter/shadcn_flutter.dart';

import 'app_datefield.dart';

class AppTngayDngay extends StatefulWidget {
  const AppTngayDngay({super.key, this.onSubmit});

  final void Function(DateTime, DateTime)? onSubmit;

  @override
  State<AppTngayDngay> createState() => _AppTngayDngayState();
}

class _AppTngayDngayState extends State<AppTngayDngay> {
  DateTime tN = DateTime.now().copyWith(day: 1);
  DateTime dN = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          spacing: 5,
          children: [
            Text('Từ ngày').medium,
            AppDateField(
              onChanged: (val) {
                tN = val ?? tN;
              },
              value: tN,
              // showClear: false,
            ).expanded(),
          ],
        ).sized(width: 150),
        Gap(10),
        Row(
          spacing: 5,
          children: [
            Text('Đến ngày').medium,
            AppDateField(
              value: dN,
              onChanged: (val) {
                dN = val ?? dN;
              },
            ).expanded(),
          ],
        ).sized(width: 160),
        Gap(10),
        OutlineButton(
          // size: ButtonSize.small,
          child: Text('Thực hiện'),
          onPressed: () {
            widget.onSubmit?.call(tN, dN);
          },
        ),
      ],
    );
  }
}
