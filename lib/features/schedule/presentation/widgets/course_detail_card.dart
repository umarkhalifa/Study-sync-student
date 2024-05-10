import 'package:alhikmah_schedule_student/features/schedule/presentation/providers/schedule_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseDetailCard extends StatelessWidget {
  final IconData iconData;
  final String detail;
  final bool? isCall;

  const CourseDetailCard({
    super.key,
    required this.iconData,
    required this.detail, this.isCall,
  });

  @override
  Widget build(BuildContext context) {
    final courseProv = Provider.of<ScheduleProvider>(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Material(
        color: const Color(0xfff8f9fd),
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: MediaQuery
              .sizeOf(context)
              .width,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Material(
                  elevation: 4,
                  shadowColor: Colors.grey.withOpacity(0.1),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(iconData, size: 18,),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  detail,
                  style: const TextStyle(
                      fontSize: 14, color: Color(0xff031628)),
                ),
                const Spacer(),
                isCall == true ? GestureDetector(
                  onTap: (){
                    courseProv.makePhoneCall(detail);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text("Call", style: TextStyle(
                        color: Color(0xff358442),
                      fontWeight: FontWeight.w600,
                    ),),
                  ),
                ):const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
