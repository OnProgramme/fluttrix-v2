import 'package:device_frame/device_frame.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.canvas.dart';
import 'package:fluttrix/projects/application/usecases/screens/all/get.all.screens.async.dart';
import 'package:fluttrix/projects/application/usecases/screens/create/create.screen.async.dart';
import 'package:fluttrix/projects/application/usecases/screens/create/create.screen.command.dart';
import 'package:fluttrix/projects/application/usecases/screens/update/udpate.screen.command.dart';
import 'package:fluttrix/projects/application/usecases/screens/update/update.screen.async.dart';
import 'package:fluttrix/projects/domain/entities/screen.entity.dart';
import 'package:fluttrix/shared/infra/fetcher/app.fetcher.dart';
import 'package:fluttrix/shared/usecases/run.usecase.dart';
import 'package:fluttrix/utils/app.dependencies.dart';
import 'package:get/get.dart';

class FCanvasControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FCanvasController>(
      () => FCanvasController(),
    );
  }
}

class FCanvasController extends GetxController {
  final getAllScreensAsync = AppDependencies.get<GetAllScreensAsync>();
  final updateScreenAsync = AppDependencies.get<UpdateScreenAsync>();
  final screensFetcher = AppFetcher<List<Screen>>([]);
  final canvas = FTrixCanvas();
  final canvasSize = Rx(Size.zero);
  final frameKey = GlobalKey();
  final currentDeviceInfo = Devices.ios.iPhone13ProMax.obs;
  final isThreeOpened = false.obs;
  final currentScreenId = "".obs;
  late String projectId;

  @override
  void onInit() {
    super.onInit();
    projectId = Get.parameters['projectId']!;
    WidgetsBinding.instance.addPostFrameCallback((t) {
      final renderBox =
          frameKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox == null) return;
      canvasSize.value = renderBox.size;
    });
    handleGetAllScreens();
    handleListenWhenCanvasUpdated();
    ever(currentScreenId, (screenId) {
      final screen =
          screensFetcher.value.firstWhere((screen) => screen.id == screenId);
      canvas.loadFromJson(screen.data);
    });
  }

  void handleSelectCanvas() {
    canvas.select();
  }

  void handleGetAllScreens() {
    RunUseCase(
      fetcher: screensFetcher,
      useCase: getAllScreensAsync.execute(projectId),
    ).execute(onSuccess: (screens) {
      if (screens.isEmpty) return;
      currentScreenId.value = screens.first.id;
    });
  }

  void handleListenWhenCanvasUpdated() {
    canvas.update.listen((event) async {
      await Future.delayed(Duration.zero);
      updateScreenAsync.execute(
        UpdateScreenCommand(
          screenId: currentScreenId.value,
          data: canvas.toJson(),
        ),
      );
    });
  }

  void createNewScreen() {
    RunUseCase(
            useCase: CreateScreenAsync(AppDependencies.get()).execute(
                CreateScreenCommand(
                    projectId: projectId,
                    name: 'Screen',
                    screenData: FTrixCanvas().toJson())))
        .execute();
  }

  Screen get currentScreen => screensFetcher.value
      .firstWhere((screen) => screen.id == currentScreenId.value);
}
