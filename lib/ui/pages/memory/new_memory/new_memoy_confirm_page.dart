import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadsyouwalked_app/bloc/memory/new_memory/new_memory_bloc.dart';
import 'package:roadsyouwalked_app/bloc/position/position_bloc.dart';
import 'package:roadsyouwalked_app/ui/constants/app_spacing.dart';
import 'package:roadsyouwalked_app/ui/pages/map/position_in_map_widget.dart';

class NewMemoyConfirmPage extends StatefulWidget {
  const NewMemoyConfirmPage({super.key});

  @override
  State<NewMemoyConfirmPage> createState() => _NewMemoyConfirmPageState();
}

class _NewMemoyConfirmPageState extends State<NewMemoyConfirmPage> {
  bool _showMap = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PositionBloc, PositionState>(
      listener: (context, state) {
        if (state is PositionLoaded) {
          context.read<NewMemoryBloc>().add(
            AddPosition(position: state.position!),
          );
          Future.delayed(Duration(milliseconds: 100), () {
            setState(() => _showMap = true);
          });
        } else if (state is PositionGranted) {
          context.read<NewMemoryBloc>().add(
            RemovePosition(),
          );
          Future.delayed(Duration(milliseconds: 100), () {
            setState(() => _showMap = true);
          });
        }
      },
      builder: (context, state) {
        bool isPositionGranted =
            state is PositionLoaded || state is PositionGranted;
        bool isPositionLoaded = state is PositionLoaded;
        return Scaffold(
          body: Stack(
            children: [
              if (state.position !=  null)
                AnimatedOpacity(
                  opacity: _showMap ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 2200),
                  curve: Curves.easeInOut,
                  child: Positioned.fill(
                    child: PositionInMapWidget(
                      latitude: state.position!.latitude,
                      longitude: state.position!.longitude,
                      timestamp: DateTime.now(),
                    ),
                  ),
                ),

              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FilledButton(
                      style: FilledButton.styleFrom(
                        shadowColor: Colors.black,
                        elevation: 2,
                      ),
                      onPressed: () {
                        if (!isPositionGranted) {
                          context.read<PositionBloc>().add(InitPosition());
                        } else {
                          if (isPositionLoaded) {
                            context.read<PositionBloc>().add(ClearPosition());
                          } else {
                            context.read<PositionBloc>().add(GetPosition());
                          }
                        }
                      },
                      child: Text(
                        isPositionGranted
                            ? (isPositionLoaded
                                ? "Remove position"
                                : "Add position")
                            : "Request position",
                      ),
                    ),
                    const SizedBox(height: AppSpacingConstants.xl),
                    FilledButton(
                      style: FilledButton.styleFrom(
                        shadowColor: Colors.black,
                        elevation: 2,
                      ),
                      onPressed:
                          () => context.read<NewMemoryBloc>().add(SaveMemory()),
                      child: const Text("Save memory"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
