import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadsyouwalked_app/bloc/memory/new_memory/new_memory_bloc.dart';
import 'package:roadsyouwalked_app/bloc/user/user_bloc.dart';
import 'package:roadsyouwalked_app/ui/pages/memory/new_memory/mood_evaluation_page.dart';
import 'package:roadsyouwalked_app/ui/pages/memory/new_memory/new_memory_input_page.dart';

class NewMemoryPage extends StatefulWidget {
  const NewMemoryPage({super.key});

  @override
  NewMemoryPageState createState() => NewMemoryPageState();
}

class NewMemoryPageState extends State<NewMemoryPage> {
  final PageController _verticalController = PageController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          final creatorId = context.read<UserBloc>().state.user!.username;
          return NewMemoryBloc()..add(Initialize(creatorId: creatorId));
        }),
      ],
      child: Builder(
        builder: (context) {
          return PageView(
            scrollDirection: Axis.vertical,
            controller: _verticalController,
            children: [
              NewMemoryInputPage(
                onSaveMedia: (localFile, remoteUri, mediaType) {
                  context.read<NewMemoryBloc>().add(AddMedia(localFile: localFile, remoteUri: remoteUri, mediaType: mediaType));
                },
                onChangeDescription: (description) {
                  context.read<NewMemoryBloc>().add(SetDescription(description: description));
                }
              ),
              MoodEvalutaionPage(),
              Scaffold(
                body: Center(
                  child: MaterialButton(
                    onPressed: () => context.read<NewMemoryBloc>().add(SaveMemory()),
                    child: Text("Save memory")
                  ),
                ),
              )
            ],
          );
        }
      ),
    );
  }
}
