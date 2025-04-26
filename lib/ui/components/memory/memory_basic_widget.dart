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
    final date = DateFormat(
      'dd/MM/yyyy   HH:mm',
    ).format(DateTime.parse(memory.data.core.timestamp));
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer.withAlpha(120),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: AppSpacingConstants.xs,
              left: AppSpacingConstants.sm,
              right: AppSpacingConstants.sm,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      memory.data.core.description!,
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.onPrimaryContainer.withAlpha(180),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: AppSpacingConstants.sm,
              top: AppSpacingConstants.xs,
              bottom: AppSpacingConstants.xxs,
            ),
            child: DateFooterWidget(date: date, color: Theme.of(context).colorScheme.onPrimaryContainer.withAlpha(100)),
          ),
        ],
      ),
    );
  }
}
