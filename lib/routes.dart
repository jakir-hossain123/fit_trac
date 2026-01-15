import 'package:fit_trac/presentation/screens/sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:fit_trac/presentation/screens/home/home_screens.dart';
import 'package:fit_trac/presentation/screens/run_directory/run_page.dart';
import 'package:fit_trac/presentation/screens/running/running_progress/run_progress.dart';
import 'package:fit_trac/presentation/screens/running/runnign_summary/running_summary.dart';
import 'package:fit_trac/presentation/screens/walk_summery/walk_summery.dart';
import 'package:fit_trac/presentation/screens/walk_time_selec/walk_page.dart';
import 'package:fit_trac/presentation/screens/walk_tracking/walk_progress.dart';
import 'package:fit_trac/presentation/screens/free_hand/sub_catagory/sub_catagory.dart';
import 'package:fit_trac/presentation/screens/free_hand/free_hand_excercise_screen.dart';

class AppRoutes {
  static const String signIn = '/sign-in';
  static const String home = '/';
  static const String subCatagory = '/sub-catagory';
  static const String freeHand = '/free-hand';
  static const String walkPage = '/walk_time_selec-page';
  static const String runPage = '/walk_tracking-page';
  static const String walkProgressPage = '/Walk-progress-page';
  static const String walkSummery = '/walk_time_selec-summery';
  static const String runProgress = '/run-progress';
  static const String runningSummary = '/running-summary';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signIn:
        return MaterialPageRoute(builder: (_) => const SignInPage());

      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());

      case subCatagory:
        return MaterialPageRoute(builder: (_) => const SubCatagory());

      case AppRoutes.freeHand:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => FreeHandExcerciseScreen(
            subCategoryId: args['id'],
            categoryName: args['name'],
          ),
        );

      case walkPage:
        return MaterialPageRoute(builder: (_) => const WalkScreen());

      case runPage:
        return MaterialPageRoute(builder: (_) => const RunScreen());

      case runProgress:
        return MaterialPageRoute(
          builder: (_) => const RunProgress(),
          settings: settings,
        );

      case runningSummary:
        return MaterialPageRoute(
          builder: (_) => const RunningSummary(),
        );

      case walkProgressPage:
        return MaterialPageRoute(
          builder: (_) => const WalkProgressScreen(),
          settings: settings,
        );

      case walkSummery:
        return MaterialPageRoute(builder: (_) => const WalkSummaryScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}