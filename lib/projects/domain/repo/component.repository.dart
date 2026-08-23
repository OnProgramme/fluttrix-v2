import 'package:dartz/dartz.dart';
import 'package:fluttrix/projects/domain/entities/component.entity.dart';
import 'package:fluttrix/shared/exceptions/app.failure.dart';

abstract class ComponentRepository {
  Future<Either<AppFailure, List<Component>>> getComponents(String projectId);
  Future<Either<AppFailure, Component>> create(Component component);
  Future<Either<AppFailure, Unit>> delete(String componentId);
  Future<Either<AppFailure, Unit>> deleteAll(String projectId);
}
