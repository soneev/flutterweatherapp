import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';

import '../../controller/global_controller.dart';


class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  String city = "";

  String date = DateFormat("yMMMMd").format(DateTime.now());

  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  void initState() {
    getAddress(globalController.getLattitude().value,
        globalController.getLongitude().value);
    super.initState();
  }

  getAddress(lat, lon) async {
    List<Placemark> placemark = await placemarkFromCoordinates(lat, lon);
    Placemark place = placemark[0];
    setState(() {
      city = place.locality!;
    });
  }

  Widget build(BuildContext context) {
    return     Obx(() => Column(
      children: [
     Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          alignment: Alignment.topLeft,
          child: !globalController.searchActive.value? Text(
            city,
            style: const TextStyle(
              fontSize: 35,
              height: 2,
            ),
          ):Text(
            globalController.getSearchjsonData.value.name??"",
            style: const TextStyle(
              fontSize: 35,
              height: 2,
            ),
          )
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          alignment: Alignment.topLeft,
          child: Text(
            date,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              height: 1.5,
            ),
          ),
        ),
      ],
    ));
  }
}
