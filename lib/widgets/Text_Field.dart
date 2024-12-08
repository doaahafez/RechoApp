import 'package:flutter/material.dart';

class buildTextField extends StatelessWidget {

  final String? hintText;
  final String label;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
 buildTextField(
      {  this.hintText,
        required this.label,
         this.controller,
        this.obscureText = false,
        this.validator
      });
  @override
  Widget build(BuildContext context,) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          obscureText: obscureText,
          controller: controller,
          onChanged: validator,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
            contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            errorStyle: const TextStyle(
              color: Colors.red,
              fontSize: 12,
              height: 1.5,
            ),
          ),

          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
        ),


      ],
    );



  }
}
