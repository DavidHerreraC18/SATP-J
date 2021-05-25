import 'dart:typed_data';

class InfoAcudientePrincipalPdf {
  String nombre;
  String tipoDocumento;
  String documento;
  String telefono;
  Uint8List signatureData;

  Uint8List getSignatureData() {
    return this.signatureData;
  }

  InfoAcudientePrincipalPdf(
      {this.nombre,
      this.tipoDocumento,
      this.documento,
      this.telefono,
      this.signatureData});
}
