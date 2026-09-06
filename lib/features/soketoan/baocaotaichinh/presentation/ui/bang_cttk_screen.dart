import 'package:erp_client_1/core/widgets/app_dialog.dart';
import 'package:erp_client_1/features/soketoan/baocaotaichinh/presentation/notifier/bang_cttk_notifier.dart';
import 'package:erp_client_1/features/soketoan/nhatky/presentation/ui/widget/so_cttk_table.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BangCTTKScreen extends ConsumerStatefulWidget {
  const BangCTTKScreen({super.key, required this.maTK, required this.year});

  final String maTK;
  final String year;

  @override
  BangCTTKScreenState createState() => BangCTTKScreenState();
}

class BangCTTKScreenState extends ConsumerState<BangCTTKScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      ref.read(bangCTTKProvider.notifier).get(widget.maTK, widget.year);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bangCTTKProvider);
    return DialogWindows(
      width: 1250,
      height: 600,
      title: "Bảng kê chi tiết tài khoản",
      child: Scaffold(
        child: state.when(
          data: (val) {
            return SoCTTKTable(data: val);
          },
          error: (e, s) => Center(child: Text(e.toString())),
          loading: () => Center(child: CircularProgressIndicator(size: 50)),
        ),
      ),
    );
  }
}
