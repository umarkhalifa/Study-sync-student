import 'package:alhikmah_schedule_student/config/services/push_notification_service/local_push_notifications.dart';
import 'package:alhikmah_schedule_student/config/services/push_notification_service/push_notification_service.dart';
import 'package:alhikmah_schedule_student/features/authentication/presentation/providers/auth_provider.dart';
import 'package:alhikmah_schedule_student/features/authentication/presentation/screens/login.dart';
import 'package:alhikmah_schedule_student/features/authentication/presentation/screens/personal_details.dart';
import 'package:alhikmah_schedule_student/features/authentication/presentation/screens/register_screen.dart';
import 'package:alhikmah_schedule_student/features/authentication/presentation/screens/splash_screen.dart';
import 'package:alhikmah_schedule_student/features/authentication/presentation/screens/wrapper.dart';
import 'package:alhikmah_schedule_student/features/profile/presentation/screens/profile_screen.dart';
import 'package:alhikmah_schedule_student/features/schedule/presentation/providers/schedule_provider.dart';
import 'package:alhikmah_schedule_student/features/schedule/presentation/screens/schedule_screen.dart';
import 'package:alhikmah_schedule_student/locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // PushNotificationService().showNotificationOnForeground(message.data);
}

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> setupFlutterNotifications() async {
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.max,
  );
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {

  /// Set up your service locator
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // initialize device timezones
  tz.initializeTimeZones();

  /// Setup push notification service
  PushNotificationService.initialize();
  LocalNotificationService().init();
  await setupFlutterNotifications();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ScheduleProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider())
      ],
      child: MaterialApp(
        title: 'Alhikmah Schedule Student',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: const Color(0xff5EB670)),
            useMaterial3: true,
            textTheme: GoogleFonts.hankenGroteskTextTheme()),
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => const SplashScreen(),
          '/wrapper': (context) => const AppWrapper(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/personalInformation': (context) => const PersonalDetailsScreen(),
          '/home': (context) => const ScheduleScreen(),
          '/profile':(context)=> const ProfileScreen()
        },
      ),
    );
  }
}
