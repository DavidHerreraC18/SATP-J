import 'dart:typed_data';

class InfoPacientePrincipalPdf {
  String nombre;
  String edad;
  String tipoDocumento;
  String documento;
  String ciudad;
  String telefono;
  List<String> respuestas = [];
  Uint8List signatureData;

  Uint8List getSignatureData() {
    return this.signatureData;
  }

  InfoPacientePrincipalPdf(
      {this.nombre,
      this.edad,
      this.tipoDocumento,
      this.documento,
      this.ciudad,
      this.telefono,
      this.respuestas,
      this.signatureData});
}
