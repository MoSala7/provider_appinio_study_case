// ignore_for_file: prefer_const_constructors

import 'package:appinio_study_case/layouts/home_layout.dart';
import 'package:appinio_study_case/shared/AppProvider.dart';
import 'package:appinio_study_case/shared/network.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppProvider>(
      create: (context) => AppProvider()
        ..initWeatherData()
        ..initCityName(),
      child: Consumer<AppProvider>(
        builder: (context, provider, state) {
          return CupertinoApp(
            theme:
                CupertinoThemeData(primaryColor: CupertinoColors.systemIndigo),
            title: 'Sample App',
            home: HomeLayout(),
          );
        },
      ),
    );
  }
}
