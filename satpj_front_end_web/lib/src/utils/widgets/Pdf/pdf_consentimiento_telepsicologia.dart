///Package imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'dart:typed_data';

///Pdf import
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'helper/info_paciente_telepsicologia_pdf.dart';

/// Render pdf with annotations
class PdfConsentimientoTelepsicologia {
  InfoPacienteTelepsicologiaPdf infoPaciente;

  PdfConsentimientoTelepsicologia(InfoPacienteTelepsicologiaPdf infoPaciente) {
    this.infoPaciente = infoPaciente;
  }

  /// Creates pdf with annotations
  Future<List<int>> generatePDF() async {
    String nowD = DateFormat("dd").format(DateTime.now());
    String nowM = DateFormat("MM").format(DateTime.now());
    String nowY = DateFormat("yyyy").format(DateTime.now());
    //Load the PDF document.
    final PdfDocument document =
        PdfDocument(inputBytes: await _readDocumentData('consentimiento.pdf'));

    //Get the page.
    final PdfPage page2 = document.pages[1];
    page2.graphics.drawString(
        infoPaciente.nombre, PdfStandardFont(PdfFontFamily.timesRoman, 9),
        bounds: Rect.fromLTWH(108, 223, 500, 40));
    if (infoPaciente.tipoDocumento == "Cédula de Ciudadanía") {
      page2.graphics.drawString(
          infoPaciente.documento, PdfStandardFont(PdfFontFamily.timesRoman, 9),
          bounds: Rect.fromLTWH(398, 223, 500, 40));
    } else {
      page2.graphics.drawString(
          infoPaciente.tipoDocumento + ":" + infoPaciente.documento,
          PdfStandardFont(PdfFontFamily.timesRoman, 9),
          bounds: Rect.fromLTWH(398, 223, 500, 40));
    }
    page2.graphics.drawString(
        infoPaciente.ciudad, PdfStandardFont(PdfFontFamily.timesRoman, 9),
        bounds: Rect.fromLTWH(85, 250.5, 500, 40));

    page2.graphics.drawString(
        nowD, PdfStandardFont(PdfFontFamily.timesRoman, 12),
        bounds: Rect.fromLTWH(230, 310, 500, 40));
    page2.graphics.drawString(
        nowM, PdfStandardFont(PdfFontFamily.timesRoman, 12),
        bounds: Rect.fromLTWH(365, 310, 500, 40));
    page2.graphics.drawString(
        nowY.substring(2, 4), PdfStandardFont(PdfFontFamily.timesRoman, 12),
        bounds: Rect.fromLTWH(100, 337, 500, 40));
    page2.graphics.drawString(
        infoPaciente.nombre, PdfStandardFont(PdfFontFamily.timesRoman, 12),
        bounds: Rect.fromLTWH(100, 390, 500, 40));
    page2.graphics.drawImage(PdfBitmap(infoPaciente.signatureData),
        Rect.fromLTWH(300, 370, 150, 50));
    //Save and dispose the document.
    final List<int> bytes = document.save();
    document.dispose();
    //Launch file.
    //await FileSaveHelper.saveAndLaunchFile(bytes, 'Annotations.pdf');
    return bytes;
  }

  Future<List<int>> _readDocumentData(String name) async {
    final ByteData data =
        await rootBundle.load('lib/src/utils/pdf/consentimiento_tp.pdf');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }
}
