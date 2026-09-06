import 'package:erp_client_1/core/widgets/app_combobox.dart';
import 'package:erp_client_1/features/danhmuc/hanghoa/presentation/ui/state/hanghoa_lookup_provider.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HangHoaCombobox extends ConsumerWidget {
  final String? selected;
  final bool enabled;
  final bool noBorder;
  final void Function(dynamic)? onChanged;

  const HangHoaCombobox({super.key, this.enabled = true, this.noBorder = false, this.selected, this.onChanged});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(hangHoaLookupProvider);
    return state.when(
      data: (val) {
        return AppCombobox(
          noBorder: noBorder,
          enabled: enabled,
          onChanged: onChanged,
          value: selected,
          noSearch: false,
          enabledClear: false,
          menuWidth:540 ,
          columnWidth: [150,300,90],
          items: val.map((e) => ComboboxItem(value: e.maHH, text: [e.maHH, e.tenHH,e.dvt??""])).toList(),
        );
      },
      error: (e, s) => Center(child: Text(e.toString())),
      loading: () => LinearProgressIndicator(),
    );
  }
}
