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
    final date = DateFormat(
      'dd/MM/yyyy   HH:mm',
    ).format(DateTime.parse(widget.memory.data.core.timestamp));

    return Material(
      elevation: 0,
      type: MaterialType.card,
      color: Theme.of(context).cardColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.image_outlined,
                  size: 24,
                  weight: FontWeight.w500.value.toDouble(),
                ),
                const SizedBox(width: 8),
                Text(
                  widget.memory.data.core.creatorId,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: null,
            child: ImageWidget(
              imagePath: widget.memory.mediaList[mediaIndex].reference,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: [
                if (widget.memory.data.core.description != null) ...[
                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.memory.data.core.description!,
                        style: const TextStyle(fontSize: 14),
                        softWrap: true,
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 2),
                DateFooterWidget(date: date),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
