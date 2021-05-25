///Package imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:satpj_front_end_web/src/model/practicante/practicante_horas.dart';
import 'dart:typed_data';

///Pdf import
import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'helper/save_file_web.dart';

/// Render pdf with annotations
class PdfCertificadoHoras {
  PdfCertificadoHoras();

  Future<void> createCertificate(PracticanteHoras practicanteHoras) async {
    String fecha = DateFormat('d/M/y').format(DateTime.now());
    //Create a PDF document.
    final PdfDocument document = PdfDocument();
    document.pageSettings.orientation = PdfPageOrientation.landscape;
    document.pageSettings.margins.all = 0;
    //Add page to the PDF
    final PdfPage page = document.pages.add();
    //Get the page size
    final Size pageSize = page.getClientSize();
    //Draw image
    page.graphics.drawImage(PdfBitmap(await _readImageData()),
        Rect.fromLTWH(0, 0, pageSize.width, pageSize.height));
    //Create font
    final PdfFont nameFont = PdfStandardFont(PdfFontFamily.helvetica, 22);
    final PdfFont controlFont = PdfStandardFont(PdfFontFamily.helvetica, 19);
    final PdfFont dateFont = PdfStandardFont(PdfFontFamily.helvetica, 16);
    double x = _calculateXPosition(
        practicanteHoras.practicante.nombre +
            " " +
            practicanteHoras.practicante.apellido,
        nameFont,
        pageSize.width);
    page.graphics.drawString(
        practicanteHoras.practicante.nombre +
            " " +
            practicanteHoras.practicante.apellido,
        nameFont,
        bounds: Rect.fromLTWH(x, 253, 0, 0),
        brush: PdfSolidBrush(PdfColor(20, 58, 86)));
    x = _calculateXPosition(practicanteHoras.horas.toString() + " horas",
        controlFont, pageSize.width);
    page.graphics.drawString(
        practicanteHoras.horas.toString() + " horas", controlFont,
        bounds: Rect.fromLTWH(x, 340, 0, 0),
        brush: PdfSolidBrush(PdfColor(20, 58, 86)));
    final String dateText = 'el ' + fecha;
    x = _calculateXPosition(dateText, dateFont, pageSize.width);
    page.graphics.drawString(dateText, dateFont,
        bounds: Rect.fromLTWH(x, 425, 0, 0),
        brush: PdfSolidBrush(PdfColor(20, 58, 86)));
    //Save and launch the document
    final List<int> bytes = document.save();
    //Dispose the document.
    document.dispose();
    //Save and launch file.
    FileSaveHelper.saveAndLaunchFile(
        bytes,
        'Certificado - ' +
            practicanteHoras.practicante.nombre +
            " " +
            practicanteHoras.practicante.apellido +
            '.pdf');
  }

  double _calculateXPosition(String text, PdfFont font, double pageWidth) {
    final Size textSize =
        font.measureString(text, layoutArea: Size(pageWidth, 0));
    return (pageWidth - textSize.width) / 2;
  }

  Future<List<int>> _readImageData() async {
    final ByteData data =
        await rootBundle.load('lib/src/utils/pdf/Certificado.png');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }
}
