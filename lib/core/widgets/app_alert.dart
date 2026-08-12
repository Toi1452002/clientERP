import 'package:shadcn_flutter/shadcn_flutter.dart';

void showError(BuildContext context, String text){
  FocusNode focus = FocusNode();
  showDialog(context: context, builder: (context){
    focus.requestFocus();
    return AlertDialog(
      title: const Text('Lỗi!'),
      content:  Text(text),
      actions: [
        PrimaryButton(
          focusNode: focus,
          child: const Text('OK'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );

  });
}
void showInfo(BuildContext context, String text){
  FocusNode focus = FocusNode();
  showDialog(context: context, builder: (context){
    focus.requestFocus();
    return AlertDialog(
      title: const Text('Thông báo'),
      content:  SizedBox(width: 300,child: Text(text),),
      actions: [
        PrimaryButton(
          focusNode: focus,
          child: const Text('OK'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );

  });
}
void showQuestion(BuildContext context,{void Function()? onPressed, String? text}){
  FocusNode focus = FocusNode();
  showDialog(context: context, builder: (context){
    focus.requestFocus();
    return AlertDialog(
      title: const Text('Thông báo!'),
      content:  SizedBox(width: 300,child: Text(text??'Có chắc muốn xóa?'),),
      actions: [
        OutlineButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        PrimaryButton(
          focusNode: focus,
          onPressed: (){
            onPressed?.call();
            Navigator.pop(context);
          },
          child: const Text('OK'),
        ),
      ],
    );

  });
}