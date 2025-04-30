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

    return Material(
      color: Colors.transparent,
      elevation: 0,
      type: MaterialType.card,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 5.0
            ),
            child: MemoryHeaderWidget(
              iconData: Icons.text_snippet_outlined,
              dateTime: datetime,
            ),
          ),
          if (memory.data.position != null)
            MemoryMapWidget(
              width: size.width,
              height: 200,
              position: memory.data.position!,
              dateTime: datetime,
              zoom: 17,
              pitch: 0.0,
            ),
          Padding(
            padding: EdgeInsets.only(
              left: 12.0,
              right: 12.0,
              top: memory.data.position != null ? 4.0 : 0.0,
              bottom: 0.0
            ),
            child: MemoryDescriptionWidget(
              description: memory.data.core.description!,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
            ),
            child: DateFooterWidget(
              dateTime: datetime,
              color: Theme.of(
                context,
              ).colorScheme.onPrimaryContainer.withAlpha(100),
            ),
          ),
        ],
      ),
    );
  }
}
