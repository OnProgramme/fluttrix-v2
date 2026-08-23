import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fluttrix/projects/application/usecases/screens/update/udpate.screen.command.dart';
import 'package:fluttrix/projects/domain/entities/screen.entity.dart';
import 'package:fluttrix/projects/domain/repo/screen.repository.dart';
import 'package:fluttrix/shared/exceptions/app.failure.dart';

class FirestoreScreenRepository implements ScreenRepository {
  CollectionReference get collection =>
      FirebaseFirestore.instance.collection("Screens");

  @override
  Future<Either<AppFailure, Screen>> create(Screen screen) async {
    try {
      await collection.doc(screen.id).set(screen.toJson());
      return Right(screen);
    } catch (e) {
      return Left(AppFailure.failSaved());
    }
  }

  @override
  Future<Either<AppFailure, List<Screen>>> getScreens(String projectId) async {
    try {
      final response = await collection
          .where('projectId', isEqualTo: projectId)
          .get();
      return Right(response.docs
          .map((doc) => Screen.fromJson(doc.data() as Map<String, dynamic>))
          .toList());
    } catch (e) {
      return Left(AppFailure.failFetch());
    }
  }

  @override
  Future<Either<AppFailure, Unit>> delete(String screenId) async {
    try {
      await collection.doc(screenId).delete();
      return Right(unit);
    } catch (e) {
      return Left(AppFailure.failDeleted());
    }
  }

  @override
  Future<Either<AppFailure, Unit>> deleteAll(String projectId) async {
    try {
      final response = await collection
          .where('projectId', isEqualTo: projectId)
          .get();
      if (response.docs.isEmpty) return Right(unit);
      final batch = FirebaseFirestore.instance.batch();
      for (final doc in response.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
      return Right(unit);
    } catch (e) {
      return Left(AppFailure.failDeleted());
    }
  }

  @override
  Future<Either<AppFailure, Unit>> updateScreen(UpdateScreenCommand command) async {
    try {
      await collection.doc(command.screenId).update(command.toJson());
      return Right(unit);
    } catch (e) {
      return Left(AppFailure.failSaved());
    }
  }
}
