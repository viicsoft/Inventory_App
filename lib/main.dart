import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:viicsoft_inventory_app/component/colors.dart';
import 'package:viicsoft_inventory_app/services/notification_service.dart';
import 'package:viicsoft_inventory_app/ui/Menu/add_event_page.dart';
import 'package:viicsoft_inventory_app/ui/Menu/add_equipment_page.dart';
import 'package:viicsoft_inventory_app/ui/Menu/user_profile/passwordresetsuccesspage.dart';
import 'package:viicsoft_inventory_app/ui/Menu/user_profile/reset_password_page.dart';
import 'package:viicsoft_inventory_app/ui/authentication/login_screen.dart';
import 'package:viicsoft_inventory_app/ui/authentication/loginsignup_screen.dart';
import 'package:viicsoft_inventory_app/ui/authentication/signup_screen.dart';
import 'package:viicsoft_inventory_app/ui/event/events_page.dart';
import 'package:viicsoft_inventory_app/ui/home_page.dart';
import 'package:viicsoft_inventory_app/ui/store/store_page.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await NotificationService().init();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 1));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColor.primaryColor,
        ),
        fontFamily: 'Poppins',
      ),
      title: 'Inventory App',
      initialRoute: '/',
      routes: {
        '/': (context) => const //CheckOutEquipmentPage(),
            SignupLogin(),
        '/signup': (context) => const SignupPage(),
        '/login': (context) => const Login(),
        '/homePage': (context) => const HomePage(),
        '/addItem': (context) => const AddEquipmentPage(),
        '/addevent': (context) => const AddEventPage(),
        '/resetpassword': (context) => const ResetPasswordPage(),
        '/profileChangeSuccessPage': (context) =>
            const ProfileChangeSuccessPage(),
        '/event': (context) => const EventsPage(),
        '/store': (context) => const StorePage(),
      },
    );
  }
}
