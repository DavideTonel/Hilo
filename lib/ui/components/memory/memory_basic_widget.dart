import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';
import 'package:roadsyouwalked_app/ui/components/footer/date_footer_widget.dart';
import 'package:roadsyouwalked_app/ui/constants/app_spacing.dart';

class MemoryBasicWidget extends StatelessWidget {
  final Memory memory;

  const MemoryBasicWidget({super.key, required this.memory});

  @override
  Widget build(BuildContext context) {
    final fullDate = DateFormat('dd/MM/yyyy   HH:mm')
        .format(DateTime.parse(memory.data.core.timestamp));
    final headerDate = DateFormat('dd/MM')
        .format(DateTime.parse(memory.data.core.timestamp));

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacingConstants.xs),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.text_snippet_outlined,
                  size: 24,
                  weight: FontWeight.w500.value.toDouble(),
                ),
                SizedBox(width: 8),
                Text(
                  headerDate,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              memory.data.core.description!,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              softWrap: true,
            ),
            const SizedBox(height: 2),
            DateFooterWidget(
              date: fullDate,
              color: Theme.of(context).colorScheme.onPrimaryContainer.withAlpha(100),
            ),
          ],
        ),
      ),
    );
  }
}
