import 'package:appinio_study_case/shared/AppProvider.dart';
import 'package:appinio_study_case/shared/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class TempDetailedPage extends StatelessWidget {
  const TempDetailedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, provider, state) {
        return CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(),
            backgroundColor: const Color(0xffebf0ed),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    tempNow(provider, false, context),
                    detailsNow(provider, context),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
