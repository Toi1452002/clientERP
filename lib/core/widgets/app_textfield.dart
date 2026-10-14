// import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;

  final String? hintText;

  final bool readOnly;
  final bool enabled;
  final bool autofocus;
  final bool isNumber;
  final bool filled;
  final bool isDateField;
  final bool isUpperCase;
  final bool isDouble;

  final int maxLines;
  final double width;
  final TextAlign textAlign;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;

  final ValueChanged<String>? onChanged;
  final VoidCallback? onFieldLeave;
  final Widget? suffix;
  final List<InputFeature>? features;
  final bool obscureText;
  final int? maxLength;
  final void Function(String)? onSubmitted;
  const AppTextField({
    super.key,
    this.maxLength,
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.hintText,
    this.readOnly = false,
    this.enabled = true,
    this.autofocus = false,
    this.isNumber = false,
    this.filled = true,
    this.maxLines = 1,
    this.width = 220,
    this.textAlign = TextAlign.left,
    this.onChanged,
    this.onFieldLeave,
    this.suffix,
    this.features,
    this.obscureText = false,
    this.isDateField = false,
    this.isDouble = false,
    this.isUpperCase = false,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.onSubmitted
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = widget.focusNode ?? FocusNode();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        final nextFocus = FocusManager.instance.primaryFocus;
        final isViewScope = nextFocus.toString().contains('View Scope');
        if (nextFocus != null && !isViewScope) {
          _triggerLeave();
        }
      }
    });

    super.initState();
  }

  // String normalize(String? value) {
  //   return value?.trim() ?? '';
  // }

  void _triggerLeave() {
    // final text = normalize(widget.provider?.text);
    // if (_oldValue != text) {
      widget.onFieldLeave?.call();
    // }

    // _oldValue = text;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: widget.onSubmitted,
      features: widget.features ?? [],
      obscureText: widget.obscureText,
      controller: widget.controller,
      autofocus: widget.autofocus,
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      focusNode: _focusNode,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      textAlign: widget.textAlign,
      style: TextStyle(
        fontSize: widget.fontSize ?? 13,
        height: 1.2,
        fontWeight: widget.fontWeight,
        color: widget.enabled ? widget.color ?? Colors.black : Colors.gray.shade400,
      ),
      placeholder: Text(widget.hintText ?? ''),
      keyboardType: widget.isNumber ? const TextInputType.numberWithOptions(decimal: true) : TextInputType.text,
      inputFormatters: [
        if (widget.isUpperCase) TextInputFormatters.toUpperCase,
        if (widget.isDouble) FilteringTextInputFormatter.allow(RegExp(r'[\d\.]')),
        if (widget.isNumber) FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
      ],
      // decoration: InputDecoration(
      //   suffixIcon: widget.suffix,
      //   hintText: widget.hintText,
      //   hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 13),
      //   isDense: true,
      //   filled: widget.filled,
      //   fillColor: widget.readOnly ? Colors.grey.shade100 : Colors.white,
      //   contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      //   suffixIconConstraints: const BoxConstraints(
      //     minHeight: 26,
      //     minWidth: 24,
      //   ),
      //   // border: OutlineInputBorder(
      //   //   borderRadius: BorderRadius.circular(4),
      //   //   borderSide: BorderSide(
      //   //     color: borderColor,
      //   //   ),
      //   // ),
      //   enabledBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(4),
      //     borderSide: BorderSide(color: Colors.grey.shade400),
      //   ),
      //   focusedBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(4),
      //     borderSide: BorderSide(color: Colors.blue.shade800, width: 1.5),
      //   ),
      // ),
      onChanged: widget.onChanged,
      textInputAction: TextInputAction.next,
    );
  }
}
