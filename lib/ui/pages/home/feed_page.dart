import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadsyouwalked_app/bloc/private_storage/private_storage_bloc.dart';
import 'package:roadsyouwalked_app/ui/components/memory_card.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PrivateStorageBloc, PrivateStorageState>(
      listener: (context, state) {
        
      },
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.images.length,
          itemBuilder: (context, i) => Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: MemoryCard(
              photo: state.images[i],
            ),
          ),
        );
      },
    );
  }
}
