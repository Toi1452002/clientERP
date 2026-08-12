import 'package:flutter/material.dart';

class AppRow extends StatelessWidget {
  final Map<int, double>? columnWidths;
  final List<Widget> items;

  const AppRow({super.key, this.columnWidths, required this.items});

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: columnWidths?.map((k,v)=>MapEntry(k, FixedColumnWidth(v))),
      children: [
        TableRow(
          children: items
              .map((e) => TableCell(verticalAlignment: TableCellVerticalAlignment.middle, child: e))
              .toList(),
        ),
      ],
    );
  }
}