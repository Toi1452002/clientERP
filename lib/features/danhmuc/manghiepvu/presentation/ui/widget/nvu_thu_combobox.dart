import 'package:erp_client_1/core/widgets/app_combobox.dart';
import 'package:erp_client_1/features/danhmuc/manghiepvu/data/model/manghiepvu_model.dart';
import 'package:erp_client_1/features/danhmuc/manghiepvu/presentation/ui/state/manghiepvu_lookup_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class NvuThuCombobox extends ConsumerWidget {
  final void Function(dynamic)? onChanged;
  final String? selected;
  final bool enabled;
  const NvuThuCombobox({super.key, this.onChanged, this.selected, this.enabled=true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(maNghiepVuLookupProvider(KieuNghiepVu.thu));
    return state.when(
      data: (val) {
        return AppCombobox(
          onReload: (){
            ref.invalidate(maNghiepVuLookupProvider(KieuNghiepVu.thu));
          },
          enabled: enabled,
          onChanged: onChanged,
          enabledClear: false,
          value: selected,
          items: val.map((e) => ComboboxItem(value: e.maNV, text: [e.moTa])).toList(),
        );
      },
      error: (e, s) => Text(e.toString()),
      loading: () => LinearProgressIndicator(),
    );
  }
}
