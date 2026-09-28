import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter_extension.dart';

class AppButtonPage extends StatelessWidget {
  final void Function()? first;
  final void Function()? back;
  final void Function()? next;
  final void Function()? last;
  final String firstText;
  final String secondText;

  const AppButtonPage({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.first,
    required this.last,
    required this.back,
    required this.next,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      children: [
        IconButton.secondary(
          icon: Icon(PhosphorIcons.rewind),
          onPressed: first,
          // enabled: enabled,
          size: ButtonSize(.7),
        ),
        IconButton.secondary(icon: Icon(PhosphorIcons.skipBack), onPressed: back, size: ButtonSize(.7)),
        SizedBox(
          width: 50,
          child: ColoredBox(
            color: context.theme.colorScheme.card,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(firstText),
                Text("/"),
                Text(secondText),
              ],
            ),
          ),
        ),
        IconButton.secondary(
          icon: Icon(PhosphorIcons.skipForward),
          onPressed: next,
          size: ButtonSize(.7),
        ),
        IconButton.secondary(
          icon: Icon(PhosphorIcons.fastForward),
          onPressed: last,
          size: ButtonSize(.7),
        )
      ],
    );
  }
}
