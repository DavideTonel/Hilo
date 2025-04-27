import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';
import 'package:roadsyouwalked_app/ui/components/memory/memory_basic_widget.dart';
import 'package:roadsyouwalked_app/ui/components/memory/memory_with_media_widget.dart';

class MemoryWidget extends StatelessWidget{
  final Memory memory;

  const MemoryWidget(
    {
      super.key,
      required this.memory
    }
  );

  @override
  Widget build(BuildContext context) {
    if (memory.mediaList.isNotEmpty) {
      return MemoryWithMediaWidget(memory: memory);
    } else {
      return MemoryBasicWidget(memory: memory);
    }
  }
}
