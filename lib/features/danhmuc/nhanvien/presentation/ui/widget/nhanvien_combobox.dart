import 'dart:math';

import 'package:collection/collection.dart';
import 'package:erp_client_1/core/widgets/app_alert.dart';
import 'package:erp_client_1/core/widgets/app_combobox.dart';
import 'package:erp_client_1/core/widgets/app_dialog.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/presentation/dialog/nhanvien_form_dialog.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/presentation/ui/state/nhanvien_lookup_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class NhanVienCombobox extends ConsumerWidget {
  const NhanVienCombobox({
    super.key,
    this.selected,
    this.onChanged,
    this.enabled = true,
    this.noBorder = false,
    this.enabledClear = true,
  });

  final String? selected;
  final bool noBorder;
  final void Function(dynamic)? onChanged;
  final bool enabled;
  final bool enabledClear;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(nhanVienLookupProvider);
    return state.when(
      skipLoadingOnRefresh: false,
      data: (val) {
        return AppCombobox(
          onDoubleTap: (maNV){
            final nv = val.firstWhereOrNull((e)=>e.maNV==maNV);
            if(nv!=null){
              showAppDialog(context, child: NhanVienFormDialog(id: nv.id,));
            }else{
              showInfo(context, "Không tìm thấy nhân viên!");
            }
          },
          noSearch: false,
          noBorder: noBorder,
          enabledClear: enabledClear,
          enabled: enabled,
          onChanged: onChanged,
          value: selected,
          menuWidth: 300,
          columnWidth: [50, 250],
          items: val.map((e) => ComboboxItem(value: e.maNV, text: [e.maNV, e.tenNV])).toList(),
        );
      },
      error: (e, s) => Center(child: Text(e.toString())),
      loading: () => LinearProgressIndicator(),
    );
  }
}
