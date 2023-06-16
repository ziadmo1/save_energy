import 'package:flutter/material.dart';
import '../../../themes/myTheme.dart';

class TextFiield extends StatelessWidget {
  String hint;
  Widget? suffIcon;
  IconData? prefIcon;
  FormFieldValidator<String> validate;
  bool isVisible;
  TextEditingController? controller;
  TextInputType? keyboard;
  TextFiield({this.keyboard,required this.hint,this.suffIcon, this.prefIcon,required this.validate,this.isVisible = false, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboard,
      controller: controller,
      obscureText: isVisible,
      validator: validate,
      enabled: true,
      cursorColor: Colors.white,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Colors.white
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.white54
        ),
        suffixIcon: suffIcon,
        prefixIcon: Icon(prefIcon,color: Colors.white54,),
        filled: true,
        fillColor: MyTheme.navyBlue,
        enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
                width: 1,
                color: Colors.white
            )
        ),
        border:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
                width: 1,
                color: Colors.white
            )
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            width: 1,
            color: Colors.white
          )
        )
      ),
    );
  }
}
