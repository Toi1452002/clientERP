import 'package:erp_client_1/core/widgets/app_header.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/presentation/ui/widget/table_gtgt.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/presentation/ui/widget/table_phat.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/presentation/ui/widget/table_tncn.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/presentation/ui/widget/table_tndn.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SoThueView extends ConsumerStatefulWidget {
  const SoThueView({super.key});

  @override
  ConsumerState createState() => _SoThueViewState();
}

class _SoThueViewState extends ConsumerState<SoThueView> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      footers: [AppFooter()],
      headers: [AppHeader(title: "Sổ thuế")],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TabList(
            // TabList is a lower-level tab header; it doesn't manage content.
            index: index,
            onChanged: (value) {
              setState(() {
                index = value;
              });
            },
            children: const [
              TabItem(child: Text('Giá trị gia tăng')),
              TabItem(child: Text('Thu nhập doanh nghiệp')),
              TabItem(child: Text('Thu nhập cá nhân')),
              TabItem(child: Text('Phạt')),
            ],
          ),
          // const Gap(16),
          // Like Tabs example, use an IndexedStack to switch the content area.
          Expanded(child: IndexedStack(
            index: index,
            children: const [
              TableGTGT(),
              TableTNDN(),
              TableTNCN(),
              TablePhat(),
            ],
          )),
        ],
      )
    );
  }
}
