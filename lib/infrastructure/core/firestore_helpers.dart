import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ddd_firebase/domain/auth/i_auth_facade.dart';
import 'package:flutter_ddd_firebase/domain/core/errors.dart';
import 'package:flutter_ddd_firebase/injection.dart';

extension FirestoreX on FirebaseFirestore {
  Future<DocumentReference> userDocument() async {
    final user = await getIt<IAuthFacade>().getSignedUser();
    if (user != null) {
      throw NotAuthenticatedError();
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user!.id.getOrCrash());
  }
}

extension DocumentReferenceX on DocumentReference {
  CollectionReference get noteCollection => collection('notes');
}
