import 'package:flutter/material.dart';

class CheckBoxValidate extends FormField<bool> {
  CheckBoxValidate(
      {String title,
      FormFieldSetter<bool> onSaved,
      FormFieldValidator<bool> validator,
      bool initialValue = false,
      bool compareValue = false,
      String errorLabel = ''})
      : super(
          initialValue: initialValue,
          builder: (FormFieldState<bool> state) {
            return Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: initialValue,
                      onChanged: (value){
                        initialValue = value;
                        state.didChange(value);
                      }
                    ),
                    Text('Title'),
                  ],
                ),
                Text(
                  state.errorText ?? '',
                  style: TextStyle(
                      //color: Theme.of(context).errorColor,
                      ),
                )
              ],
            );
          },
          validator: (value) {
            if (!initialValue) {
              return 'You need to accept terms';
            } else {
              return null;
            }
          },
        );
}
