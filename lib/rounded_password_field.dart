// import 'package:flutter/material.dart';
// import 'text_field_container.dart';
// import 'constants.dart';
// import 'body.dart';

// class RoundedPasswordField extends StatelessWidget {
//   final String hintText;
//   final ValueChanged<String> onChanged;
//   const RoundedPasswordField({Key key, this.onChanged, this.hintText})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return TextFieldContainer(
//       child: TextFormField(
//         validator: (input) {
//           if (input.length < 8) return 'Mínimo 8 caracteres';
//         },
//         onSaved: (input) => password = input,
//         style: TextStyle(color: Colors.black54, fontFamily: 'Monda'),
//         obscureText: false,
//         onChanged: onChanged,
//         cursorColor: kPrimaryColor,
//         decoration: InputDecoration(
//           hintText: hintText,
//           icon: Icon(
//             Icons.lock,
//             color: kPrimaryColor,
//           ),
//           suffixIcon: Icon(
//             Icons.visibility,
//             color: kPrimaryColor,
//           ),
//           border: InputBorder.none,
//         ),
//       ),
//     );
//   }
// }
