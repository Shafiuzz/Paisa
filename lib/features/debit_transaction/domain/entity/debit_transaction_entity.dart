import 'package:equatable/equatable.dart';

class DebitTransactionEntity extends Equatable {
  final double? amount;
  final DateTime? now;
  final int? parentId;
  final int? superId;

  const DebitTransactionEntity({
    this.amount,
    this.now,
    this.parentId,
    this.superId,
  });

  @override
  List<Object?> get props => [
        amount,
        now,
        parentId,
        superId,
      ];
}
