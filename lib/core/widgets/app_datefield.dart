import 'package:erp_client_1/core/widgets/app_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/date_helper.dart';
import 'app_textfield.dart';

class AppDateField extends StatefulWidget {
  final DateTime? value;
  final void Function(DateTime? date)? onChanged;
  final bool enabled;
  final bool autofocus;
  final FocusNode? focusNode;
  const AppDateField({super.key, this.value, this.onChanged, this.enabled = true, this.autofocus = false,this.focusNode});

  @override
  State<AppDateField> createState() => _AppDateFieldState();
}

class _AppDateFieldState extends State<AppDateField> {
  final _controller = TextEditingController();
  // final _focus = FocusNode();
  @override
  void initState() {
    if(widget.value!=null){
      _controller.text = DateHelper.dMy(widget.value)??'';
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AppDateField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.value != widget.value) {
      _controller.text = DateHelper.dMy(widget.value) ?? '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    // _focus.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AppTextField(
      enabled:widget.enabled ,
      hintText: "dd/mm/yyyy",
      controller: _controller,
      focusNode: widget.focusNode,
      isDateField: true,
      textAlign: TextAlign.center,
      autofocus: widget.autofocus,
      onFieldLeave: (){
        final b = DateHelper.stringToDate(_controller.text);
        // if(b==null && _controller.text.isNotEmpty) {
        //   showInfo(context,'Ngày không hợp lệ!');
        //   _focus.requestFocus();
        // }
        if(b!=null){
          _controller.text = DateHelper.dMy(b)??'';
        }
        widget.onChanged?.call(b);
      },
    );
  }
}
