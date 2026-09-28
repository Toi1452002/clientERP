import 'package:erp_client_1/core/widgets/app_dialog.dart';
import 'package:erp_client_1/features/danhmuc/nhomhang/presentation/dialog/nhomhang_dialog.dart';
import 'package:erp_client_1/features/danhmuc/nhomhang/presentation/notifier/nhomhang_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import '../../../../../../core/widgets/app_combobox.dart';



class NhomHangCombobox extends ConsumerWidget {
  final String? selected;
  final void Function(dynamic)? onChanged;
  const NhomHangCombobox({super.key, this.onChanged, this.selected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(nhomhangProvider);
    return state.when(data: (value){
      return AppCombobox(
          noSearch: false,
          value: selected,
          onAdd: (){
            showAppDialog(context, child: NhomHangDialog());
          },
          items: value.map((e) => ComboboxItem(value: e.nhomHang, text: [e.nhomHang])).toList(),
          onChanged: onChanged
      );
    }, error: (e,s)=> Text(e.toString()), loading: ()=> LinearProgressIndicator());
  }
}