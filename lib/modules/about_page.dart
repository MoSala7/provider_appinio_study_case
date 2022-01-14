import 'package:appinio_study_case/shared/AppProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class AboutModule extends StatelessWidget {
  const AboutModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, provider, state) {
        return Container(
            height: MediaQuery.of(context).size.height * 0.8,
            margin: const EdgeInsets.only(top: 30, right: 50, left: 50),
            decoration: const BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(200),
                          topRight: Radius.circular(200))),
                  child: Image.asset("assets/img.jpg"),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Contact",
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 35),
                      ),
                      const SizedBox(height: 10),
                      textLink(provider.profileModel.phoneNo, true),
                      const SizedBox(height: 10),
                      textLink(provider.profileModel.email, false),
                      const SizedBox(height: 10),
                      textLink(provider.profileModel.site, false),
                    ],
                  ),
                )
              ],
            ));
      },
    );
  }
}

textLink(String url, bool isPhone) {
  return Text(
    url,
    style: TextStyle(
      fontSize: 16,
      decoration: isPhone ? TextDecoration.none : TextDecoration.underline,
    ),
  );
}
