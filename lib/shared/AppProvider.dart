import 'dart:convert';

import 'package:appinio_study_case/models/profile_model.dart';
import 'package:appinio_study_case/models/timer_model.dart';
import 'package:appinio_study_case/modules/about_page.dart';
import 'package:appinio_study_case/modules/home_page.dart';
import 'package:appinio_study_case/shared/network.dart';
import 'package:flutter/cupertino.dart';

class AppProvider extends ChangeNotifier {
  List pages = [HomeModule(), AboutModule()];
  ProfileModel profileModel = ProfileModel();
  late TimerModel timerModel;
  DateTime timeNow = DateTime.now();
  late DateTime initTime;
  late int tempNow = 0, cloudNow = 0, timePointFromNow = 0;
  late String humidityNow, windSpeedNow, windDirectionNow, clarityNow;

  late String? cityName = "";
  void initCityName() {
    DioHelper.geCityName().then((v) {
      cityName = v.data[0]["local_names"]["en"];
      // print(cityName);
      notifyListeners();
    }).catchError((e) {
      cityName = "Not Found";
      // print(e);
      notifyListeners();
    });
  }

  void initWeatherData() {
    DioHelper.getWeatherData().then((value) {
      timerModel = TimerModel.fromJson(jsonDecode(value.toString()));
      //Next steps to assign the init value to a DateTime variable
      int year = int.parse(timerModel.init.substring(0, 4));
      int month = int.parse(timerModel.init.substring(4, 6));
      int day = int.parse(timerModel.init.substring(6, 8));
      int hour = int.parse(timerModel.init.substring(8, 10));
      initTime = DateTime.utc(year, month, day, hour);
      //The timepoint is the most important value its responsible to get the all of current attributes based on the current time
      //The current time is always later than the initial time so i've calucaled the difference hours with considiration of day differences
      //There are two cases, the current hour is less than the initail hour so it means we are in new day so i must add 24 hours to correct the different day
      //The other case which the current hour is greater than the initial hour
      //Next step is to subtract inithour from currenthour and then subtract with 3 as the timepoint steps are 3,
      //Last step is to calculate the reminder to know how many itareble steps will be taken in our dateseries.
      timePointFromNow =
          (((timeNow.hour < initTime.hour ? timeNow.hour + 24 : timeNow.hour) -
                      initTime.hour) /
                  3)
              .remainder(3)
              .round();
      getWeatherDataNow();
      notifyListeners();
    }).catchError((error) {
      // print(error.toString());
      notifyListeners();
    });
  }

  //This function assign humidity, windspeed, winddirection, transparency based on the time now.
  getWeatherDataNow() {
    tempNow = timerModel.dataseries[timePointFromNow].temp2m;
    cloudNow = timerModel.dataseries[timePointFromNow].cloudcover;
    humidityNow = getHumididty(timerModel.dataseries[timePointFromNow].rh2m);
    windSpeedNow =
        getWindSpeed(timerModel.dataseries[timePointFromNow].wind10m["speed"]);
    windDirectionNow = getWindDirection(
        timerModel.dataseries[timePointFromNow].wind10m["direction"]);
    clarityNow = getHumididty(timerModel.dataseries[timePointFromNow].seeing);
  }

  //Based on Documentation on the official website http://www.7timer.info/doc.php#astro
  //Functions to simplified the response variables to more readably values.
  //This function simplify the Cloud Cover values to 3 simple words.
  getCloudCover(int x) {
    if (x < 4) return "Sunny";
    if (x >= 4 && x < 7) return "Partly Cloud";
    if (x >= 7) return "Mostly Cloud";
  }

  //This function responsible to decide which icon will be shown for the user based on current Cloud Cover value.
  getCloudCoverIcon(int x) {
    if (x < 4) return "assets/icons/sunny.png";
    if (x >= 4 && x < 7) return "assets/icons/partlycloud.png";
    if (x >= 7) return "assets/icons/cloudy.png";
  }

  //This function simplify the 2m Relative Humidity values based on documentation each one number is responisble for 5% of humidity.
  getHumididty(int x) {
    //simple sequences function to calculate the humididty based on its value, as it start from -4 it should be starting from 0 for simplifying the equation
    return "${((x + 4) * 5)} %";
  }

  //This function simplify the Transparency(clarity) values based on documentation each one number is responisble for 12.5% from 0 to 100.
  getClarity(int x) {
    // an upscaled to 100 simple equationg to make it more readable for users
    return "${(x * 0.125) * 100} %";
  }

//This function simplify the Cloud speed values to 3 simple values.
  getWindSpeed(int x) {
    if (x < 4) return "< 14 km/h";
    if (x >= 4 && x < 6) return "< 72 km/h";
    if (x >= 6) return "> 72 km/h";
  }

  getWindDirection(String x) {
    if (x == "NE") {
      return "Northwest";
    } else if (x == "E") {
      return "East";
    } else if (x == "N") {
      return "North";
    } else if (x == "SE") {
      return "Southeast";
    } else if (x == "S") {
      return "South";
    } else {
      return x;
    }
  }
}
