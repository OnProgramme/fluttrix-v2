import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:fluttrix/presentation/widgets/inputs/input.dropdown.dart';
import 'package:get/get.dart';

class ChooseIconController extends GetxController {
  final loading = false.obs;
  Map<String, List<dynamic>> groupedIcons = {};
  final selectedIconType = "material".obs;
  List<InputDropdownItem<String>> iconsType = [];
  final query = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadIconsData();
  }

  Future<void> loadIconsData() async {
    loading.value = true;
    final String response =
        await rootBundle.loadString('assets/icons/icons.json');
    final Map<String, dynamic> iconsData = json.decode(response);
    groupedIcons =
        groupBy(iconsData["glyphs"] as List<dynamic>, (i) => i["src"]);
    iconsType = groupedIcons.entries.map((entry) {
      return InputDropdownItem(
          "${entry.key.toString().capitalizeFirst!} (${entry.value.length})",
          entry.key.toString());
    }).toList();
    loading.value = false;
  }

  void handleChangedIconsType(String value) {
    selectedIconType.value = value;
  }

  List<dynamic> get icons => groupedIcons[selectedIconType.value]!
      .where((icon) => icon["css"]
          .toString()
          .toLowerCase()
          .contains(query.value.toLowerCase()))
      .toList();
}
