import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fluttrix/projects/domain/entities/project.entity.dart';
import 'package:fluttrix/projects/domain/events/project.deleted.dart';
import 'package:fluttrix/projects/domain/repo/project.repository.dart';
import 'package:fluttrix/shared/events/domain/events/event.name.dart';
import 'package:fluttrix/shared/events/domain/interfaces/event.dispatcher.dart';
import 'package:fluttrix/shared/exceptions/app.failure.dart';
import 'package:fluttrix/utils/app.dependencies.dart';

class FirestoreProjectRepository implements ProjectRepository {
  CollectionReference get collection =>
      FirebaseFirestore.instance.collection("Projects");
  final _eventDispatch = AppDependencies.get<EventDispatcher>();


  @override
  Future<Either<AppFailure, Project>> create(Project project) async {
    try {
      await collection.doc(project.id).set(project.toJson());

      return Right(project);
    } catch (e) {
      return Left(AppFailure.failSaved());
    }
  }

  @override
  Future<Either<AppFailure, List<Project>>> getProjects(String userId) {
    return collection.where('userId', isEqualTo: userId).get().then((response) {
      return Right(response.docs
          .map((doc) => Project.fromJson(doc.data() as Map<String, dynamic>))
          .toList());
    });
  }

  @override
  Future<Either<AppFailure, Unit>> delete(String projectId) async{
    await collection.doc(projectId).delete();
    _eventDispatch.dispatch(EventName.projectDeleted, ProjectDeleted(projectId: projectId));
    return Right(unit);
  }
}
