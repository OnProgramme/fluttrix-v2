import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fluttrix/projects/domain/entities/component.entity.dart';
import 'package:fluttrix/projects/domain/repo/component.repository.dart';
import 'package:fluttrix/shared/exceptions/app.failure.dart';

class FirestoreComponentRepository implements ComponentRepository {
  CollectionReference get collection =>
      FirebaseFirestore.instance.collection("Components");

  @override
  Future<Either<AppFailure, List<Component>>> getComponents(
      String projectId) async {
    try {
      final response = await collection
          .where('projectId', isEqualTo: projectId)
          .get();
      return Right(response.docs
          .map((doc) => Component.fromJson(doc.data() as Map<String, dynamic>))
          .toList());
    } catch (e) {
      return Left(AppFailure.failFetch());
    }
  }

  @override
  Future<Either<AppFailure, Component>> create(Component component) async {
    try {
      await collection.doc(component.id).set(component.toJson());
      return Right(component);
    } catch (e) {
      return Left(AppFailure.failSaved());
    }
  }

  @override
  Future<Either<AppFailure, Unit>> delete(String componentId) async {
    try {
      await collection.doc(componentId).delete();
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
}
