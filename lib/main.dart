import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heven2/shared/Network/local/cache_helper.dart';
import 'package:heven2/shared/conestant/conestant.dart';
import 'package:heven2/styles/colors.dart';

import 'layout/home.dart';
import 'modules/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();

  Widget widget;
  String? uId = CacheHelper.getData(key: 'user');
  print('uId:$uId');
  if (uId != null && uId != '') {
    constUid = uId;
    widget = Home();
  } else {
    widget = Login();
  }
  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  late Widget stWidget;

  MyApp({required Widget startWidget}) {
    stWidget = startWidget;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: primarywihte,
            appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
              ),
              elevation: 0.0,
            )),
        home: stWidget);
  }
}
