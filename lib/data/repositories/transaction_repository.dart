import 'package:expense_tracker/data/models/transaction.dart';
import 'package:expense_tracker/data/repositories/contracts/firestore_crud_contract.dart';

class TransactionRepository
    extends FirestoreCrudContract<Transaction, TransactionQueryParams> {
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

    if (queryParams.uid != null) {
      collectionRef = collectionRef.where('uid', isEqualTo: queryParams.uid);
    }

    if (queryParams.dateFrom != null) {
      collectionRef = collectionRef.where('date',
          isGreaterThanOrEqualTo: queryParams.dateFrom);
    }

    if (queryParams.dateTo != null) {
      collectionRef =
          collectionRef.where('date', isLessThan: queryParams.dateTo);
    }

    return collectionRef.orderBy('date', descending: true);
  }
}
