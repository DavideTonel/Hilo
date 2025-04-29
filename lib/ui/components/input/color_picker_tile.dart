import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerTile extends StatelessWidget {
  final Color currentColor;
  final void Function(Color selectedColor) onColorSelected;

  const ColorPickerTile({
    super.key,
    required this.currentColor,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.color_lens),
      title: const Text("Seed Color"),
      trailing: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: currentColor,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black.withAlpha(100)),
          ),
        ),
      ),
      onTap: () {
        Color selectedColor = currentColor;
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Choose a color'),
              content: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: selectedColor,
                  onColorChanged: (color) {
                    selectedColor = color;
                  },
                  enableAlpha: false,
                  labelTypes: [],
                  pickerAreaHeightPercent: 0.8,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    onColorSelected(selectedColor);
                  },
                  child: const Text('Select'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
