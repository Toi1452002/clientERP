import 'package:erp_client_1/core/constain/app_color.dart';
import 'package:erp_client_1/core/widgets/app_combobox.dart';
import 'package:erp_client_1/core/widgets/app_container_border.dart';
import 'package:erp_client_1/core/widgets/app_dialog.dart';
import 'package:erp_client_1/core/widgets/app_header.dart';
import 'package:erp_client_1/features/danhmuc/hanghoa/presentation/dialog/hanghoa_form_dialog.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/widgets/app_button.dart';
import '../notifier/hanghoa_view_notifierr.dart';
import 'widget/hanghoa_table.dart';

class HangHoaScreen extends ConsumerStatefulWidget {
  const HangHoaScreen({super.key});

  @override
  HangHoaScreenState createState() => HangHoaScreenState();
}

class HangHoaScreenState extends ConsumerState<HangHoaScreen> {
  int select = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColor.background,
      footers: [AppFooter()],
      headers: [
        AppHeader(
          title: "Danh sách hàng hóa – vật tư",
          trailing: [
            // AppReloadButton(
            //   onPressed: () {
            //     ref.refresh(hangHoaViewProvider);
            //     ref.refresh(dvtProvider);
            //     ref.refresh(nhomhangProvider);
            //     ref.refresh(loaiHangProvider);
            //     ref.invalidate(hangHoaLookupProvider);
            //   },
            // ),
            // Gap(10),
          ],
        ),
        AppContainerBorder(
          child: AppBar(
            // padding: EdgeInsets.only(left: 10, top: 10, bottom: 5),
            leading: [
              AppNewButton(
                text: 'Thêm hàng hóa',
                onPressed: () {
                  showAppDialog(context, child: HangHoaFormDialog());
                },
              ),
              Gap(5),
              AppPrintButton(),
            ],
            trailing: [
              SizedBox(
                width: 150,
                child: AppCombobox(
                  enabledClear: false,
                  value: select,
                  items: [
                    ComboboxItem(value: 1, text: ["Đang theo dõi"]),
                    ComboboxItem(value: 0, text: ["Ngưng theo dõi"]),
                    ComboboxItem(value: 2, text: ["Tất cả"]),
                  ],
                  onChanged: (val) {
                    setState(() {
                      select = val;
                    });
                    if(select==2){
                      ref.read(hangHoaViewProvider.notifier).getView(isActive: null);
                    }else{
                      ref.read(hangHoaViewProvider.notifier).getView(isActive: select==1);
                    }
          
                  },
                ),
              ),
            ],
          ),
        ),
      ],
      child: HangHoaTable(),
    );
  }
}

