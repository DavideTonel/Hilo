import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';
import 'package:roadsyouwalked_app/ui/components/memory/memory_card_basic_widget.dart';
import 'package:roadsyouwalked_app/ui/components/memory/memory_card_with_media_widget.dart';

class MemoryCardWidget extends StatelessWidget{
  final Memory memory;

  const MemoryCardWidget(
    {
      super.key,
      required this.memory
    }
  );

  @override
  Widget build(BuildContext context) {
    if (memory.mediaList.isNotEmpty) {
      return MemoryCardWithMediaWidget(memory: memory);
    } else {
      return MemoryCardBasicWidget(memory: memory);
    }
  }
}
