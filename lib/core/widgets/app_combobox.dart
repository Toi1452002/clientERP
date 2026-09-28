import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart' as mt;
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter_extension.dart';

import 'app_textfield.dart';

class AppCombobox extends mt.StatefulWidget {
  final dynamic value;
  final List<ComboboxItem> items;
  final void Function(dynamic value)? onChanged;

  // final void Function()? onClear;
  final bool noSearch;
  final List<double>? columnWidth;
  final double? menuWidth;
  final double? width;
  final bool enabled;
  final bool noBorder;
  final void Function()? onTap;
  final void Function()? onReload;
  final void Function()? onAdd;
  final void Function(dynamic)? onDoubleTap;
  final double? sizeText;
  final bool enabledClear;

  const AppCombobox({
    super.key,
    this.value,
    required this.items,
    this.onChanged,
    this.noSearch = true,
    this.columnWidth,
    this.menuWidth,
    this.width,
    this.enabled = true,
    this.noBorder = false,
    this.onTap,
    this.onDoubleTap,
    this.sizeText,
    this.enabledClear = true,
    this.onReload,
    this.onAdd,
    // this.onClear,
  });

  @override
  mt.State<AppCombobox> createState() => _AppComboboxState();
}

class _AppComboboxState extends mt.State<AppCombobox> {
  final TextEditingController textEditingController = TextEditingController();
  final FocusNode focusDropDown = FocusNode();
  final FocusNode focusSearch = FocusNode();
  bool isOpen = false;

  @override
  void initState() {
    // TODO: implement initState
    focusDropDown.addListener(onChangedFocusDropdown);
    super.initState();
  }

  void onChangedFocusDropdown() {
    if (focusDropDown.hasFocus) {
      isOpen = true;
      if (!widget.noSearch) focusSearch.requestFocus();
    } else {
      isOpen = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final selectString = widget.items
        .firstWhere(
          (e) => e.value == widget.value,
          orElse: () => ComboboxItem(value: '0', text: ['']),
        )
        .text
        .first;

    return mt.DropdownButtonHideUnderline(
      child: DropdownButton2(
        focusNode: focusDropDown,
        onChanged: widget.enabled ? widget.onChanged : null,
        customButton: OutlinedContainer(
          borderWidth: widget.noBorder ? 0 : 1,
          backgroundColor: widget.noBorder ? Colors.transparent : context.theme.colorScheme.secondary,
          // borderColor: Colors.transparent,
          borderColor: widget.noBorder
              ? Colors.transparent
              : isOpen
              ? context.theme.colorScheme.primary
              : context.theme.colorScheme.border,
          padding: EdgeInsets.symmetric(horizontal: 5),
          // width: 300,
          height: 26,
          child: Row(
            children: [
              mt.InkWell(
                onDoubleTap: widget.onDoubleTap == null ? null : () => widget.onDoubleTap?.call(widget.value),
                child: Text(
                  selectString,
                  style: TextStyle(
                    fontSize: widget.noBorder ? 13 : 13,
                    color: !widget.enabled
                        ? Colors.gray.shade400
                        : widget.onDoubleTap == null
                        ? Colors.black
                        : Colors.red,
                    overflow: TextOverflow.ellipsis
                  ),
                ),
              ),
              Spacer(),
              if (widget.enabled && widget.onReload != null)
                mt.InkWell(
                  child: Icon(PhosphorIcons.arrowsClockwise, size: 15, color: Colors.gray.shade400),
                  onTap: () {
                    widget.onReload?.call();
                  },
                ),
              if (widget.value != null && widget.enabled && widget.enabledClear)
                mt.InkWell(
                  child: Icon(PhosphorIcons.x, size: 15, color: Colors.gray.shade400),
                  onTap: () {
                    widget.onChanged?.call(null);
                  },
                ),
              if (widget.enabled && widget.onAdd != null)
                mt.InkWell(
                  child: Icon(PhosphorIcons.plusCircle, size: 20, color: Colors.green),
                  onTap: () {
                    widget.onAdd?.call();
                  },
                ),
              Icon(PhosphorIcons.caretUpDown, size: 15, color: Colors.gray.shade400),
            ],
          ),
        ),
        style: TextStyle(fontSize: widget.sizeText ?? 14, color: Colors.black),
        valueListenable: ValueNotifier<dynamic>(widget.value),
        // value: widget.value,
        // items: widget.items.map((e)=>DropdownItem(child: null,)).toList(),
        isExpanded: true,
        items: widget.items
            .map(
              (e) => DropdownItem(
                value: e.value,
                height: 26,

                child: mt.Table(
                  // border: mt.TableBorder(
                  //   horizontalInside: BorderSide(color: Colors.black,width: 1)
                  // ),
                  columnWidths: widget.columnWidth == null
                      ? null
                      : Map.fromEntries([
                          for (int i = 0; i < widget.columnWidth!.length; i++)
                            MapEntry(i, mt.FixedColumnWidth(widget.columnWidth![i])),
                        ]),
                  children: [
                    mt.TableRow(
                      children: e.text
                          .map((e) => Text(e, softWrap: false, style: TextStyle(fontSize: widget.sizeText ?? 13)))
                          .toList(),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
        dropdownStyleData: DropdownStyleData(
          // isOverButton: !widget.noSearch,
          width: widget.menuWidth,
          maxHeight: 260,
          padding: EdgeInsets.zero,
          elevation: 2,
          decoration: BoxDecoration(border: Border.all(width: .2)),
        ),

        menuItemStyleData: MenuItemStyleData(
          // height: 25,
          padding: EdgeInsets.symmetric(horizontal: 5),
          selectedMenuItemBuilder: (context, child) {
            return Container(color: Colors.blue.shade300, child: child);
          },
        ),
        dropdownSearchData: widget.noSearch
            ? null
            : DropdownSearchData(
                searchController: textEditingController,

                // searchInnerWidgetHeight: 50,
                searchBarWidgetHeight: 50,

                searchBarWidget: mt.Padding(
                  padding: const EdgeInsets.all(5),
                  child: AppTextField(
                    hintText: 'Search',
                    focusNode: focusSearch,

                    autofocus: true,
                    controller: textEditingController,
                  ),
                ),
                searchMatchFn: (item, searchValue) {
                  return item.value.toString().toLowerCase().contains(searchValue.toLowerCase());
                },
              ),

        onMenuStateChange: (val) {
          if (val) widget.onTap?.call();
          setState(() {
            isOpen = val;
          });
          if (!val) textEditingController.clear();
        },
      ),
    );
  }
}

class ComboboxItem {
  final dynamic value;
  final List<String> text;

  const ComboboxItem({required this.value, required this.text});
}
