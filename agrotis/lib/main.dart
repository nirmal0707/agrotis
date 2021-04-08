import 'package:agrotis/app/locator.dart';
import 'package:agrotis/app/my_app/my_app.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:agrotis/app/router.gr.dart' as router;
import 'package:flutter/services.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp();

  setupLocator();
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       builder: ExtendedNavigator.builder(
//         router: router.Router(),
//         navigatorKey: locator<NavigationService>().navigatorKey,
//         initialRoute: router.Routes.splashScreenView,
//         builder: (context, extendedNav) => Theme(
//           data: ThemeData(
//             primarySwatch: Colors.blue,
//             visualDensity: VisualDensity.adaptivePlatformDensity,
//           ),
//           child: extendedNav,
//         ),
//       ),
//     );
//   }
// }
