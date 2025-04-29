import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';
import 'package:roadsyouwalked_app/ui/components/footer/date_footer_widget.dart';
import 'package:roadsyouwalked_app/ui/components/memory/basic/memory_description_widget.dart';
import 'package:roadsyouwalked_app/ui/components/memory/basic/memory_header_widget.dart';
import 'package:roadsyouwalked_app/ui/components/memory/basic/memory_map_widget.dart';
import 'package:roadsyouwalked_app/ui/constants/app_spacing.dart';

class MemoryBasicWidget extends StatelessWidget {
  final Memory memory;

  const MemoryBasicWidget({super.key, required this.memory});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final datetime = DateTime.parse(memory.data.core.timestamp);

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacingConstants.xs),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MemoryHeaderWidget(
              iconData: Icons.text_snippet_outlined,
              dateTime: datetime,
            ),
            if (memory.data.position != null)
              MemoryMapWidget(
                width: size.width,
                height: 200,
                position: memory.data.position!,
                dateTime: datetime,
                zoom: 17,
                pitch: 70.0,
              ),
            const SizedBox(height: 2),
            MemoryDescriptionWidget(
              description: memory.data.core.description!,
            ),
            const SizedBox(height: 2),
            DateFooterWidget(
              dateTime: datetime,
              color: Theme.of(
                context,
              ).colorScheme.onPrimaryContainer.withAlpha(100),
            ),
          ],
        ),
      ),
    );
  }
}
