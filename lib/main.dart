import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_project_store/auth/auth.dart';
import 'package:flutter_project_store/auth/login_or_register.dart';
import 'package:flutter_project_store/firebase_options.dart';
import 'package:flutter_project_store/model/shop.dart';
import 'package:flutter_project_store/pages/home_page/home_page.dart';
import 'package:flutter_project_store/pages/profile_page.dart';
import 'package:flutter_project_store/theme/dark_mode.dart';
import 'package:flutter_project_store/theme/light_mode.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(
    create: (context) => Shop(),
    child: MyApp(),
  ));
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      title: 'Flutter Petstore App',
      theme: lightmode,
      darkTheme: darkMode,
      routes: {
        "/login_register_page": (context) => const LoginOrRegister(),
        "/home_page": (context) => HomePage(),
        "/profile_page": (context) => ProfilePage(),
      },
      home: AuthPage(),
    );
  }
}
