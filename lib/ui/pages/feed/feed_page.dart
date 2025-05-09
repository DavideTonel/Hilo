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
        return ListView.separated(  
          padding: EdgeInsets.only(bottom: 150),
          itemCount: state.memories.length,
          itemBuilder: (context, i) => MemoryWidget(
            memory: state.memories[i],
          ),
          separatorBuilder: (context, index) => const SizedBox(height: 20.0),
        );
      },
    );
  }
}
