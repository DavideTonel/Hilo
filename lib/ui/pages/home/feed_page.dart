import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadsyouwalked_app/bloc/memory/memory_bloc.dart';
import 'package:roadsyouwalked_app/ui/components/memory/memory_card.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MemoryBloc, MemoryState>(
      listener: (context, state) {
        
      },
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.memories.length,
          itemBuilder: (context, i) => Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: MemoryCard(
              memory: state.memories[i],
            ),
          ),
        );
      },
    );
  }
}
