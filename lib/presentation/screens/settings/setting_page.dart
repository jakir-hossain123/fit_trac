import 'package:fit_trac/presentation/screens/home/home_screens.dart';
import 'package:fit_trac/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor:Colors.black38,
        title: const Text('Settings',),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 8.0, bottom: 8.0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.teal,
                width: 1.0,
              ),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
              },              icon: const Icon(
              Icons.home_outlined,
              color: Colors.white,
              size: 20,
            ),
            ),
          ),
        ),


      ),
      body:
      Center(
        child: Icon(Icons.settings,size: 50,),
      )

    );
  }
}
