import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadsyouwalked_app/bloc/camera/camera_bloc.dart';
import 'package:roadsyouwalked_app/bloc/memory/new_memory/new_memory_bloc.dart';
import 'package:roadsyouwalked_app/bloc/evaluation_bloc/evaluation_bloc.dart';
import 'package:roadsyouwalked_app/bloc/position/position_bloc.dart';
import 'package:roadsyouwalked_app/bloc/user/user_bloc.dart';
import 'package:roadsyouwalked_app/ui/pages/memory/new_memory/new_memory_input_page.dart';
import 'package:roadsyouwalked_app/ui/pages/evaluation/evaluation_page.dart';
import 'package:roadsyouwalked_app/ui/pages/memory/new_memory/new_memoy_confirm_page.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
            return NewMemoryBloc()..add(InitNewMemory(creatorId: creatorId));
          },
        ),
        BlocProvider(create: (_) => CameraBloc()..add(InitCamera())),
        BlocProvider(
          create: (_) => EvaluationBloc()..add(GetDefaultEvaluationScale()),
        ),
        BlocProvider(
          create: (context) {
            return PositionBloc()..add(InitPosition());
          },
        ),
      ],
      child: Builder(
        builder: (context) {
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
            child: Stack(
              children: [
                PageView(
                  scrollDirection: Axis.vertical,
                  controller: _verticalController,
                  children: [
                    NewMemoryInputPage(
                      key: const PageStorageKey("new_memory_input_page"),
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
                      key: const PageStorageKey("evaluation_page"),
                      onEvaluationCompleted: (evaluationResultData) {
                        context.read<NewMemoryBloc>().add(
                          AddMoodEvaluation(
                            evaluationResultData: evaluationResultData,
                          ),
                        );
                      },
                    ),
                    NewMemoyConfirmPage(),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: SmoothPageIndicator(
                        controller: _verticalController,
                        count: 3,
                        axisDirection: Axis.horizontal,
                        effect: WormEffect(
                          dotHeight: 10,
                          dotWidth: 10,
                          spacing: 12,
                          activeDotColor: Theme.of(context).colorScheme.primary,
                          dotColor: Colors.black.withAlpha(100),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
