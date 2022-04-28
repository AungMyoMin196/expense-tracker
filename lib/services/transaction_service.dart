import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/services/abstracts/firestore_abstract.dart';

class TransactionService extends FirestoreAbstract<Transaction> {
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
}
