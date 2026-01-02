import 'package:equatable/equatable.dart';

enum TransactionType { credit, debit }

enum TransactionStatus { pending, completed, failed }

class TransactionEntity extends Equatable {
  final String id;
  final double amount;
  final String description;
  final DateTime date;
  final TransactionType type;
  final TransactionStatus status;

  const TransactionEntity({
    required this.id,
    required this.amount,
    required this.description,
    required this.date,
    required this.type,
    required this.status,
  });

  @override
  List<Object?> get props => [id, amount, description, date, type, status];
}
