import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../../../../core/widgets/widget.dart';
import '../../../data/model/taikhoan_lookup_model.dart';
import '../state/taikhoan_lookup_state.dart';

class TaiKhoanSoCaiCombobox extends ConsumerWidget {
  final void Function(dynamic)? onChanged;
  final String? selected;
  final bool enabled;
  const TaiKhoanSoCaiCombobox({super.key, this.selected, this.onChanged, this.enabled=true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(taiKhoanLookupProvider(LoaiTaiKhoan.soCai));
    return state.when(data: (value){
      return  AppCombobox(
        enabled: enabled,
        enabledClear: false,
        noSearch: false,
        menuWidth: 300,
        columnWidth: [50, 250],
        onChanged: onChanged,
        value: selected,
        items: value.map((e) => ComboboxItem(value: e.maTK, text: [e.maTK, e.tenTK])).toList(),
      );
    }, error: (e,s)=> Text(e.toString()), loading: ()=> LinearProgressIndicator());
  }
}