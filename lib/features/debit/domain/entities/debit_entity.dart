import 'package:equatable/equatable.dart';
import 'package:paisa/core/common_enum.dart';

class DebitEntity extends Equatable {
  final double? amount;
  final DateTime? dateTime;
  final DebitType? debtType;
  final String? description;
  final DateTime? expiryDateTime;
  final String? name;
  final int? superId;

  const DebitEntity({
    this.amount,
    this.dateTime,
    this.debtType,
    this.description,
    this.expiryDateTime,
    this.name,
    this.superId,
  });

  @override
  List<Object?> get props => [
        amount,
        dateTime,
        debtType,
        description,
        expiryDateTime,
        name,
        superId,
      ];
}
