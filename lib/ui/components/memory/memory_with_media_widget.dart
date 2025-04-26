import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';
import 'package:roadsyouwalked_app/ui/components/footer/date_footer_widget.dart';
import 'package:roadsyouwalked_app/ui/components/media/image/image_widget.dart';
import 'package:roadsyouwalked_app/ui/constants/app_spacing.dart';

class MemoryWithMediaWidget extends StatefulWidget {
  final Memory memory;

  const MemoryWithMediaWidget({super.key, required this.memory});

  @override
  State<StatefulWidget> createState() => _MemoryWithMediaWidgetState();
}

class _MemoryWithMediaWidgetState extends State<MemoryWithMediaWidget> {
  final int mediaIndex = 0;

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('dd/MM/yyyy   HH:mm').format(
      DateTime.parse(widget.memory.data.core.timestamp),
    );

    return Material(
      elevation: 1.0,
      type: MaterialType.card,
      color: Theme.of(context).cardColor,
      child: InkWell(
        onTap: null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageWidget(imagePath: widget.memory.mediaList[mediaIndex].reference),

            if (widget.memory.data.core.description != null) ...[
              Padding(
                padding: const EdgeInsets.only(
                  left: AppSpacingConstants.sm,
                  right: AppSpacingConstants.sm,
                  top: AppSpacingConstants.xs,
                ),
                child: Text(widget.memory.data.core.description!),
              ),
            ],

            Padding(
              padding: const EdgeInsets.only(
                left: AppSpacingConstants.sm,
                top: AppSpacingConstants.xs,
                bottom: AppSpacingConstants.xxs,
              ),
              child: DateFooterWidget(date: date),
            ),
          ],
        ),
      ),
    );
  }
}
