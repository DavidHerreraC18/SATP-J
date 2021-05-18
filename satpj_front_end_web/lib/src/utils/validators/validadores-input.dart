import 'package:satpj_front_end_web/src/providers/providers_usuarios/provider_usuarios.dart';

class ValidadoresInput {
  /*static Future<String> currencyFormat(String value) async{
    String currency = '';
    if (value.length > 3) {
      String aux = '';
      int iterations = 1;
      int lastIndex = 0;
      int points = value.length~/3;
      for (int i = value.length - 1; i >= 0 && iterations <= points ; i--) {
        if (iterations % 3 == 0 && i > 0) {
          aux = '.${value.substring(i, i + 3)}$aux';
          lastIndex = i;
        }
      
        iterations++;
      }
      aux = '${value.substring(0, lastIndex)}$aux';
    }
    return currency;
  }*/

  static String validateCheckbox(List<bool> selectedOptions, String message) {
    if (selectedOptions != null) {
      if (selectedOptions.isNotEmpty) {
        for (bool option in selectedOptions) {
          if (option) return null;
        }
        return message;
      }
    }

    return null;
  }

  static String validateEmpty(String value, String messageEmpty, String vacio) {
    value = value.trim();
    if (value.isEmpty) {
      if (vacio.isNotEmpty) {
        return '$messageEmpty no puede estar $vacio';
      } else {
        return '$messageEmpty';
      }
    }
    return null;
  }

  static String validateCurrency(String value, String messageEmpty) {
    value = value.trim();
    if (value != null) {
      if (value.isEmpty) {
        return 'El $messageEmpty no puede estar vacio';
      }
    }

    return null;
  }

  static String validateEmail(String value) {
    value = value.trim();
    if (value != null) {
      if (value.isEmpty) {
        return 'El correo no puede estar vacio';
      } else if (!value.contains(RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
        return 'Ingrese un correo electrónico valido';
      } else {
        bool registrado = false;
        validateExistEmail(value).then((data) => registrado = data);
        print(registrado);
        if (registrado)
          return 'El correo electrónico ya se encuentra registrado';
      }
    }

    return null;
  }

  static validateExistEmail(String email) async {
    final usuario = await ProviderUsuarios.obtenerUsuarioPorEmail(email);
    bool validate = false;
    if (usuario.first != null) {
      if (usuario.first.email == email) {
        return validate = true;
      }
    }

    return validate;
  }
  /*
  String _validatePassword(String value) {
    value = value.trim();

    if (value != null) {
      if (value.isEmpty) {
        return 'La contraseña no puede estar vacia';
      } else if (value.length < 6) {
        return 'El largo de la contraseña debe ser mayor a 6';
      }
    }
    return null;
  }*/
}
