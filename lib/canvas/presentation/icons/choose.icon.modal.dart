import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.custom.icon.dart';
import 'package:fluttrix/canvas/presentation/icons/choose.icon.controller.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.textfield.dart';
import 'package:fluttrix/presentation/widgets/inputs/input.dropdown.dart';
import 'package:fluttrix/utils/app.colors.dart';
import 'package:get/get.dart';

class ChooseIconModal extends GetView<ChooseIconController> {
  const ChooseIconModal({super.key});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SizedBox(
        height: 550,
        width: 700,
        child: Column(
          children: [
            Container(
              width: Get.width,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: AppColors.grey,
              ))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Choisir une icone",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CloseButton()
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: FTextField(
                      onChanged: controller.query.call,
                      prefixIcon: Icon(Icons.search),
                      hint: "Rechercher une icone",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 180,
                    child: InputDropdown(
                      height: 41,
                      value: controller.selectedIconType.value,
                      items: controller.iconsType,
                      onChanged: controller.handleChangedIconsType,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Obx(() => controller.loading.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.all(10),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 8, // Nombre de colonnes
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: controller.icons.length,
                      itemBuilder: (context, index) {
                        final i = controller.icons[index];
                        final icon = FTrixCustomIcon.fromJson(i);
                        return InkWell(
                          onTap: () => Get.back(result: icon),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                              color: AppColors.background,
                              width: 2,
                            )),
                            width: 85,
                            height: 70,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  icon.iconData,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )),
            )
          ],
        ),
      ),
    );
  }
}
