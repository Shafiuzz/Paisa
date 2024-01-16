import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:paisa/core/common.dart';
import 'package:provider/provider.dart';
import 'setting_option.dart';

class DynamicColorSwitchWidget extends StatefulWidget {
  const DynamicColorSwitchWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<DynamicColorSwitchWidget> createState() =>
      _DynamicColorSwitchWidgetState();
}

class _DynamicColorSwitchWidgetState extends State<DynamicColorSwitchWidget> {
  late final Box<dynamic> settings =
      Provider.of<Box<dynamic>>(context, listen: false);
  late bool isSelected = settings.get(
    dynamicThemeKey,
    defaultValue: false,
  );
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return SettingsOption(
          title: context.loc.dynamicColor,
          trailing: Switch(
            activeColor: context.primary,
            value: isSelected,
            onChanged: (value) {
              settings.put(dynamicThemeKey, value);
              setState(() {
                isSelected = value;
              });
            },
          ),
        );
      },
    );
  }
}
