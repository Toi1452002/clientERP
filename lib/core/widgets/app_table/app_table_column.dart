import 'package:flutter/material.dart';
import 'package:trina_grid/trina_grid.dart';

class AppTableColumn {
  final List<String> title;
  final bool isEdit;
  final double width;
  final bool showFooter;
  final double? padding;
  final ColumnType columnType;
  final ColumnAlign columnAlign;
  final bool readOnly;
  final bool hide;
  final TextStyle? textStyleFooter;
  final Widget Function(TrinaColumnRendererContext)? renderer;
  final bool showFilter;
  final Widget Function(TrinaColumnTitleRendererContext)? titleRenderer;
  final Color? headerColor;
  final bool frozen;

  AppTableColumn({
    required this.title,
    this.isEdit = false,
    this.width = 200,
    this.showFooter = false,
    this.padding,
    this.columnType = ColumnType.text,
    this.columnAlign = ColumnAlign.left,
    this.readOnly = false,
    this.hide = false,
    this.renderer,
    this.showFilter = true,
    this.textStyleFooter,
    this.titleRenderer,
    this.frozen = false,
    this.headerColor,
  });
}

enum ColumnType {
  text,
  num,
  boolean,
  date;

  TrinaColumnType get() {
    switch (this) {
      case ColumnType.text:
        return TrinaColumnType.text();
      case ColumnType.num:
        // TODO: Handle this case.
        return TrinaColumnType.number(format: '#,###.#');
      case ColumnType.date:
        // TODO: Handle this case.
        return TrinaColumnType.date(format: "dd/MM/yyyy", popupIcon: null, closePopupOnSelection: true);
      case ColumnType.boolean:
        return TrinaColumnType.boolean();
    }
  }
}

enum ColumnAlign {
  left,
  center,
  right;

  TrinaColumnTextAlign get() {
    switch (this) {
      case ColumnAlign.left:
        // TODO: Handle this case.
        return TrinaColumnTextAlign.left;
      case ColumnAlign.center:
        // TODO: Handle this case.
        return TrinaColumnTextAlign.center;
      case ColumnAlign.right:
        // TODO: Handle this case.
        return TrinaColumnTextAlign.right;
    }
  }
}
