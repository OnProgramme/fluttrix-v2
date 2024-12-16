import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
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
  Future<Either<AppFailure, List<Screen>>> getScreens(String projectId) {
    return collection.where('projectId', isEqualTo: projectId).get().then((response) {
      return Right(response.docs
          .map((doc) => Screen.fromJson(doc.data() as Map<String, dynamic>))
          .toList());
    });
  }

  @override
  Future<Either<AppFailure, Unit>> delete(String screenId) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<AppFailure, Unit>> deleteAll(String projectId) {
    return getScreens(projectId).then((response){
      return response.fold((e)=>Left(e), (screens)async{
        for (var screen in screens) {
          await collection.doc(screen.id).delete();
        }
        return Right(unit);
      });
    });
  }
}
