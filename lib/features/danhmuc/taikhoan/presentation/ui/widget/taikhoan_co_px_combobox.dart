import 'package:erp_client_1/features/danhmuc/taikhoan/presentation/ui/state/taikhoan_lookup_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../../../../core/widgets/app_combobox.dart';
import '../../../data/model/taikhoan_lookup_model.dart';

class TaiKhoanCoPxCombobox extends ConsumerWidget {
  final void Function(dynamic)? onChanged;
  final String? selected;
  final bool enabled;
  final bool noBorder;
  const TaiKhoanCoPxCombobox({super.key, this.selected, this.onChanged, this.noBorder=false, this.enabled=true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(taiKhoanLookupProvider(LoaiTaiKhoan.tkCoPx));
    return state.when(data: (value){
      return  AppCombobox(
        enabledClear: true,
        noBorder: noBorder,
        enabled: enabled,
        menuWidth: 300,
        columnWidth: [50, 250],
        onChanged: onChanged,
        value: selected,
        items: value.map((e) => ComboboxItem(value: e.maTK, text: [e.maTK, e.tenTK])).toList(),
      );
    }, error: (e,s)=> Text(e.toString()), loading: ()=> LinearProgressIndicator());
  }
}