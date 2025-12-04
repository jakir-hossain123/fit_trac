import 'package:fit_trac/presentation/screens/home/home_screens.dart';
import 'package:fit_trac/presentation/screens/run_directory/run_page.dart';
import 'package:fit_trac/presentation/screens/running/runnign_summary/running_summary.dart';
import 'package:fit_trac/presentation/screens/running/running_progress/run_progress.dart';
import 'package:fit_trac/presentation/screens/running/running_progress/widgets/run_progress_bar.dart';
import 'package:fit_trac/presentation/screens/settings/setting_page.dart';
import 'package:fit_trac/presentation/screens/walk_summery/walk_summery.dart';
import 'package:fit_trac/presentation/screens/walk_time_selec/walk_page.dart';
import 'package:fit_trac/presentation/screens/walk_tracking/walk_progress.dart';
 import 'package:flutter/material.dart';
import 'presentation/screens/sign_in/sign_in_page.dart';
import 'presentation/screens/sign_up/sign_up_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String walkPage = '/walk_time_selec-page';
  static const String walkProgressPage = '/Walk-progress-page';
  static const String settings = '/settings';
  static const String runPage = '/walk_tracking-page';
  static const String walkSummery = '/walk_time_selec-summery';
  static const String runProgress = '/walk_tracking-progress';
  static const String runningSummary = '/running-summary';



  static final Map<String, WidgetBuilder> routes = {
    home: (context) => const HomePage(),
    signIn: (context) => const SignInPage(),
    signUp: (context) => const SignUpPage(),
    walkPage: (context) => const WalkScreen(),
    walkProgressPage: (context) => const WalkProgressScreen(),
    settings: (context) => const SettingPage(),
    runPage: (context) => const RunScreen(),
    walkSummery: (context) => const WalkSummaryScreen(),
    runProgress: (context) => const RunProgress(),
    runningSummary: (context) => const RunningSummary(),
  };
}
