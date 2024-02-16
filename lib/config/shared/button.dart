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
          color: const Color(0xff036000),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: loading == true
              ? const SizedBox(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Text(
                  label,
                  style: const TextStyle(color: Colors.white),
                ),
        ),
      ),
    );
  }
}
