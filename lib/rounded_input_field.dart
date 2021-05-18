import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'text_field_container.dart';
import 'constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final Function ontap;
  final IconData icon;
  final int maxlength;
  final bool enable;
  final InputBorder border;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardtype;
  const RoundedInputField(
      {Key key,
      this.hintText,
      this.icon,
      this.onChanged,
      this.keyboardtype,
      this.enable,
      this.ontap,
      this.border,
      this.controller,
      this.maxlength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        style: TextStyle(color: Colors.black54, fontFamily: 'Monda'),
        keyboardType: keyboardtype,
        maxLength: maxlength,
        onTap: ontap,
        controller: controller,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        enabled: enable,
        decoration: InputDecoration(
          counterText: "",
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: border,
        ),
      ),
    );
  }
}
