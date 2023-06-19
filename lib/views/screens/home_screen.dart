import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../controller/global_controller.dart';
import '../../utils/custom_colors.dart';
import '../widgets/comfort_level_widget.dart';
import '../widgets/current_weather_widget.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/daily_weather_widget.dart';
import '../widgets/header_widget.dart';
import '../widgets/hourly_data_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  // Call GlobalController

  late final AnimationController _controller;
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: const Duration(minutes: 2), vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Obx(() => globalController.checkLoading().isTrue
              ? Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        CustomColors.secondGradientColor,
                        CustomColors.cardColor
                      ])),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset("assets/json/32532-day-night.json",
                            controller: _controller, onLoaded: (composition) {
                          _controller
                            ..duration = composition.duration
                            ..forward();
                        }),

                        //  const CircularProgressIndicator(),
                      ],
                    ),
                  ),
                )
              : Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        CustomColors.secondGradientColor,
                        CustomColors.cardColor
                      ])),
                  child: Center(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const HeaderWidget(),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          controller: globalController.searchController.value,
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        // For current temperature ('current')
                        CurrentWeather(
                          globalController: globalController,
                          weatherDataCurrent:
                              globalController.getData().getCurrentWeather(),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // For hourly temperature ('hourly')
                        HourlyWeather(
                          weatherDataHourly:
                              globalController.getData().getHourlyWeather(),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // For daily temperature ('daily')
                        DailyWeather(
                          weatherDataDaily:
                              globalController.getData().getDailyWeather(),
                        ),
                        Container(
                          height: 1.0,
                          color: CustomColors.dividerLine,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ComfortLevel(
                          weatherDataCurrent:
                              globalController.getData().getCurrentWeather(),
                        ),

                        const SizedBox(
                          height: 60,
                        ),
                      ],
                    ),
                  ),
                ))),
    );
  }
}
