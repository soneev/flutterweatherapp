import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/global_controller.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;

  const CustomTextField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalController globalController =
        Get.put(GlobalController(), permanent: true);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
          controller: controller,
          style: const TextStyle(fontSize: 16.0),
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(40.0, 10, 30.0, 20.0),
              // prefixIcon: Icon(Icons.search),
              suffix: GestureDetector(
                  onTap: () async {
                    await globalController.getSearchData();
                  },
                  child: const Icon(Icons.search)),
              hintText: " Enter City name",
              border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.white, width: 32.0),
                  borderRadius: BorderRadius.circular(25.0)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Colors.white,
                      width: 32.0,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(25.0)))),
    );
  }
}
