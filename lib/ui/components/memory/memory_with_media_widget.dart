import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';
import 'package:roadsyouwalked_app/ui/components/footer/date_footer_widget.dart';
import 'package:roadsyouwalked_app/ui/components/interaction/like_button_widget.dart';
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

    return Container(
      color: Colors.blueGrey,
      child: Column(
        children: [
          ImageWidget(imagePath: widget.memory.mediaList[mediaIndex].reference),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LikeButtonWidget(onPressed: () {}),
              ],
            )
          ),
          if (widget.memory.data.core.description != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacingConstants.md),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(widget.memory.data.core.description!),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: AppSpacingConstants.md,
              top: AppSpacingConstants.xs,
              bottom: AppSpacingConstants.xs
            ),
            child: DateFooterWidget(date: date)
          ),
        ],
      ),
    );
  }
}
