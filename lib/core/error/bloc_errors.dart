import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:paisa/core/common.dart';

part 'bloc_errors.freezed.dart';

@freezed
class AccountErrors with _$AccountErrors {
  const factory AccountErrors.accountNotFound() = _AccountNotFound;
  const factory AccountErrors.bankName() = _BankNameError;
  const factory AccountErrors.holderNameError() = _HolderNameError;
  const factory AccountErrors.colorError() = _ColorError;
}

extension AccountErrorsHelper on AccountErrors {
  String errorString(BuildContext context) {
    return when(
      accountNotFound: () => context.loc.accountNotFound,
      bankName: () => context.loc.bankNameError,
      holderNameError: () => context.loc.holderNameError,
      colorError: () => context.loc.accountColorError,
    );
  }
}
