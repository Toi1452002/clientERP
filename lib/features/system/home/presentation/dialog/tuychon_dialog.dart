import 'package:erp_client_1/core/data/local/storage/storage_name.dart';
import 'package:erp_client_1/core/data/local/storage/storage_provider.dart';
import 'package:erp_client_1/core/widgets/app_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class TuyChonDialog extends ConsumerStatefulWidget {
  const TuyChonDialog({super.key});

  @override
  ConsumerState createState() => _TuyChonDialogState();
}

class _TuyChonDialogState extends ConsumerState<TuyChonDialog> {
  bool xemBaoCao = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    load();
  }


  void load() async{
    final storage = ref.read(storageProvider);
    xemBaoCao = await storage.getBool(xemBC) ?? false;

    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return DialogWindows(
      width: 400,
      height: 300,
      title: "Tùy chọn",
      child: Scaffold(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(state: xemBaoCao? CheckboxState.checked : CheckboxState.unchecked, onChanged: (val) {
                bool isCheck = val.index == 0;
                setState(() {
                  xemBaoCao = isCheck;
                });
                ref.read(storageProvider).saveBool(xemBC, isCheck);
              }, trailing: Text("Xem báo cáo trước khi in")),
            ],
          ),
        ),
      ),
    );
  }
}
