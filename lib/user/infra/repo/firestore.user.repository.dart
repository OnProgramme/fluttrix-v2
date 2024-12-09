import 'package:dartz/dartz.dart';
import 'package:fluttrix/shared/exceptions/app.failure.dart';
import 'package:fluttrix/user/domain/entities/user.entity.dart';
import 'package:fluttrix/user/domain/repo/i.user.repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreUserRepository implements IUserRepository {
  CollectionReference get userCollection =>
      FirebaseFirestore.instance.collection("Users");

  @override
  Future<Either<AppFailure, User>> saveUser(User user) async {
    try {
      await userCollection.doc(user.userId).set(user.toJson()..addAll({
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      }));
      return Right(user);
    } catch (e) {
      return Left(AppFailure.internetConnection());
    }
  }

  @override
  Future<Either<AppFailure, User>> getUserByEmail(String email) async {
    try {
      final data =
          await userCollection.where('email', isEqualTo: email).limit(1).get();
      if(data.docs.isEmpty){
        return Left(AppFailure.userNotExist());
      }
      return Right(User.fromJson(data.docs.first.data() as Map<String, dynamic>));
    } catch (e) {
      return Left(AppFailure.internetConnection());
    }
  }
}
