import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/ui/components/memory_card.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final temp = List.generate(10, (i) => i);

    return ListView.builder(
      itemCount: temp.length,
      prototypeItem: MemoryCard(),
      itemBuilder: (context, i) => MemoryCard()
    );
  }
}
