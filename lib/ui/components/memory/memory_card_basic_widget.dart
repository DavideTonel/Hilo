import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';

class MemoryCardBasicWidget extends StatelessWidget {
  final Memory memory;

  const MemoryCardBasicWidget({super.key, required this.memory});

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('dd/MM/yyyy   HH:mm').format(DateTime.parse(memory.data.core.timestamp));
    return Container(   // TODO make background color
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite
                  )
                ),
              ],
            ),
          ),
          if (memory.data.core.description != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(memory.data.core.description!),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(date),
              ],
            ),
          )
        ],
      ),
    );
  }
}
