import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/data/models/contracts/to_firebase.dart';

abstract class FirestoreCrudContract<T extends ToFirebase, K> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String getPath();

  T createModel(DocumentSnapshot<Map<String, dynamic>> doc);

  Query<Map<String, dynamic>> createQuery(
      Query<Map<String, dynamic>> collectionRef, K? queryParams) {
    return collectionRef;
  }

  Future<List<T>> getCollection(K? queryParams) {
    CollectionReference<Map<String, dynamic>> collectionRef =
        _firestore.collection(getPath());
    return createQuery(collectionRef, queryParams)
        .get()
        .then(
          (querySnapshot) => querySnapshot.docs.map(createModel).toList(),
        )
        .catchError((Object e, StackTrace stackTrace) => throw e);
  }

  Stream<List<T>> getCollectionSteam(K? queryParams) {
    CollectionReference<Map<String, dynamic>> collectionRef =
        _firestore.collection(getPath());

    return createQuery(collectionRef, queryParams)
        .snapshots()
        .asyncMap(
            (querySnapshot) => querySnapshot.docs.map(createModel).toList())
        .handleError((err) => err);
  }

  Future<T> getItem(String id) {
    return _firestore
        .collection(getPath())
        .doc(id)
        .get()
        .then(createModel)
        .catchError((Object e, StackTrace stackTrace) => throw e);
  }

  Future<void> setItem({String? id, required T item}) {
    return _firestore
        .collection(getPath())
        .doc(id)
        .set(item.toFirebase())
        .catchError((Object e, StackTrace stackTrace) => throw e);
  }

  Future<void> removeItem(String id) {
    return _firestore
        .collection(getPath())
        .doc(id)
        .delete()
        .catchError((Object e, StackTrace stackTrace) => throw e);
  }
}
