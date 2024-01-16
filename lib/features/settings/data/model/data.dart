// To parse this JSON data, do
//
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:paisa/features/account/data/model/account_model.dart';
import 'package:paisa/features/category/data/model/category_model.dart';
import 'package:paisa/features/debit/data/models/debit_model.dart';
import 'package:paisa/features/debit_transaction/data/model/debit_transactions_model.dart';
import 'package:paisa/features/transaction/data/model/transaction_model.dart';

class Data {
  Data({
    required this.expenses,
    required this.accounts,
    required this.categories,
    required this.debits,
    required this.debitTransactions,
  });

  final List<TransactionModel> expenses;
  final List<AccountModel> accounts;
  final List<CategoryModel> categories;
  final List<DebitModel> debits;
  final List<DebitTransactionsModel> debitTransactions;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        debitTransactions: List<DebitTransactionsModel>.from(
            (json["transactions"] ?? [])
                .map((x) => DebitTransactionsModel.fromJson(x))),
        debits: List<DebitModel>.from(
            (json["debits"] ?? []).map((x) => DebitModel.fromJson(x))),
        expenses: List<TransactionModel>.from(
            json["expenses"].map((x) => TransactionModel.fromJson(x))),
        accounts: List<AccountModel>.from(
            json["accounts"].map((x) => AccountModel.fromJson(x))),
        categories: List<CategoryModel>.from(
            json["categories"].map((x) => CategoryModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "expenses": List<dynamic>.from(expenses.map((x) => x.toJson())),
        "accounts": List<dynamic>.from(accounts.map((x) => x.toJson())),
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "transactions":
            List<dynamic>.from(debitTransactions.map((x) => x.toJson())),
        "debits": List<dynamic>.from(debits.map((x) => x.toJson())),
      };
}
