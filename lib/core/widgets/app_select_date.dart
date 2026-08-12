import 'package:erp_client_1/core/utils/date_helper.dart';
import 'package:erp_client_1/core/widgets/app_combobox.dart';
import 'package:erp_client_1/core/widgets/app_textfield.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class AppSelectDate extends StatefulWidget {
  const AppSelectDate({super.key, this.onSubmit});

  final void Function(DateTime, DateTime)? onSubmit;

  @override
  State<AppSelectDate> createState() => _AppSelectDateState();
}

class _AppSelectDateState extends State<AppSelectDate> {
  int selectType = 0;
  int selectMonth = DateTime.now().month;
  int selectQuy = DateHelper.getQuarterNow();
  final txtNam = TextEditingController(text: DateTime.now().year.toString());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Chọn'),
        Gap(5),
        SizedBox(
          width: 70,
          child: AppCombobox(
            enabledClear: false,
            value: selectType,
            onChanged: (val) {
              setState(() {
                selectType = val;
              });
            },
            items: [
              ComboboxItem(value: 0, text: ['Tháng']),
              ComboboxItem(value: 1, text: ['Quý']),
              ComboboxItem(value: 2, text: ['Năm']),
            ],
          ),
        ),

        Row(
          children: [
            Builder(
              builder: (context) {
                if (selectType == 0) {
                  return SizedBox(
                    width: 50,
                    child: AppCombobox(
                      value: selectMonth,
                      enabledClear: false,
                      onChanged: (val) {
                        setState(() {
                          selectMonth = val;
                        });
                      },
                      items: [
                        for (int i = 1; i <= 12; i++) ComboboxItem(value: i, text: [i.toString()]),
                      ],
                    ),
                  );
                } else if (selectType == 1) {
                  return SizedBox(
                    width: 50,
                    child: AppCombobox(
                      value: selectQuy,
                      enabledClear: false,
                      onChanged: (val) {
                        setState(() {
                          selectQuy = val;
                        });
                      },
                      items: [
                        for (int i = 1; i <= 4; i++) ComboboxItem(value: i, text: [i.toString()]),
                      ],
                    ),
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
            if (selectType != 2) Gap(10),
            if (selectType != 2) Text('Năm'),
            if (selectType != 2) Gap(5),
            SizedBox(width: 50, child: AppTextField(controller: txtNam)),
            Gap(10),
            OutlineButton(
              child: Text('Thực hiện'),
              onPressed: () {
                int nam = int.tryParse(txtNam.text) ?? DateTime.now().year;
                if (selectType == 0) {
                  widget.onSubmit?.call(
                    DateTime(nam, selectMonth, 1),
                    DateTime(nam, selectMonth, DateHelper.ngayCuoiThang(nam, selectMonth)),
                  );
                } else if (selectType == 1) {
                  final lastMQuy = DateHelper.lastMQuy(selectQuy);
                  widget.onSubmit?.call(
                    DateTime(nam, DateHelper.firstMQuy(selectQuy), 1),
                    DateTime(nam, lastMQuy, DateHelper.ngayCuoiThang(nam, lastMQuy)),
                  );
                } else {
                  widget.onSubmit?.call(DateTime(nam, 1, 1), DateTime(nam, 12, 31));
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
