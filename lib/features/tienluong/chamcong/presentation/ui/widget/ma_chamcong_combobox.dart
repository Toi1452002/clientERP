import 'package:erp_client_1/core/widgets/app_combobox.dart';
import 'package:erp_client_1/features/tienluong/chamcong/data/model/macc_model.dart';
import 'package:erp_client_1/features/tienluong/chamcong/data/repository/chamcong_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

final maCCProvider = FutureProvider<List<MaCCModel>>((ref) async {
  final data = ref.read(chamCongRepositoryProvider).getListMaCC();
  return data;
});

class MaChamCongCombobox extends ConsumerWidget {
  const MaChamCongCombobox({super.key, this.onChanged, required this.selectedValue, this.onTap});
  final void Function(dynamic)? onChanged;
  final String selectedValue;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(maCCProvider);
    return state.when(
      data: (val) => AppCombobox(
        onChanged: onChanged,
        noBorder: true,
        enabledClear: false,
        value: selectedValue,
        onTap: onTap,
        items: val.map((e) => ComboboxItem(value: e.ma, text: [e.ma])).toList(),
      ),
      error: (e, s) => Center(child: Text(e.toString())),
      loading: () => Center(child: LinearProgressIndicator()),
    );
  }
}
