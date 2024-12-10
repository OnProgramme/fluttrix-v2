import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:fluttrix/dashboard/presentation/controllers/dashboard.controller.dart';
import 'package:fluttrix/shared/components/consumer.async.dart';
import 'package:get/get.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConsumerAsync(
        notifier: [
          controller.getAllProjectsAsync,
        ],
        builder: (context, async) {
          final pAsync = async[0];
          final projects = pAsync.data ?? [];
          return pAsync.isPending
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : LayoutGrid(
                  columnSizes: [1.fr, 1.fr, 1.fr],
                  rowSizes: [auto, auto, auto],
                  children: [
                    ...projects.map((project) {
                      return Container(
                        decoration: BoxDecoration(
                            border: Border.all()
                        ),
                        width: MediaQuery.sizeOf(context).width,
                        child: Text(project.name),
                      );
                    }),
                    IconButton(onPressed: controller.handleCreateNewProject, icon: Icon(Icons.add))
                  ],
                );
        },
      ),
    );
  }
}
