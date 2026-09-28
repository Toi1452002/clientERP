import 'package:shadcn_flutter/shadcn_flutter.dart';

void showError(BuildContext context, String text) {
  FocusNode focus = FocusNode();
  showDialog(
    context: context,
    builder: (context) {
      focus.requestFocus();
      return AlertDialog(
        title: const Text('Lỗi!'),
        content: Text(text),
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
    },
  );
}

Future<void> showInfo(BuildContext context, String text) async {
  FocusNode focus = FocusNode();
  await showDialog(
    context: context,
    builder: (context) {
      focus.requestFocus();
      return AlertDialog(
        title: const Text('Thông báo'),
        content: SizedBox(width: 300, child: Text(text)),
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
    },
  );
}

Future<void> showSuccess(BuildContext context, String text, void Function()? onPressed) async {
  FocusNode focus = FocusNode();
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      focus.requestFocus();
      return AlertDialog(
        title: const Text('Thông báo'),
        content: SizedBox(width: 300, child: Text(text)),
        actions: [
          PrimaryButton(
            focusNode: focus,
            child: const Text('OK'),
            onPressed: () {
              onPressed?.call();
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

void showQuestion(BuildContext context, {void Function()? onPressed, String? text}) {
  FocusNode focus = FocusNode();
  showDialog(
    context: context,
    builder: (context) {
      focus.requestFocus();
      return AlertDialog(
        title: const Text('Thông báo!'),
        content: SizedBox(width: 300, child: Text(text ?? 'Có chắc muốn xóa?')),
        actions: [
          OutlineButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          PrimaryButton(
            focusNode: focus,
            onPressed: () {
              onPressed?.call();
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

void showClosePhieu(BuildContext context, {void Function()? onPressed}) {
  FocusNode focus = FocusNode();
  showDialog(
    context: context,
    builder: (context) {
      focus.requestFocus();
      return AlertDialog(
        title: const Text('Thông báo!'),
        content: SizedBox(width: 300, child: Text("Phiếu đang có thay đổi chưa lưu.\nBạn có muốn lưu trước khi đóng?")),
        actions: [
          OutlineButton(
            child: const Text('Không lưu'),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
          OutlineButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Hủy'),
          ),
          PrimaryButton(
            focusNode: focus,
            onPressed: () {
              onPressed?.call();
              Navigator.pop(context);
            },
            child: Text("Lưu"),
          ),
        ],
      );
    },
  );
}
