import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:roadsyouwalked_app/bloc/memory/new_memory/new_memory_bloc.dart';
import 'package:roadsyouwalked_app/bloc/evaluation_bloc/evaluation_bloc.dart';
import 'package:roadsyouwalked_app/bloc/position/position_bloc.dart';
import 'package:roadsyouwalked_app/bloc/user/user_bloc.dart';
import 'package:roadsyouwalked_app/ui/pages/memory/new_memory/new_memory_input_page.dart';
import 'package:roadsyouwalked_app/ui/pages/evaluation/evaluation_page.dart';

import 'dart:developer' as dev;

class NewMemoryPage extends StatefulWidget {
  const NewMemoryPage({super.key});

  @override
  NewMemoryPageState createState() => NewMemoryPageState();
}

class NewMemoryPageState extends State<NewMemoryPage> {
  final PageController _verticalController = PageController();

  @override
  Widget build(BuildContext context) {
    // TODO: make it better
    return MultiBlocProvider(
      providers: [
        // TODO: understand if initialize camera here is better
        BlocProvider(
          create: (context) {
            final creatorId = context.read<UserBloc>().state.user!.username;
            return NewMemoryBloc()..add(Initialize(creatorId: creatorId));
          },
        ),
        BlocProvider(
          // TODO: understand if wrapper is better
          create: (_) => EvaluationBloc()..add(GetDefaultEvaluationScale()),
        ),
        BlocProvider(
          create: (context) {
            return PositionBloc()..add(Init());
          },
        ),
      ],
      child: Builder(
        builder: (context) {
          final GoRouter router = GoRouter.of(context);
          return BlocListener<NewMemoryBloc, NewMemoryState>(
            listener: (context, state) {
              switch (state) {
                case NewMemorySaveFailure _:
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        state.errorMessage ?? "Error saving memory",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: const Color.fromARGB(255, 159, 23, 14),
                      duration: Duration(seconds: 3),
                    ),
                  );
                  break;
                case NewMemorySaveSuccess _:
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Memory saved successefully!",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: const Color.fromARGB(255, 2, 146, 22),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  break;
                default:
              }
            },
            child: PageView(
              scrollDirection: Axis.vertical,
              controller: _verticalController,
              children: [
                NewMemoryInputPage(
                  onSaveMedia: (localFile, remoteUri, mediaType) {
                    context.read<NewMemoryBloc>().add(
                      AddMedia(
                        localFile: localFile,
                        remoteUri: remoteUri,
                        mediaType: mediaType,
                      ),
                    );
                  },
                  onChangeDescription: (description) {
                    context.read<NewMemoryBloc>().add(
                      SetDescription(description: description),
                    );
                  },
                ),
                EvaluationPage(
                  onEvaluationCompleted: (evaluationResultData) {
                    context.read<NewMemoryBloc>().add(
                      AddMoodEvaluation(
                        evaluationResultData: evaluationResultData,
                      ),
                    );
                  },
                ),
                Scaffold(
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BlocConsumer<PositionBloc, PositionState>(
                        listener: (context, state) {
                          switch (state) {
                            case PositionLoaded _:
                              dev.log("Position loaded: ${state.position!.latitude}, ${state.position!.longitude}");
                              context.read<NewMemoryBloc>().add(AddPosition(
                                position: state.position!
                              ));
                              break;
                            default:
                          }
                        },
                        builder: (context, state) {
                          final String latitude = state.position?.latitude.toString() ?? "";
                          final String longitude = state.position?.longitude.toString() ?? "";
                          return MaterialButton(
                            onPressed: () => context.read<PositionBloc>().add(GetPosition()),
                            child: Text("lat: $latitude, lon: $longitude"),
                          );
                        },
                      ),
                      SizedBox(height: 100,),
                      MaterialButton(
                        onPressed:
                          () => context.read<NewMemoryBloc>().add(SaveMemory()),
                        child: Text("Save memory"),
                      ),
                    ]
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
