///Dart imports
import 'dart:async';
import 'dart:convert';
//ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

///To save the pdf file in the device
class FileSaveHelper {
  ///To save the pdf file in the device
  static Future<void> saveAndLaunchFile(
      List<int> bytes, String fileName) async {
    js.context['pdfdata'] = base64.encode(bytes);
    js.context['filenamePdf'] = fileName;
    Timer.run(() {
      js.context.callMethod('downloadPDF');
    });
  }

  static Future<void> saveAndLaunchImage(
      List<int> bytes, String fileName) async {
    js.context['imagedata'] = base64.encode(bytes);
    js.context['filenameImage'] = fileName;
    Timer.run(() {
      js.context.callMethod('downloadImage');
    });
  }
}
