import 'package:flutter/material.dart';
import 'package:paisa/features/account/domain/entities/account_entity.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'accounts_mobile_page.dart';
import 'accounts_tablet_page.dart';

class AccountMobileHorizontalPage extends StatelessWidget {
  const AccountMobileHorizontalPage({
    super.key,
    required this.accounts,
  });

  final List<AccountEntity> accounts;

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (p0) => AccountsHorizontalMobilePage(accounts: accounts),
      tablet: (p0) => AccountsHorizontalTabletPage(accounts: accounts),
    );
  }
}
