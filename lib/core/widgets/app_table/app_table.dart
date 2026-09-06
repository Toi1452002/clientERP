import 'package:erp_client_1/core/constain/app_color.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:trina_grid/trina_grid.dart';
import 'app_table_column.dart';

export 'app_table_cell.dart';
export 'app_table_column.dart';

class AppTable extends StatelessWidget {
  const AppTable({
    super.key,
    this.onRowDoubleTap,
    this.onChange,
    this.rowColorCallback,
    this.onLoaded,
    this.columnGroups,
    this.mode = TrinaGridMode.normal,
    required this.columns,
    this.columnHeight,
    this.readOnlyColor,
    this.headerColors,
    this.cellColorCallback,
    // required this.rows,
  });

  final void Function(TrinaGridOnRowDoubleTapEvent)? onRowDoubleTap;
  final void Function(TrinaGridOnChangedEvent)? onChange;
  final Color Function(TrinaRowColorContext)? rowColorCallback;
  final void Function(TrinaGridOnLoadedEvent)? onLoaded;
  final Color? Function(TrinaCellColorContext)? cellColorCallback;
  // final List<TrinaRow<dynamic>> rows;
  final List<TrinaColumnGroup>? columnGroups;
  final TrinaGridMode mode;
  final List<AppTableColumn> columns;
  final double? columnHeight;
  final Color? readOnlyColor;
  final Color? headerColors;

  @override
  Widget build(BuildContext context) {
    return TrinaGrid(
      cellColorCallback: cellColorCallback,
      rowColorCallback: rowColorCallback,

      columns: columns
          .map(
            (e) => TrinaColumn(
              renderer: e.renderer,
              title: e.title.first,
              field: e.title.last,
              type: e.columnType.get(),
              footerRenderer: !e.showFooter
                  ? null
                  : (rendererContext) {
                      return TrinaAggregateColumnFooter(
                        rendererContext: rendererContext,
                        type: TrinaAggregateColumnType.sum,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        titleSpanBuilder: (text) {
                          return [
                            TextSpan(
                              text: text,
                              style: e.textStyleFooter ?? TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ];
                        },
                      );
                    },
              hide: e.hide,
              titleRenderer: e.titleRenderer,
              enableColumnDrag: false,
              enableContextMenu: false,
              enableDropToResize: false,
              enableFilterMenuItem: e.showFilter,
              titleTextAlign: TrinaColumnTextAlign.center,
              enableSorting: false,
              enableAutoEditing: true,
              enableEditingMode: e.isEdit,
              width: e.width,
              readOnly: e.readOnly,
              cellPadding: EdgeInsets.symmetric(vertical: 0, horizontal: e.padding ?? 3),
              textAlign: e.columnAlign.get(),
              backgroundColor: e.headerColor ?? Colors.gray.shade100,
              frozen: e.frozen ? TrinaColumnFrozen.start : TrinaColumnFrozen.none,
              // filterPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 3),
            ),
          )
          .toList(),

      // rows: rows,

      //Config
      onRowDoubleTap: onRowDoubleTap,
      onChanged: onChange,
      onLoaded: onLoaded,
      mode: mode,
      columnGroups: columnGroups,
      configuration: TrinaGridConfiguration(
        tabKeyAction: TrinaGridTabKeyAction.moveToNextOnEdge,
        enterKeyAction: TrinaGridEnterKeyAction.editingAndMoveRight,
        scrollbar: TrinaGridScrollbarConfig(
          showHorizontal: true,
          radius: 0,
          thickness: 10,
          isAlwaysShown: true,
        ),
        columnSize: const TrinaGridColumnSizeConfig(autoSizeMode: TrinaAutoSizeMode.none),

        localeText: TrinaGridLocaleText(filterContains: ''),

        shortcut: TrinaGridShortcut(
          actions: {...TrinaGridShortcut.defaultActions, LogicalKeySet(LogicalKeyboardKey.escape): EscKeyAction()},
        ),
        style: TrinaGridStyleConfig(
          columnFilterHeight: 25,

          filterIcon: null,
          columnHeight: columnHeight ?? 25,
          cellReadonlyColor: readOnlyColor ?? Colors.gray.shade100,
          defaultColumnFilterPadding: EdgeInsets.zero,
          // borderColor: Colors.black.withValues(alpha: .2),
          borderColor: AppColor.border300,
          gridBorderColor: AppColor.border300,
          gridBorderRadius: BorderRadius.circular(2),
          activatedBorderColor: Colors.blue.shade600,
          // columnHeight: widget.columnHeight ?? 25,
          activatedColor: Colors.blue.withValues(alpha: .1),
          rowHeight: 25,
          columnTextStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black),

          // rowColor: context.theme.colorScheme.popover,
          cellTextStyle: TextStyle(fontSize: 12, color: Colors.black),
          defaultCellPadding: const EdgeInsets.only(left: 3, right: 4),
        ),
      ), rows: [],
    );
  }
}

class EscKeyAction extends TrinaGridShortcutAction {
  @override
  void execute({required TrinaKeyManagerEvent keyEvent, required TrinaGridStateManager stateManager}) {
    stateManager.clearCurrentSelecting();
    stateManager.clearCurrentCell();
    stateManager.setKeepFocus(false);
  }
}
