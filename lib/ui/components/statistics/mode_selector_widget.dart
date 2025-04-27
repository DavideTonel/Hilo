import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/model/memory/memory_order_type.dart';

class ModeSelectorWidget extends StatelessWidget {
  final List<MemoryOrderType> modes;
  final MemoryOrderType selectedMode;
  final void Function(MemoryOrderType mode) onSelect;

  const ModeSelectorWidget({
    super.key,
    required this.modes,
    required this.selectedMode,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final List<ChoiceChip> chips =
        modes
            .map(
              (mode) => ChoiceChip(
                labelPadding: const EdgeInsets.symmetric(horizontal: 0),
                showCheckmark: false,
                label: Text(
                  mode.value,
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                ),
                selected: mode == selectedMode,
                onSelected: (value) {
                  onSelect(mode);
                },
              ),
            )
            .toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [...chips],
    );
  }
}
