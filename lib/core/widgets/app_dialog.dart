import 'package:erp_client_1/core/constain/app_color.dart';
import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as sh;

Future<void> showAppDialog(
  BuildContext context, {
  // required String title,
  // required double width,
  // required double height,
  required Widget child,
  bool barrierDismissible = false,
  void Function()? onClose,
}) async {
  await sh
      .showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        barrierColor: sh.Colors.black.withValues(alpha: .3),
        builder: (context) {
          return child;
          // return DialogWindows(
          //   width: width,
          //   height: height,
          //   title: title,
          //   child: child,
          // );
        },
      )
      .then((val) {
        onClose?.call();
      });
}

class DialogWindows extends StatelessWidget {
  const DialogWindows({
    super.key,
    required this.width,
    required this.height,
    required this.title,
    required this.child,
    this.beforeClose,
  });

  final double width;
  final double height;
  final String title;
  final Widget child;
  final void Function()? beforeClose;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Dialog(
        shadowColor: Colors.black,

        elevation: 15,
        insetPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            decoration: BoxDecoration(
              // color: Colors.yellow
              color: Colors.grey,
              border: Border.all(color: Colors.black.withValues(alpha: .1)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.6),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                  spreadRadius: 1,
                ),
              ],
            ),
            // padding: const EdgeInsets.all(10),
            width: width,
            height: height,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 28,
                  color: Colors.grey.shade200,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        Icon(PhosphorIcons.appWindow, color: Colors.blue.shade700),
                        SizedBox(width: 5),
                        Text(title, style: Theme.of(context).textTheme.labelMedium),
                        const Spacer(),
                        Material(
                          color: Colors.transparent,
                          child: SizedBox(
                            width: 40,
                            child: InkWell(
                              onTap: () {
                                if(beforeClose!=null){
                                  beforeClose?.call();
                                }else{
                                  Navigator.pop(context);
                                }
                              },
                              child: Icon(PhosphorIcons.x, color: Colors.red.shade700, size: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(height: 1,color: Colors.grey.shade100,),
                Expanded(child: child),
                // Expanded(child: widget.child)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
