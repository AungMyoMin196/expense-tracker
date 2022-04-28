import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirestoreDocAbstract {
  toFirebase();
}

abstract class FirestoreAbstract<T extends FirestoreDocAbstract> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String getPath();

  T createModel(DocumentSnapshot<Map<String, dynamic>> doc);

  Future<List<T>> getCollection() {
    // try {
    //   QuerySnapshot<Map<String, dynamic>> querySnapshot =
    //       await firestore.collection(getPath()).get();

    //   return querySnapshot.docs.map(createModel).toList();
    // } on Exception {
    //   rethrow;
    // }
    return firestore
        .collection(getPath())
        .get()
        .then(
          (querySnapshot) => querySnapshot.docs.map(createModel).toList(),
        )
        .catchError((Object e, StackTrace stackTrace) => throw e);
  }

  Stream<List<T>> getCollectionSteam() {
    return firestore
        .collection(getPath())
        .snapshots()
        .asyncMap(
            (querySnapshot) => querySnapshot.docs.map(createModel).toList())
        .handleError((err) => err);
  }

  Future<T> getItem(String id) {
    return firestore
        .collection(getPath())
        .doc(id)
        .get()
        .then(createModel)
        .catchError((Object e, StackTrace stackTrace) => throw e);
  }

  Future<void> setItem({String? id, required T item}) {
    return firestore
        .collection(getPath())
        .doc(id)
        .set(item.toFirebase())
        .catchError((Object e, StackTrace stackTrace) => throw e);
  }

  Future<void> removeItem(String id) {
    return firestore
        .collection(getPath())
        .doc(id)
        .delete()
        .catchError((Object e, StackTrace stackTrace) => throw e);
  }
}
