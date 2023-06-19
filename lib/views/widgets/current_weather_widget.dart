import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/global_controller.dart';
import '../../model/weather_data_current.dart';
import '../../utils/custom_colors.dart';

class CurrentWeather extends StatelessWidget {
  final WeatherDataCurrent weatherDataCurrent;

  const CurrentWeather(
      {Key? key,
      required this.weatherDataCurrent,
      required this.globalController})
      : super(key: key);
  // final GlobalController globalController =
  //     Get.put(GlobalController(), permanent: true);
  final GlobalController globalController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Temperature Area Widget
        temperatureAreaWidget(globalController),

        const SizedBox(
          height: 20.0,
        ),

        // Other Details Widget - WindSpeed, Humidity, Clouds
        otherDetailsWidget(globalController),
      ],
    );
  }

  Widget otherDetailsWidget(GlobalController globalController) {
    return Obx(() => Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: CustomColors.cardColor,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Image.asset("assets/icons/windspeed.png"),
            ),
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: CustomColors.cardColor,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Image.asset("assets/icons/clouds.png"),
            ),
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: CustomColors.cardColor,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Image.asset("assets/icons/humidity.png"),
            ),
          ],
        ),
        const SizedBox(
          height: 14,
        ),
       !globalController.searchActive.value? Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 20,
              width: 60,
              child:
              Text(
                "${weatherDataCurrent.current.windSpeed}km/hr",
                style: const TextStyle(
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              )
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                "${weatherDataCurrent.current.clouds}%",
                style: const TextStyle(
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                "${weatherDataCurrent.current.humidity}%",
                style: const TextStyle(
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ):  Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 20,
              width: 60,
              child:
              Text(
                "${globalController.getSearchjsonData.value.wind!.speed}km/hr",
                style: const TextStyle(
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              )
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                "${globalController.getSearchjsonData.value.clouds!.all}%",
                style: const TextStyle(
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                "${globalController.getSearchjsonData.value.main!.humidity}%",
                style: const TextStyle(
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    ));
  }

  Widget temperatureAreaWidget(GlobalController globalController) {
    return Obx(() =>  Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
     !globalController.searchActive.value?   Image.asset(
          "assets/weather/${weatherDataCurrent.current.weather![0].icon}.png",
        ):Image.asset(
          "assets/weather/${ globalController.getSearchjsonData.value.weather[0].icon}.png",
        ),
        Container(
          height: 50,
          width: 1,
          color: CustomColors.dividerLine,
        ),
        RichText(
            text: !globalController.searchActive.value
                ? TextSpan(
                    children: [
                      TextSpan(
                        text: "${weatherDataCurrent.current.temp!.toInt()}°",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 68,
                          color: CustomColors.textColorBlack,
                        ),
                      ),
                      TextSpan(
                        text:
                            "${weatherDataCurrent.current.weather![0].description}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  )
                : TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "${globalController.getSearchjsonData.value.main!.temp.toInt()}°",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 68,
                          color: CustomColors.textColorBlack,
                        ),
                      ),
                      TextSpan(
                        text:
                            globalController.getSearchjsonData.value.weather[0].description,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  )),
      ],
    ));
  }
}
