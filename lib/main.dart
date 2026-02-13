
import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import '/src/services/secure_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '/src/config/router/route_generator.dart';
import 'src/config/router_observer.dart';
import '/src/domain/notification_model.dart';
import 'src/services/notification_service.dart';
import 'src/services/stomp_service.dart';

import '/src/utils/consts/routes/app_routes_name.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';
import '/src/utils/variable/global_variable.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

//mnba@gainde2000.sn PalaPala9.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Request Permission for Notifications
  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }

  await NotificationService.init();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
  HttpOverrides.global = MyHttpOverrides();
  
  NotificationService.resetNotificationId();
  runApp(
    /*DevicePreview( // for ios simulator
      enabled: true,
      builder: (context) => */ChangeNotifierProvider(
      create: (_) => NotificationModel(),
      child: MyApp(isFirstTime: isFirstTime),
    ),
    //),
  );

}

class MyApp extends StatelessWidget {
  final bool isFirstTime;

  const MyApp({required this.isFirstTime});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return Builder(
      builder: (context) {
      // StompService().init(context);  // initialise une seule fois
        return MaterialApp(
            navigatorObservers: [routeObserver],
            title: 'Senchange',
            debugShowCheckedModeBanner: false,
          // for ios simulator
        /*  builder: DevicePreview.appBuilder,  // REQUIRED
          locale: DevicePreview.locale(context), // OP*/

            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: AppColors.orangeColor),
              fontFamily: 'Inter',
            ),
            navigatorKey: navigatorKey, // <-- clé globale
            scaffoldMessengerKey: scaffoldMessengerKey, // Associer la GlobalKey
            initialRoute: AppRoutesName.splashFirstPage,
            onGenerateRoute:  (settings) => RouteGenerator.generateRoute(settings, isFirstTime),
        );
      },
    );
  }
}
