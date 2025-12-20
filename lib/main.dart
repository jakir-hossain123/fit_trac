import 'dart:ui';
import 'package:awesome_notifications/awesome_notifications.dart' hide NOTIFICATION_ID;
import 'package:fit_trac/presentation/providers/run_provider.dart';
import 'package:fit_trac/presentation/providers/walk_provider.dart';
import 'package:fit_trac/services/tracking_service.dart' as trk;
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:provider/provider.dart';
import 'package:fit_trac/utils/app_theme.dart';
import 'package:fit_trac/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

@pragma("vm:entry-point")
Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
  if (receivedAction.buttonKeyInput == 'STOP_TRACKING') {
    FlutterBackgroundService().invoke("STOP_SERVICE");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Firebase & Crashlytics
  try {
    await Firebase.initializeApp();
  } catch (e) {
    // assert(false, "Firebase initialization failed: $e");
  }


  // 2. FlutterError handler
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // 3. PlatformError handler

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  // 4. Awesome Notifications

  await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: trk.NOTIFICATION_CHANNEL_ID,
        channelName: trk.NOTIFICATION_CHANNEL_NAME,
        channelDescription: 'Used for fitness tracking background service',
        importance: NotificationImportance.Low,
        defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.white,
        channelShowBadge: false,
        onlyAlertOnce: true,
        groupKey: trk.NOTIFICATION_GROUP_KEY,
        locked: true,
        defaultRingtoneType: DefaultRingtoneType.Notification,
      ),
    ],
    debug: true,
  );
  AwesomeNotifications().setListeners(
    onActionReceivedMethod: onActionReceivedMethod,

  );




  // 5. background service
  await trk.initializeService();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WalkProvider()),
        ChangeNotifierProvider(create: (_) => RunProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness App',
      theme: AppTheme.darkTheme,
      routes: AppRoutes.routes,
      initialRoute: AppRoutes.home,
    );
  }
}