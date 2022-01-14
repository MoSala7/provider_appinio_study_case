// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:appinio_study_case/shared/AppProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, provider, state) {
        return CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            items: [
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.info), label: "About")
            ],
          ),
          tabBuilder: (context, i) {
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(
                    backgroundColor: Color(0xffebf0ed),
                    resizeToAvoidBottomInset: true,
                    navigationBar: CupertinoNavigationBar(
                      middle: Text("Sample App"),
                    ),
                    child: SafeArea(child: provider.pages[i]));
              },
            );
          },
        );
      },
    );
  }
}
