import 'package:erp_client_1/core/widgets/app_combobox.dart';
import 'package:erp_client_1/features/system/roles/presentation/notifier/role_view_notifier.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoleCombobox extends ConsumerWidget {
  final int? selectId;
  final void Function(dynamic)? onChanged;
  final void Function()? onAdd;
  const RoleCombobox({super.key, this.onChanged, this.selectId, this.onAdd});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(roleViewProvider);
    return state.when(
      data: (value) {
        return AppCombobox(
          onAdd: onAdd,
          enabledClear: false,
          items: value.map((e) => ComboboxItem(value: e.id, text: [e.roleName])).toList(),
          onChanged: onChanged,
          value: selectId,
        );
      },
      error: (e, s) => Center(child: Text(e.toString())),
      loading: () => Center(child: LinearProgressIndicator()),
    );
  }
}
