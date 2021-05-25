import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';

const kTtipoDocumento = [
  'Cédula de Ciudadanía',
  'Tarjeta de Identidad',
  'Cédula de Extranjería',
  'Pasaporte'
];
const kInstituciones = [
  'Institución educativa',
  'Entidades estatales (ICBF, Comisaría de Familia)',
  'Especialista o institución de salud',
  'Familia',
  'Otra'
];
const kEstratoSocioeconomico = ['1', '2', '3', '4', '5', '6'];
const kEnfoque = ['Comportamental', 'Psicoanalítico', 'Sistemico'];

var formatoPesosColombianos =
    NumberFormat.currency(locale: "en_US", symbol: "€");

var currencyformatPesosColombianos = CurrencyTextInputFormatter(
    locale: 'es_CO', decimalDigits: 0, symbol: 'COP');

inputDecoration({bool enabled = true}) {
  return InputDecoration(
    labelStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 18.0),
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: borderField(),
    enabledBorder: enabledBorderField(enabled: enabled),
    focusedBorder: focusedBorderField(enabled: enabled),
  );
}

InputDecoration datePickerDecoration = InputDecoration(
    icon: Icon(
      Icons.calendar_today_rounded,
      color: kPrimaryColor,
    ),
    labelStyle: TextStyle(
        fontWeight: FontWeight.normal, fontSize: 18.0, color: Colors.black),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: kPrimaryColor, width: 1.5),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
    ));

OutlineInputBorder borderField() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  );
}

OutlineInputBorder enabledBorderField({bool enabled = true}) {
  return OutlineInputBorder(
    borderSide: BorderSide(
        color: enabled ? kPrimaryColor : Colors.grey[400], width: 1.5),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  );
}

OutlineInputBorder focusedBorderField({bool enabled = true}) {
  return OutlineInputBorder(
    borderSide: BorderSide(
        color: enabled ? kPrimaryColor : Colors.grey[400], width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  );
}
