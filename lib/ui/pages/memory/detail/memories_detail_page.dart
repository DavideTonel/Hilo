import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadsyouwalked_app/bloc/memory/memories_detail_bloc/memories_detail_bloc.dart';
import 'package:roadsyouwalked_app/ui/components/memory/memory_widget.dart';

class MemoriesDetailPage extends StatelessWidget {
  const MemoriesDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemoriesDetailBloc, MemoriesDetailState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
          ),
          body: ListView.builder(
            itemCount: state.memories.length,
            itemBuilder: (context, i) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: MemoryWidget(
                memory: state.memories[i],
              ),
            ),
          ),
        );
      },
    );
  }
}
