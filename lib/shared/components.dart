// ignore_for_file: prefer_const_constructors

import 'package:appinio_study_case/modules/temp_detailed_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';

Widget shimmerLoader() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
    decoration: BoxDecoration(
        boxShadow: const [BoxShadow(color: CupertinoColors.systemGrey)],
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(10)),
    child: ProfilePageShimmer(),
  );
}

//The main weather widget that contains cityName, Temprature now and cloud status
Widget tempNow(provider, bool clickable, context) {
  return GestureDetector(
    onTap: () {
      if (clickable) {
        Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
          return TempDetailedPage();
        }));
      }
    },
    child: Container(
      decoration: BoxDecoration(
          boxShadow: const [BoxShadow(color: CupertinoColors.systemGrey)],
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(5),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Text(
            provider.cityName,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 10),
          Text(
            "${provider.tempNow}°",
            style: TextStyle(fontSize: 42, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${provider.getCloudCover(provider.cloudNow)}\t\t",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              Image.asset(
                provider.getCloudCoverIcon(provider.cloudNow),
                height: 25,
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    ),
  );
}

//The second weather widget that contains more data : humidity, Clarity, Wind speed and Wind direction
Widget detailsNow(cubit, context) {
  List images = [
    "assets/icons/humidity.png",
    "assets/icons/clarity.png",
    "assets/icons/windspeed.png",
    "assets/icons/winddirection.png"
  ];
  List titles = ["Humidity", "Clarity", "Wind speed", "Wind direction"];
  List vals = [
    "${cubit.humidityNow}",
    "${cubit.clarityNow}",
    "${cubit.windSpeedNow}",
    "${cubit.windDirectionNow}"
  ];
  return Container(
    decoration: BoxDecoration(
        boxShadow: const [BoxShadow(color: CupertinoColors.systemGrey)],
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(10)),
    padding: EdgeInsets.all(20),
    margin: EdgeInsets.all(5),
    width: double.infinity,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (var v in [0, 1, 2, 3]) oneDetailed(images[v], titles[v], vals[v]),
      ],
    ),
  );
}

Widget oneDetailed(String img, String title, String val) {
  return Column(
    children: [
      Image.asset(
        img,
        height: 30,
      ),
      SizedBox(height: 5),
      Text(
        title,
        style: TextStyle(fontSize: 12, color: CupertinoColors.inactiveGray),
      ),
      SizedBox(height: 5),
      Text(
        val,
        style: TextStyle(fontSize: 14),
      ),
    ],
  );
}
