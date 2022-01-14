import 'package:appinio_study_case/shared/AppProvider.dart';
import 'package:appinio_study_case/shared/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class HomeModule extends StatelessWidget {
  const HomeModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, provider, state) {
        return Column(
          children: [
            provider.tempNow == 0
                ? shimmerLoader()
                : tempNow(provider, true, context),
            const Spacer()
          ],
        );
      },
    );
  }
}
