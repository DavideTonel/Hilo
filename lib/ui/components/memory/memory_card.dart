import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';
import 'package:roadsyouwalked_app/ui/components/media/image/local_image_widget.dart';

class MemoryCard extends StatelessWidget{
  final Memory memory;

  const MemoryCard(
    {
      super.key,
      required this.memory
    }
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(   // TODO make background color
      child: Column(
        children: [
          LocalImageWidget(
            path: memory.mediaList.first.reference,
            width: size.width,
            height: size.height * 0.50,
          ),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(memory.data.core.description ?? ""),  // TODO remove if no description is present
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "19/12/2000"
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
