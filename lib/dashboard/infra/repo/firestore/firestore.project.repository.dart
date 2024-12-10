import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fluttrix/dashboard/domain/entities/project.entity.dart';
import 'package:fluttrix/dashboard/domain/repo/project.repository.dart';
import 'package:fluttrix/shared/exceptions/app.failure.dart';

class FirestoreProjectRepository implements ProjectRepository {
  CollectionReference get collection =>
      FirebaseFirestore.instance.collection("Projects");

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
}
