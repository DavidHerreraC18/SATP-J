///Package imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Pdf/helper/info_paciente_principal_pdf.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:typed_data';

///Pdf import
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'helper/save_file_mobile.dart'
    if (dart.library.html) 'helper/save_file_web.dart';

/// Render pdf with annotations
class PdfConsentimientoPrincipal {
  InfoPacientePrincipalPdf infoPaciente;
  InfoPacientePrincipalPdf infoAcudiente;

  PdfConsentimientoPrincipal(InfoPacientePrincipalPdf infoPaciente,
      InfoPacientePrincipalPdf infoAcudiente) {
    this.infoPaciente = infoPaciente;
    this.infoAcudiente = infoAcudiente;
  }

  /// Creates pdf with annotations
  Future<List<int>> generatePDF() async {
    String now = DateFormat("dd-MM-yyyy").format(DateTime.now());
    //Load the PDF document.
    final PdfDocument document =
        PdfDocument(inputBytes: await _readDocumentData('consentimiento.pdf'));

    //Get the page.
    final PdfPage page1 = document.pages[0];
    final PdfPage page2 = document.pages[1];
    final PdfPage page3 = document.pages[2];
    //Headers
    for (int i = 0; i < 3; i++) {
      PdfPage pageHeader = document.pages[i];
      pageHeader.graphics.drawString(
          infoPaciente.nombre, PdfStandardFont(PdfFontFamily.timesRoman, 9),
          bounds: Rect.fromLTWH(150, 116.5, 500, 40));
      pageHeader.graphics.drawString(
          infoPaciente.tipoDocumento + ": " + infoPaciente.documento,
          PdfStandardFont(PdfFontFamily.timesRoman, 9),
          bounds: Rect.fromLTWH(465, 116.5, 500, 40));
      pageHeader.graphics.drawString(
          now, PdfStandardFont(PdfFontFamily.timesRoman, 9),
          bounds: Rect.fromLTWH(374, 130, 500, 40));
      pageHeader.graphics.drawString(infoPaciente.edad + " años",
          PdfStandardFont(PdfFontFamily.timesRoman, 9),
          bounds: Rect.fromLTWH(135, 130, 500, 40));
    }
    //Page2
    //Parte Inicial
    page2.graphics.drawString(
        infoPaciente.nombre, PdfStandardFont(PdfFontFamily.timesRoman, 9),
        bounds: Rect.fromLTWH(56, 472, 500, 40));
    page2.graphics.drawString(
        infoPaciente.tipoDocumento + ":" + infoPaciente.documento,
        PdfStandardFont(PdfFontFamily.timesRoman, 9),
        bounds: Rect.fromLTWH(190.5, 486.5, 500, 40));
    page2.graphics.drawString(
        infoPaciente.ciudad, PdfStandardFont(PdfFontFamily.timesRoman, 9),
        bounds: Rect.fromLTWH(397, 486.5, 500, 40));
    page2.graphics.drawString(
        "Aplicativo SATP-J", PdfStandardFont(PdfFontFamily.timesRoman, 9),
        bounds: Rect.fromLTWH(280, 500, 500, 40));

    //Parte de Confirmaciones
    if (infoPaciente.respuestas[0].contains("Si")) {
      //1 SI
      page2.graphics.drawString(
          "X", PdfStandardFont(PdfFontFamily.timesRoman, 13),
          bounds: Rect.fromLTWH(62.5, 578, 500, 40));
    }
    if (infoPaciente.respuestas[0].contains("No")) {
      //1 NO
      page2.graphics.drawString(
          "X", PdfStandardFont(PdfFontFamily.timesRoman, 13),
          bounds: Rect.fromLTWH(124.5, 578, 500, 40));
    }

    if (infoPaciente.respuestas[1].contains("Si")) {
      //2 SI
      page2.graphics.drawString(
          "X", PdfStandardFont(PdfFontFamily.timesRoman, 13),
          bounds: Rect.fromLTWH(247, 604.5, 500, 40));
    }
    if (infoPaciente.respuestas[1].contains("No")) {
      //2 NO
      page2.graphics.drawString(
          "X", PdfStandardFont(PdfFontFamily.timesRoman, 13),
          bounds: Rect.fromLTWH(301, 604.5, 500, 40));
    }

    if (infoPaciente.respuestas[2].contains("Si")) {
      //3 SI
      page2.graphics.drawString(
          "X", PdfStandardFont(PdfFontFamily.timesRoman, 13),
          bounds: Rect.fromLTWH(366, 631, 500, 40));
    }
    if (infoPaciente.respuestas[2].contains("No")) {
      //3 NO
      page2.graphics.drawString(
          "X", PdfStandardFont(PdfFontFamily.timesRoman, 13),
          bounds: Rect.fromLTWH(424, 631, 500, 40));
    }

    if (infoPaciente.respuestas[3].contains("Si")) {
      //4 SI
      page2.graphics.drawString(
          "X", PdfStandardFont(PdfFontFamily.timesRoman, 13),
          bounds: Rect.fromLTWH(62.5, 658, 500, 40));
    }
    if (infoPaciente.respuestas[3].contains("No")) {
      //4 NO
      page2.graphics.drawString(
          "X", PdfStandardFont(PdfFontFamily.timesRoman, 13),
          bounds: Rect.fromLTWH(120.5, 658, 500, 40));
    }

    if (infoPaciente.respuestas[4].contains("Si")) {
      //5 SI
      page2.graphics.drawString(
          "X", PdfStandardFont(PdfFontFamily.timesRoman, 13),
          bounds: Rect.fromLTWH(211, 698, 500, 40));
    }
    if (infoPaciente.respuestas[4].contains("No")) {
      //5 NO
      page2.graphics.drawString(
          "X", PdfStandardFont(PdfFontFamily.timesRoman, 13),
          bounds: Rect.fromLTWH(268, 698, 500, 40));
    }

    if (infoPaciente.respuestas[5].contains("Si")) {
      //6 SI
      page2.graphics.drawString(
          "X", PdfStandardFont(PdfFontFamily.timesRoman, 13),
          bounds: Rect.fromLTWH(424, 738.5, 500, 40));
    }
    if (infoPaciente.respuestas[5].contains("No")) {
      //6 NO
      page2.graphics.drawString(
          "X", PdfStandardFont(PdfFontFamily.timesRoman, 13),
          bounds: Rect.fromLTWH(481, 738.5, 500, 40));
    }

    if (infoPaciente.respuestas[6].contains("Si")) {
      //7 SI
      page2.graphics.drawString(
          "X", PdfStandardFont(PdfFontFamily.timesRoman, 13),
          bounds: Rect.fromLTWH(105.5, 778.5, 500, 40));
    }
    if (infoPaciente.respuestas[6].contains("No")) {
      //7 NO
      page2.graphics.drawString(
          "X", PdfStandardFont(PdfFontFamily.timesRoman, 13),
          bounds: Rect.fromLTWH(162.5, 778.5, 500, 40));
    }

    if (infoPaciente.respuestas[7].contains("Si")) {
      //8 SI
      page2.graphics.drawString(
          "X", PdfStandardFont(PdfFontFamily.timesRoman, 13),
          bounds: Rect.fromLTWH(136.5, 819, 500, 40));
    }
    if (infoPaciente.respuestas[7].contains("No")) {
      //8 NO
      page2.graphics.drawString(
          "X", PdfStandardFont(PdfFontFamily.timesRoman, 13),
          bounds: Rect.fromLTWH(193.5, 819, 500, 40));
    }

    if (infoPaciente.respuestas[8].contains("Si")) {
      //9 SI
      page2.graphics.drawString(
          "X", PdfStandardFont(PdfFontFamily.timesRoman, 13),
          bounds: Rect.fromLTWH(406, 846, 500, 40));
    }
    if (infoPaciente.respuestas[8].contains("No")) {
      //9 NO
      page2.graphics.drawString(
          "X", PdfStandardFont(PdfFontFamily.timesRoman, 13),
          bounds: Rect.fromLTWH(464, 846, 500, 40));
    }

    if (infoPaciente.respuestas[9].contains("Si")) {
      //10 SI
      page2.graphics.drawString(
          "X", PdfStandardFont(PdfFontFamily.timesRoman, 13),
          bounds: Rect.fromLTWH(381.5, 873, 500, 40));
    }
    if (infoPaciente.respuestas[9].contains("No")) {
      //10 NO
      page2.graphics.drawString(
          "X", PdfStandardFont(PdfFontFamily.timesRoman, 13),
          bounds: Rect.fromLTWH(439.5, 873, 500, 40));
    }
    //Pagina 3
    page3.graphics.drawImage(PdfBitmap(infoPaciente.getSignatureData()),
        Rect.fromLTWH(39, 210, 150, 30));
    page3.graphics.drawString(
        infoPaciente.nombre, PdfStandardFont(PdfFontFamily.timesRoman, 11),
        bounds: Rect.fromLTWH(35, 267.5, 500, 40));
    page3.graphics.drawString(
        infoPaciente.tipoDocumento + ":" + infoPaciente.documento,
        PdfStandardFont(PdfFontFamily.timesRoman, 11),
        bounds: Rect.fromLTWH(35, 304, 500, 40));
    page3.graphics.drawString(
        infoPaciente.telefono, PdfStandardFont(PdfFontFamily.timesRoman, 11),
        bounds: Rect.fromLTWH(35, 340.5, 500, 40));
    //Acudientes
    page3.graphics.drawImage(PdfBitmap(infoAcudiente.getSignatureData()),
        Rect.fromLTWH(73, 490, 130, 26));
    page3.graphics.drawString(
        infoAcudiente.nombre, PdfStandardFont(PdfFontFamily.timesRoman, 9),
        bounds: Rect.fromLTWH(84, 519, 500, 40));
    page3.graphics.drawString(
        infoAcudiente.tipoDocumento + ":" + infoAcudiente.documento,
        PdfStandardFont(PdfFontFamily.timesRoman, 9),
        bounds: Rect.fromLTWH(129, 533, 500, 40));
    page3.graphics.drawString(
        infoAcudiente.telefono, PdfStandardFont(PdfFontFamily.timesRoman, 9),
        bounds: Rect.fromLTWH(99, 546, 500, 40));
    //Save and dispose the document.
    final List<int> bytes = document.save();
    document.dispose();
    //Launch file.
    //await FileSaveHelper.saveAndLaunchFile(bytes, 'Annotations.pdf');
    return bytes;
  }

  Future<List<int>> _readDocumentData(String name) async {
    final ByteData data =
        await rootBundle.load('lib/src/utils/pdf/consentimiento.pdf');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }
}
