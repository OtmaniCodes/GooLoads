import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:gooloads/src/utils/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import './src/app.dart';
 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  setupLocator();
  runApp(App());
}

// class AppInitializer extends StatelessWidget {
//   const AppInitializer({ Key? key }) : super(key: key);
//   Future _iniApp() async {
//     return await Future.wait([
//         SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
//         Firebase.initializeApp()
//     ]);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: _iniApp(),
//       builder: (BuildContext context, iniSnap){
//         final _isAppInitialized = iniSnap.hasData && iniSnap.connectionState == ConnectionState.done ? iniSnap.data != null : false;
//         if(_isAppInitialized) return App();
//         else return Center(child: CircularProgressIndicator(color: Palette.KBlackClr));
//       });
//   }
// }