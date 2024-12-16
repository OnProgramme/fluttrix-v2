import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:fluttrix/projects/presentation/controllers/dashboard.controller.dart';
import 'package:fluttrix/shared/components/consumer.async.dart';
import 'package:fluttrix/utils/app.colors.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Row(
        children: [
          Container(
            margin: EdgeInsets.all(15),
            width: 300,
            height: size.height,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 15, right: 15),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10)),
                    height: 40,
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: controller.handleLogout,
                            icon: Icon(LucideIcons.logOut))
                      ],
                    ),
                  ),
                  Expanded(
                    child: ConsumerAsync(
                      notifier: [
                        controller.getAllProjectsAsync,
                      ],
                      builder: (context, async) {
                        final pAsync = async[0];
                        if (pAsync.isPending) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final projects = pAsync.data ?? [];
                        return Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: LayoutGrid(
                            columnSizes: [1.fr, 1.fr, 1.fr],
                            rowSizes: [auto, auto, auto],
                            rowGap: 20,
                            columnGap: 20,
                            children: [
                              ...projects.map((project) {
                                return ConsumerAsync(
                                    notifier: [controller.deleteProjectAsync],
                                    builder: (context, async) {
                                      return Container(
                                        height: 200,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                          color: AppColors.white,
                                        )),
                                        width: MediaQuery.sizeOf(context).width,
                                        child: Stack(
                                          children: [
                                            Center(child: Text(project.name)),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: async[0].isPending
                                                  ? SizedBox(
                                                      width: 30,
                                                      height: 30,
                                                      child:
                                                          CircularProgressIndicator())
                                                  : IconButton(
                                                      onPressed: () => controller
                                                          .handleDeleteProject(
                                                              project.id),
                                                      icon: Icon(
                                                          LucideIcons.delete)),
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              }),
                              Container(
                                height: 200,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.white,
                                  ),
                                ),
                                width: MediaQuery.sizeOf(context).width,
                                child: IconButton(
                                    onPressed:
                                        controller.handleCreateNewProject,
                                    icon: Icon(Icons.add)),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
