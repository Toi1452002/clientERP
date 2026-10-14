import 'package:collection/collection.dart';
import 'package:erp_client_1/features/danhmuc/khach/presentation/dialog/khach_form_dialog.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/widgets/widget.dart';
import '../../../data/model/khach_lookup_model.dart';
import '../state/khach_lookup_state.dart';

class NhaCungCombobx extends ConsumerWidget {
  final String? selected;
  final void Function(dynamic)? onChanged;
  final bool enabled;
  final bool clear;
  final bool showAdd;
  const NhaCungCombobx({super.key, this.selected, this.onChanged, this.enabled=true, this.clear = true, this.showAdd = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(khachLookupProvider(LoaiKH.NhaCung));
    return state.when(
      skipLoadingOnRefresh: false,
      data: (value) {
        return AppCombobox(
          onAdd:!showAdd?null: (){
            showAppDialog(context, child: KhachFormDialog());
          },
          onDoubleTap: (val){
            final kh = value.firstWhereOrNull((e)=>e.maKH==val);
            if(kh!=null){
              showAppDialog(context, child: KhachFormDialog(id: kh.id,));
            }else{
              showInfo(context, "Không tìm thấy khách hàng!");
            }

          },
          noSearch: false,
          enabled: enabled,
          onChanged: onChanged,
          value: selected,
          enabledClear: clear,
          menuWidth: 400,
          columnWidth: [100, 300],
          items: value.map((e) => ComboboxItem(value: e.maKH, text: [e.maKH, e.tenKH])).toList(),
        );
      },
      error: (e, s) => Text(e.toString()),
      loading: () => LinearProgressIndicator(),
    );
  }
}
