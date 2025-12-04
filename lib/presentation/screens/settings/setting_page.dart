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
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.home),
              child: Icon( Icons.arrow_back_ios)),
        ),


      ),
      body:
      Center(
        child: SvgPicture.asset(
          'assets/images/setting.svg',
          color: Colors.teal,
          width: 200,
          height: 200,
        ),
      )

    );
  }
}
