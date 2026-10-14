import 'package:erp_client_1/core/widgets/widget.dart';
import 'package:erp_client_1/features/report/presentation/notifier/report_notifier.dart';
import 'package:pdf_viewer_plus/pdf_viewer_plus.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:printing/printing.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trina_grid/trina_grid.dart';

class ReportDialog extends ConsumerStatefulWidget {
  const ReportDialog({super.key});

  @override
  ConsumerState createState() => _ReportDialogState();
}

class _ReportDialogState extends ConsumerState<ReportDialog> {

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(reportProvider);
    return Scaffold(
      headers: [
        AppBar(
          leading: [
            AppPrintButton(
              onPressed: () async {
                Printer print = Printer(url: "Microsoft Print to PDF");
                await Printing.directPrintPdf(
                  onLayout: (e) => state.value!,
                  format: PdfPageFormat.a4.portrait,
                  printer: print,
                );
              },
            ),
          ],
          trailing: [
            OutlineButton(
              child: Icon(PhosphorIcons.x),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ],
      child: state.when(
        data: (val) {
          return PdfViewer(
            pdfData: val,
            showZoomHint: false,
            sidebarBackgroundColor: Colors.gray.shade100,
            panAxis: PanAxis.free,
          );
        },
        error: (e, s) => Center(child: Text(e.toString())),
        loading: () => Center(child: CircularProgressIndicator(size: 50)),
      ),
    );
  }
}
