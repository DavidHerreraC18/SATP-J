import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

///Signature pad imports.
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import 'helper/mobile_image_converter.dart'
    if (dart.library.html) 'helper/web_image_converter.dart';

class PadFirmas extends StatefulWidget {
  @override
  _PadFirmasState createState() => _PadFirmasState();

  Function callBack;
  PadFirmas(this.callBack, {Key key}) : super(key: key);
}

class _PadFirmasState extends State<PadFirmas> {
  Uint8List _signatureData;
  bool _isSigned = false;
  List<Widget> _strokeColorWidgets;
  List<Color> _strokeColors = <Color>[];
  double _minWidth = 1.0;
  double _maxWidth = 4.0;
  int _selectedPenIndex = 0;
  Color _strokeColor;
  Color _backgroundColor;
  final bool kIsWeb = identical(0, 0.0);
  final GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();
  Color _getBorderColor() => Colors.grey[500];

  @override
  void initState() {
    _addColors();
    _minWidth = kIsWeb ? 2.0 : 1.0;
    _maxWidth = kIsWeb ? 2.0 : 4.0;
    super.initState();
  }

  void _addColors() {
    _strokeColors = <Color>[];
    _strokeColors.add(const Color.fromRGBO(0, 0, 0, 1));
    _strokeColors.add(const Color.fromRGBO(35, 93, 217, 1));
    _strokeColors.add(const Color.fromRGBO(77, 180, 36, 1));
    _strokeColors.add(const Color.fromRGBO(228, 77, 49, 1));
  }

  void _handleOnSignStart() {
    _isSigned = true;
  }

  void _showPopup() {
    _isSigned = false;

    if (kIsWeb) {
      _backgroundColor = Colors.white;
    }

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            final Color backgroundColor = _backgroundColor;
            final Color textColor = Colors.black87;

            return AlertDialog(
              insetPadding: EdgeInsets.all(12.0),
              backgroundColor: backgroundColor,
              title: Row(children: [
                Text('Dibuje su firma',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    )),
                InkWell(
                  child: Icon(Icons.clear, color: Colors.grey[500], size: 24.0),
                  //ignore: sdk_version_set_literal
                  onTap: () => {Navigator.of(context).pop()},
                )
              ], mainAxisAlignment: MainAxisAlignment.spaceBetween),
              titlePadding: EdgeInsets.all(16.0),
              content: SingleChildScrollView(
                child: Container(
                    child: Column(children: [
                      Container(
                        child: SfSignaturePad(
                            minimumStrokeWidth: _minWidth,
                            maximumStrokeWidth: _maxWidth,
                            strokeColor: _strokeColor,
                            backgroundColor: _backgroundColor,
                            onSignStart: _handleOnSignStart,
                            key: _signaturePadKey),
                        width: MediaQuery.of(context).size.width < 306
                            ? MediaQuery.of(context).size.width
                            : 306,
                        height: 172,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: _getBorderColor(), width: 1),
                        ),
                      ),
                      SizedBox(height: 24),
                      Row(children: <Widget>[
                        Text(
                          'Color de Firma',
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: _addStrokeColorPalettes(setState),
                            ),
                            width: 124)
                      ], mainAxisAlignment: MainAxisAlignment.spaceBetween),
                    ], mainAxisAlignment: MainAxisAlignment.center),
                    width: MediaQuery.of(context).size.width < 306
                        ? MediaQuery.of(context).size.width
                        : 306),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0, horizontal: 12.0),
              actionsPadding: EdgeInsets.all(8.0),
              buttonPadding: EdgeInsets.zero,
              actions: [
                FlatButton(
                    onPressed: _handleClearButtonPressed,
                    child: const Text(
                      'LIMPIAR',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    textColor: Colors.black),
                SizedBox(width: 8.0),
                FlatButton(
                    onPressed: () {
                      _handleSaveButtonPressed();
                      widget.callBack(_signatureData, _isSigned);
                      Navigator.of(context).pop();
                    },
                    child: const Text('GUARDAR',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        )),
                    textColor: Colors.black)
              ],
            );
          },
        );
      },
    );
  }

  List<Widget> _addStrokeColorPalettes(StateSetter stateChanged) {
    _strokeColorWidgets = <Widget>[];
    for (int i = 0; i < _strokeColors.length; i++) {
      _strokeColorWidgets.add(
        Material(
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: InkWell(
                onTap: () => stateChanged(
                  () {
                    _strokeColor = _strokeColors[i];
                    _selectedPenIndex = i;
                  },
                ),
                child: Center(
                  child: Stack(
                    children: [
                      Icon(Icons.brightness_1,
                          size: 25.0, color: _strokeColors[i]),
                      _selectedPenIndex != null && _selectedPenIndex == i
                          ? Padding(
                              child: Icon(Icons.check,
                                  size: 15.0, color: Colors.black),
                              padding: EdgeInsets.all(5),
                            )
                          : SizedBox(width: 8),
                    ],
                  ),
                ),
              ),
            ),
            color: Colors.transparent),
      );
    }

    return _strokeColorWidgets;
  }

  void _handleClearButtonPressed() {
    _signaturePadKey.currentState.clear();
    _isSigned = false;
    widget.callBack(_signatureData, _isSigned);
  }

  void _handleSaveButtonPressed() async {
    Uint8List data;

    if (kIsWeb) {
      RenderSignaturePad renderSignaturePad =
          _signaturePadKey.currentState.context.findRenderObject();
      data =
          await ImageConverter.toImage(renderSignaturePad: renderSignaturePad);
      _isSigned = true;
    } else {
      final imageData =
          await _signaturePadKey.currentState.toImage(pixelRatio: 3.0);
      if (imageData != null) {
        final bytes =
            await imageData.toByteData(format: ui.ImageByteFormat.png);
        data = bytes.buffer.asUint8List();
        _isSigned = true;
      }
    }

    setState(
      () {
        _signatureData = data;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: _getBorderColor()),
        ),
        child: _isSigned
            ? Image.memory(_signatureData)
            : Center(
                child: Text(
                  'Haga clic para firmar',
                  textScaleFactor: 1.0,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
        height: 78,
        width: 138,
      ),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      //ignore: sdk_version_set_literal
      onTap: () => {_showPopup()},
    );
  }
}
