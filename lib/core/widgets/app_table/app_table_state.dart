import 'package:trina_grid/trina_grid.dart';

abstract class AppTableState<T>{
  void setCurrent(TrinaColumnRendererContext context) {
    context.stateManager.setCurrentCell(context.cell, context.rowIdx);
    context.stateManager.setKeepFocus(true);
  }

  void delete(TrinaColumnRendererContext context) {
    context.stateManager.removeCurrentRow();
  }

  String getColumnField(TrinaCell cell){
    return cell.column.field;
  }

  void loadView(List<T> data);


}