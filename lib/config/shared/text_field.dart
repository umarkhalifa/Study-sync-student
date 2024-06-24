import 'package:flutter/material.dart';
class ScheduleTextField extends StatelessWidget {
  final Icon? prefixIcon;
  final String? hint;
  final bool? obscureText;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final String?Function(String?)? validator;
  const ScheduleTextField({
    super.key, this.prefixIcon, this.hint, this.obscureText, this.controller, this.textInputType, this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText??false,
      keyboardType: textInputType,
      controller: controller,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscuringCharacter: "*",
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(10)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xff036000)),
              borderRadius: BorderRadius.circular(10)
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
          hintStyle: TextStyle(fontSize: 13,color: Colors.grey.shade400),
          prefixIcon: prefixIcon,
          hintText: hint

      ),
    );
  }
}
