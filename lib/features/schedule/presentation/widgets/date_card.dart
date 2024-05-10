import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateCard extends StatelessWidget {
  const DateCard({
    super.key,
    required this.selected,
    required this.day,
  });

  final bool selected;
  final DateTime day;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? const Color(0xff5EB670) : Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8), topRight: Radius.circular(8)),
      ),
      child: SizedBox(
        width: 45,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat('dd').format(day),
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: selected ? Colors.white : const Color(0xff031628),
                  height: 1),
            ),
            Text(
              DateFormat('EEE').format(day),
              style: TextStyle(
                color: selected ? Colors.white : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
