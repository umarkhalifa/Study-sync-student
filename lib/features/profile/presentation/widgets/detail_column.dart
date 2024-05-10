import 'package:flutter/material.dart';
class DetailColumn extends StatelessWidget {
  final String label;
  final String content;

  const DetailColumn({super.key, required this.label, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(
          height: 10,
        ),
        Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            height: 60,
            width: MediaQuery.sizeOf(context).width,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Text(content),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
