import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

Container_Builder_Form (String? field, String label_Text, int max_Length){
  return  Container(
      height: 45,
      child:  TextFormField(
        maxLength: max_Length,
        cursorColor: Colors.black,
        controller: new TextEditingController.fromValue(new TextEditingValue(text: field.toString(),selection: new TextSelection.collapsed(offset: field.toString().length))),
        onChanged: (value) => field = value,
        decoration:  InputDecoration(
            counterText: '',
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black.withOpacity(0.5)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black.withOpacity(0.5)),
            ),
            filled: false,
            // hintText: 'Enter name of patient',
            hintStyle:  TextStyle(color: Colors.grey.shade500, fontSize: 12.0,

            ),
            border: OutlineInputBorder(),
            labelText: label_Text,
            labelStyle: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 14)
        ),
      ));
}

Container_Builder_Dropdown(String _value, List<String> list,String text) {
  return Container(
    height: 45,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
            color: Colors.black.withOpacity(0.5)
        )
    ),
    child: Row(
      children: [
        SizedBox(width: 10,),
        Container(
            width:85,
            child: Text(text,style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 14))),
        DropdownButton<String>(
          value: _value,
          icon: const Icon(Icons.arrow_drop_down),
          elevation: 16,
          style: const TextStyle(color: Colors.black),
          underline: Container(
            height: 2,
            color: Colors.black.withOpacity(0.5),
          ),
          onChanged: (String? value) => _value = value!,

          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Container(
                  width: 50,
                  child: Text(value)),
            );
          }).toList(),
        ),
      ],
    ),
  );
}

Container_Builder_SpinBox (double _value,double _min, double _max, double _step, String text){
    return
    Container(
    height: 45,
    child: SpinBox(
      min: _min,
      max: _max,
      value: _value,
      decimals: 0,
      step: _step,
      acceleration: _step,
      onChanged: (value)=> _value = value,
      decoration: InputDecoration(labelText: text),
    ),
  );
}