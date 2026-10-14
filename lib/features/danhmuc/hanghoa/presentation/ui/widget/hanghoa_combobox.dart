import 'package:collection/collection.dart';
import 'package:erp_client_1/core/widgets/app_combobox.dart';
import 'package:erp_client_1/core/widgets/app_dialog.dart';
import 'package:erp_client_1/features/danhmuc/hanghoa/presentation/dialog/hanghoa_form_dialog.dart';
import 'package:erp_client_1/features/danhmuc/hanghoa/presentation/ui/state/hanghoa_lookup_provider.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/widgets/app_alert.dart';

class HangHoaCombobox extends ConsumerWidget {
  final String? selected;
  final bool enabled;
  final bool noBorder;
  final void Function(dynamic)? onChanged;
  final bool noDVT;
  final void Function()? onTap;
  const HangHoaCombobox({
    super.key,
    this.enabled = true,
    this.noBorder = false,
    this.selected,
    this.onChanged,
    this.noDVT = false,
    this.onTap
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(hangHoaLookupProvider);
    return state.when(
      skipLoadingOnRefresh: false,
      data: (val) {
        return AppCombobox(
          onTap: onTap,
          noBorder: noBorder,
          enabled: enabled,
          onChanged: onChanged,
          onDoubleTap: (hh){
            final hangHoa = val.firstWhereOrNull((e)=>e.maHH==hh);
            if(hangHoa!=null){
              showAppDialog(context, child: HangHoaFormDialog(id: hangHoa.id,));
            }else{
              showInfo(context, "Không tìm thấy hàng hóa!");

            }
          },
          value: selected,
          noSearch: false,
          enabledClear: false,
          menuWidth:!noDVT? 540: 300,
          columnWidth: [!noDVT?150:90,!noDVT? 300:190, if(!noDVT)90],
          items: val.map((e) => ComboboxItem(value: e.maHH, text: [e.maHH, e.tenHH,if(!noDVT) e.dvt ?? ""])).toList(),
        );
      },
      error: (e, s) => Center(child: Text(e.toString())),
      loading: () => LinearProgressIndicator(),
    );
  }
}
