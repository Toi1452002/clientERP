import 'package:erp_client_1/features/danhmuc/khach/presentation/dialog/khach_form_dialog.dart';
import 'package:erp_client_1/features/danhmuc/khach/presentation/notifier/khach_view_notifier.dart';
import 'package:erp_client_1/features/danhmuc/khach/presentation/ui/widget/khach_table.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constain/app_color.dart';
import '../../../../../core/widgets/widget.dart';

class KhachScreen extends ConsumerStatefulWidget {
  const KhachScreen({super.key});

  @override
  KhachScreenState createState() => KhachScreenState();
}

class KhachScreenState extends ConsumerState<KhachScreen> {
  int select = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      footers: [AppFooter()],
      headers: [
        // AppHeader(
          // title: "Danh sách khách hàng – nhà cung",
          // trailing: [
          //   AppReloadButton(
          //     onPressed: () {
          //       ref.refresh(khachViewProvider);
          //       // ref.refresh(userViewProvider);
          //     },
          //   ),
          //   Gap(10),
          // ],
        // ),
        AppContainerBorder(
          child: AppBar(
            // padding: EdgeInsets.only(left: 20, top: 10, bottom: 5),
            leading: [
              AppNewButton(
                text: 'Thêm khách',
                onPressed: () {
                  showAppDialog(context, child: KhachFormDialog());
                },
              ),
              Gap(5),
              AppPrintButton()
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
                      ref.read(khachViewProvider.notifier).get(isActive: null);
                    }else{
                      ref.read(khachViewProvider.notifier).get(isActive: select==1);
                    }
          
                  },
                ),
              ),
            ],
          ),
        ),
      ],
      child: KhachTable(),
    );
  }
}

