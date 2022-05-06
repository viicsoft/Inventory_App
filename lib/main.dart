import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:viicsoft_inventory_app/ui/Menu/add_category.dart';
import 'package:viicsoft_inventory_app/ui/Menu/add_event_page.dart';
import 'package:viicsoft_inventory_app/ui/Menu/add_equipment_page.dart';
import 'package:viicsoft_inventory_app/ui/Menu/user_profile/admin/userslist.dart';
import 'package:viicsoft_inventory_app/ui/Menu/user_profile/passwordresetsuccesspage.dart';
import 'package:viicsoft_inventory_app/ui/Menu/user_profile/reset_password_page.dart';
import 'package:viicsoft_inventory_app/ui/authentication/loginScreen.dart';
import 'package:viicsoft_inventory_app/ui/authentication/loginsignupScreen.dart';
import 'package:viicsoft_inventory_app/ui/authentication/signupScreen.dart';
import 'package:viicsoft_inventory_app/ui/event/events_page.dart';
import 'package:viicsoft_inventory_app/ui/home_page.dart';
import 'package:viicsoft_inventory_app/ui/store/store_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
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
    var initializationSettingsAndriod =
        const AndroidInitializationSettings('@drawable/app_icon');
    var initializationSettingsIOS = const IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndriod, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 1));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      headerTriggerDistance: 80.0, // header trigger refresh trigger distance
      maxOverScrollExtent:
          50, //The maximum dragging range of the head. Set this property if a rush out of the view area occurs
      maxUnderScrollExtent: 0, // Maximum dragging range at the bottom
      enableScrollWhenRefreshCompleted:
          true, //This property is incompatible with PageView and TabBarView. If you need TabBarView to slide left and right, you need to set it to true.
      enableLoadingWhenFailed:
          true, //In the case of load failure, users can still trigger more loads by gesture pull-up.
      hideFooterWhenNotFull:
          false, // Disable pull-up to load more functionality when Viewport is less than one screen
      enableBallisticLoad: true,

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Inventory App',
        initialRoute: '/',
        routes: {
          '/': (context) => const //CheckOutEquipmentPage(),
              SignupLogin(),
          '/signup': (context) => const SignupPage(),
          '/login': (context) => const Login(),
          '/homePage': (context) => const HomePage(),
          '/UserList': (context) => const UserList(),
          '/addCategory': (context) => const AddCategory(),
          '/addItem': (context) => const AddEquipmentPage(),
          '/addevent': (context) => const AddEventPage(),
          '/resetpassword': (context) => const ResetPasswordPage(),
          '/profileChangeSuccessPage': (context) =>
              const ProfileChangeSuccessPage(),
          '/event': (context) => const EventsPage(),
          '/store': (context) => const StorePage(),
        },
      ),
    );
  }

  onSelectNotification(String? payload) async {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("PayLoad"),
          content: Text("Payload : $payload"),
        );
      },
    );
  }
}
