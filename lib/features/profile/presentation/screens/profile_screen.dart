import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f7fb),
      appBar: AppBar(
        backgroundColor: const Color(0xfff6f7fb),
        centerTitle: true,
        title: const Text("Personal Information",style: TextStyle(
          fontSize: 18
        ),),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 55,
                child: Icon(SolarIconsBold.user,color: Colors.white,size: 80,),
                backgroundColor: Color(0xffcfe7da),
              ),
            ),
            const SizedBox(height: 30,),
            const DetailColumn(label: 'Full Name', content: "Umar Muazu Khalifa"),
            const DetailColumn(label: 'Level', content: "300 Level"),
            const DetailColumn(label: 'Programme', content: "Software Engineering"),
            const DetailColumn(label: 'Matric No', content: "19/03Sen054"),
            const SizedBox(height: 20,),
            GestureDetector(
              onTap: ()async{
                await showDialog(context: context, builder: (context)=> LogoutDialog());
              },
              child: Material(
                color: Colors.red.shade700,
                borderRadius: BorderRadius.circular(10),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(SolarIconsOutline.logout,color: Colors.white,),
                      SizedBox(width: 7,),
                      Text("Logout",style: TextStyle(color: Colors.white),)

                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

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
        const SizedBox(height: 10,),
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
        const SizedBox(height: 20,),

      ],
    );
  }
}

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(SolarIconsOutline.logout,color: Colors.red.shade700,size: 28,),
            const SizedBox(height: 10,),
            const Text("Logout",style: TextStyle(
                fontSize: 18,fontWeight: FontWeight.w600
            ),),
            const SizedBox(height: 20,),
            const Text("Are you sure you want to logout?",style: TextStyle(
                fontSize: 16
            ),),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: ()=> Navigator.pop(context),
                      child: const Text("Cancel")),
                  ElevatedButton(onPressed: (){
                    FirebaseAuth.instance.signOut();
                    Navigator.pushNamedAndRemoveUntil(context, '/wrapper', (route) => false);
                  },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith((states) => const Color(0xff036000)),
                        shape: MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ))
                    ), child: const Text("Logout",style: TextStyle(color: Colors.white),),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
