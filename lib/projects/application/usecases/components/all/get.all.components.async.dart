import 'package:dartz/dartz.dart';
import 'package:fluttrix/projects/domain/entities/component.entity.dart';
import 'package:fluttrix/projects/domain/repo/component.repository.dart';
import 'package:fluttrix/shared/exceptions/app.failure.dart';
import 'package:fluttrix/shared/usecases/usecase.dart';

class GetAllComponentsAsync extends UseCaseWithCommand<List<Component>, String> {
  final ComponentRepository repo;
  GetAllComponentsAsync(this.repo);

  @override
  Future<Either<AppFailure, List<Component>>> execute(String command) {
    return call(repo.getComponents(command));
  }
}
