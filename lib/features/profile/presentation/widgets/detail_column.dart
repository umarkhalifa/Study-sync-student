import 'package:flutter/material.dart';

class DetailColumn extends StatelessWidget {
  final String label;
  final bool? enabled;
  final TextEditingController? controller;
  final TextInputType? textInputType;

  const DetailColumn(
      {super.key,
        required this.label,
        this.enabled,
        this.controller, this.textInputType});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: controller,
          keyboardType: textInputType,
          enabled: enabled,
          obscuringCharacter: "*",
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(10),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xff036000),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade400),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
