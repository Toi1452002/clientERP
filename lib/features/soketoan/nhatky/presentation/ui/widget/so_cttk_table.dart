import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../../../../core/widgets/widget.dart';
import '../../../data/model/socttk_model.dart';
import '../state/socttk_table_manager.dart';

class SoCTTKTable extends ConsumerStatefulWidget {
  const SoCTTKTable({super.key, required this.data});
  final List<SoCTTKModel> data;
  @override
  ConsumerState createState() => _SoCTTKTableState();
}

class _SoCTTKTableState extends ConsumerState<SoCTTKTable> {
  late SoCTTKTableManager _manager;

  @override
  Widget build(BuildContext context) {
    return AppTable(
      onLoaded: (e) {
        _manager = SoCTTKTableManager(e.stateManager);
        // if (val != null) {
          _manager.loadView(widget.data);
        // }
      },
      columns: [
        AppTableColumn(
          title: ['#', 'stt'],
          width: 35,
          readOnly: true,
          showFilter: false,
          renderer: (re) => AppTableCell.textNum("${re.rowIdx + 1}"),
        ),
        AppTableColumn(
          title: ['Ngày ghi sổ', 'Ngay'],
          width: 100,
          columnType: ColumnType.date,
          columnAlign: ColumnAlign.center,
        ),
        AppTableColumn(
          title: ['Số CT', 'ChungTu'],
          width: 100,
          columnAlign: ColumnAlign.center,
          renderer: (re) => AppTableCell.textBlue(re.cell.value),
        ),
        AppTableColumn(
          title: ['Ngày CT', 'NgayCT'],
          width: 90,
          columnType: ColumnType.date,
          columnAlign: ColumnAlign.center,
        ),
        AppTableColumn(title: ['Diễn giải', 'DienGiai'], width: 300),
        AppTableColumn(title: ['TKDU', 'TKDU'], width: 80, columnAlign: ColumnAlign.center),
        AppTableColumn(
          title: ['PS Nợ', 'PSNo'],
          width: 120,
          columnType: ColumnType.num,
          showFooter: true,
          columnAlign: ColumnAlign.right,
        ),
        AppTableColumn(
          title: ['PS Có', 'PSCo'],
          width: 120,
          columnType: ColumnType.num,
          showFooter: true,
          columnAlign: ColumnAlign.right,
        ),
        AppTableColumn(
          title: ['Số dư nợ', 'SDNo'],
          width: 120,
          columnType: ColumnType.num,
          // showFooter: true,
          columnAlign: ColumnAlign.right,
        ),
        AppTableColumn(
          title: ['Số dư có', 'SDCo'],
          width: 120,
          columnType: ColumnType.num,
          // showFooter: true,
          columnAlign: ColumnAlign.right,
        ),
      ],
    );
  }
}
