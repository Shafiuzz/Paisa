import 'package:flutter/material.dart';

import 'package:paisa/core/common.dart';

Future<int> paisaColorPicker(
  BuildContext context, {
  int defaultColor = 0xFFF44336,
}) async {
  int selectedColor = defaultColor;
  final int? color = await showModalBottomSheet<int>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    constraints: BoxConstraints(
      maxWidth:
          MediaQuery.of(context).size.width >= 700 ? 700 : double.infinity,
    ),
    builder: (context) => Padding(
      padding: MediaQuery.of(context).viewInsets.copyWith(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ListTile(
              title: Text(
                context.loc.pickColor,
                style: context.titleLarge,
              ),
            ),
            ColorSliderWidegt(
              selectedColor: selectedColor,
              onChanged: (value) {
                selectedColor = value;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context, selectedColor);
                },
                child: Text(
                  context.loc.done,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
  return color ?? selectedColor;
}

class ColorSliderWidegt extends StatefulWidget {
  const ColorSliderWidegt({
    super.key,
    required this.selectedColor,
    required this.onChanged,
  });

  final ValueChanged<int> onChanged;
  final int selectedColor;

  @override
  State<ColorSliderWidegt> createState() => _ColorSliderWidegtState();
}

class _ColorSliderWidegtState extends State<ColorSliderWidegt> {
  final TextEditingController editingController = TextEditingController();
  late Color selectedColor = Color(widget.selectedColor);

  @override
  void initState() {
    super.initState();
    convertColorToHex();
  }

  void convertColorToHex() {
    widget.onChanged(selectedColor.value);
    editingController.text =
        '#${selectedColor.value.toRadixString(16)}'.toUpperCase();
  }

  Widget _buildSlider({
    required Color sliderColor,
    required int value,
    required ValueChanged<double> onChanged,
  }) {
    return Row(
      children: [
        Expanded(
          child: Slider(
            activeColor: sliderColor,
            value: value.toDouble(),
            min: 0,
            max: 255,
            onChanged: onChanged,
          ),
        ),
        Text(value.toString()),
        const SizedBox(width: 16)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: ColoredBox(
              color: selectedColor,
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildSlider(
          sliderColor: Colors.red,
          value: selectedColor.red,
          onChanged: (value) {
            convertColorToHex();
            setState(() {
              selectedColor = Color.fromARGB(
                selectedColor.alpha,
                value.toInt(),
                selectedColor.green,
                selectedColor.blue,
              );
            });
          },
        ),
        _buildSlider(
          sliderColor: Colors.green,
          value: selectedColor.green,
          onChanged: (value) {
            convertColorToHex();
            setState(() {
              selectedColor = Color.fromARGB(
                selectedColor.alpha,
                selectedColor.red,
                value.toInt(),
                selectedColor.blue,
              );
            });
          },
        ),
        _buildSlider(
          sliderColor: Colors.blue,
          value: selectedColor.blue,
          onChanged: (value) {
            convertColorToHex();
            setState(() {
              selectedColor = Color.fromARGB(
                selectedColor.alpha,
                selectedColor.red,
                selectedColor.green,
                value.toInt(),
              );
            });
          },
        ),
        const SizedBox(height: 16),
        TextField(
          controller: editingController,
          decoration: const InputDecoration(labelText: 'Hexadecimal Color'),
          onChanged: (hex) {
            if (hex.isNotEmpty && hex.length == 6) {
              setState(() {
                selectedColor = Color(int.parse('0xFF$hex', radix: 16));
              });
            }
          },
        ),
      ],
    );
  }
}

class ColorPickerGridWidget extends StatefulWidget {
  const ColorPickerGridWidget({
    super.key,
    required this.onSelected,
    required this.selectedColor,
  });

  final Function(int) onSelected;
  final int selectedColor;

  @override
  State<ColorPickerGridWidget> createState() => _ColorPickerGridWidgetState();
}

class _ColorPickerGridWidgetState extends State<ColorPickerGridWidget> {
  late int selectedColor = widget.selectedColor;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 16),
      shrinkWrap: true,
      itemCount: Colors.primaries.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width >= 700 ? 9 : 6,
      ),
      itemBuilder: (_, index) {
        final color = Colors.primaries[index].value;
        if (color == selectedColor) {
          return Stack(
            children: [
              Center(
                child: SizedBox(
                  height: 42,
                  width: 42,
                  child: Container(
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(width: 2, color: Color(color)),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(color),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      margin: const EdgeInsets.all(4),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () {
              widget.onSelected.call(color);
              setState(() {
                selectedColor = color;
              });
            },
            child: Center(
              child: CircleAvatar(
                backgroundColor: Color(color),
              ),
            ),
          );
        }
      },
    );
  }
}
