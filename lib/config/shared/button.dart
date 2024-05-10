import 'package:flutter/material.dart';

class ScheduleButton extends StatelessWidget {
  final String label;
  final Function()? onPressed;
  final bool? loading;

  const ScheduleButton(
      {super.key, required this.label, this.onPressed, this.loading});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 52,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          color: const Color(0xff46a055),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Center(
          child: loading == true
              ? const SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
        ),
      ),
    );
  }
}
