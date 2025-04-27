import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadsyouwalked_app/bloc/memory/memory_bloc.dart';
import 'package:roadsyouwalked_app/ui/components/memory/memory_widget.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemoryBloc, MemoryState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.memories.length,
          itemBuilder: (context, i) => Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: MemoryWidget(
              memory: state.memories[i],
            ),
          ),
        );
      },
    );
  }
}
