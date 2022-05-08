import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/services/abstracts/firestore_abstract.dart';

class TransactionService
    extends FirestoreAbstract<Transaction, TransactionQueryParams> {
  final String _collectionPath = 'transactions';

  @override
  createModel(doc) {
    Map<String, dynamic> data = doc.data()!;
    data.putIfAbsent('id', () => doc.id);
    return Transaction.fromFirebase(data);
  }

  @override
  String getPath() {
    return _collectionPath;
  }

  @override
  createQuery(collectionRef, queryParams) {
    if (queryParams == null) {
      return collectionRef;
    }

    if (queryParams.createdAtFrom != null) {
      collectionRef = collectionRef.where('createdAt',
          isGreaterThanOrEqualTo: queryParams.createdAtFrom);
    }

    if (queryParams.createdAtTo != null) {
      collectionRef = collectionRef.where('createdAt',
          isLessThanOrEqualTo: queryParams.createdAtTo);
    }

    return collectionRef;
  }
}
