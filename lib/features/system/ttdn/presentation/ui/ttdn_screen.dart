import 'package:erp_client_1/core/constain/app_color.dart';
import 'package:erp_client_1/core/widgets/app_alert.dart';
import 'package:erp_client_1/core/widgets/app_button.dart';
import 'package:erp_client_1/core/widgets/app_header.dart';
import 'package:erp_client_1/core/widgets/app_table/app_table.dart';
import 'package:erp_client_1/features/system/ttdn/presentation/notifier/ttdn_notifier.dart';
import 'package:erp_client_1/features/system/ttdn/presentation/ui/state/ttdn_table_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class TTDNScreen extends ConsumerStatefulWidget {
  const TTDNScreen({super.key});

  @override
  ConsumerState createState() => _TTDNScreenState();
}

class _TTDNScreenState extends ConsumerState<TTDNScreen> {
  late TTDNTableManager _manager;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(ttdnProvider);
    return Scaffold(
      backgroundColor: AppColor.background,
      footers: [
        AppFooter()
      ],
      headers: [
        AppHeader(
          title: "Thông tin doanh nghiệp",
        ),
      ],
      child: state.when(
        skipLoadingOnRefresh: false,
        data: (val) {
          return AppTable(
            onLoaded: (e){
              _manager = TTDNTableManager(e.stateManager);
              _manager.loadView(val);
            },
            onChange: (re) async {
              final field = re.column.field;
              final id = re.row.cells['Id']?.value;
              if(field == "NoiDung"){
               try{
                await ref.read(ttdnProvider.notifier).updateNoiDung(re.value, id);
               }catch(e){
                 showInfo(context, e.toString());
               }
              }
            },
            columns: [
              AppTableColumn(
                title: ['#', 'stt'],
                width: 35,
                readOnly: true,
                renderer: (re) => AppTableCell.textNum("${re.rowIdx + 1}"),
              ),
              AppTableColumn(title: ["", "Id"], hide: true),
              AppTableColumn(
                title: ['Tiêu đề', 'TieuDe'],
                readOnly: true,
                width: 300,
                renderer: (re) => AppTableCell.textBlue(re.cell.value),
              ),
              AppTableColumn(title: ['Nội dung', 'NoiDung'], width: 690, isEdit: true),
            ],
          );
        },
        error: (e, s) => Center(child: Text(e.toString())),
        loading: () => Center(child: CircularProgressIndicator(size: 50)),
      ),
    );
  }
}
