import 'package:collection/collection.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:paisa/features/debit_transaction/data/model/debit_transactions_model.dart';
import 'package:paisa/features/debit_transaction/domain/entity/debit_transaction_entity.dart';

extension MappingOnTransactionsBox on Box<DebitTransactionsModel> {
  List<DebitTransactionEntity> getTransactionsFromId(int parentId) {
    return values.where((element) => element.parentId == parentId).toEntities();
  }
}

extension MappingOnTransaction on DebitTransactionsModel {
  DebitTransactionEntity toEntity() => DebitTransactionEntity(
        amount: amount,
        now: now,
        parentId: parentId,
        superId: superId,
      );
}

extension MappingOnTransactions on Iterable<DebitTransactionsModel> {
  List<Map<String, dynamic>> toJson() {
    return map((e) => e.toJson()).toList();
  }

  List<DebitTransactionEntity> toEntities() => map((e) => e.toEntity())
      .sorted((a, b) => b.now!.compareTo(a.now!))
      .toList();
}
