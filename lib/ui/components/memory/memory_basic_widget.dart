import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';
import 'package:roadsyouwalked_app/ui/components/footer/date_footer_widget.dart';
import 'package:roadsyouwalked_app/ui/components/interaction/like_button_widget.dart';
import 'package:roadsyouwalked_app/ui/constants/app_spacing.dart';

class MemoryBasicWidget extends StatelessWidget {
  final Memory memory;

  const MemoryBasicWidget({super.key, required this.memory});

  @override
  Widget build(BuildContext context) {
    final date = DateFormat(
      'dd/MM/yyyy   HH:mm',
    ).format(DateTime.parse(memory.data.core.timestamp));
    return Container(
      color: Colors.blueGrey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacingConstants.xs),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppSpacingConstants.sm,
                    right: AppSpacingConstants.sm
                  ),
                  child: LikeButtonWidget(
                    onPressed: () {},
                  ),
                ),
                Row(
                  children: [
                    Text(
                      memory.data.core.description!,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
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
