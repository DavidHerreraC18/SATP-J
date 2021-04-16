import 'dart:typed_data';

class InfoPacienteTelepsicologiaPdf {
  String nombre;
  String tipoDocumento;
  String documento;
  String ciudad;
  Uint8List signatureData;

  Uint8List getSignatureData() {
    return this.signatureData;
  }

  InfoPacienteTelepsicologiaPdf(
      {this.nombre,
      this.tipoDocumento,
      this.documento,
      this.ciudad,
      this.signatureData});
}
