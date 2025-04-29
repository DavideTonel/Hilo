import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadsyouwalked_app/bloc/memory/new_memory/new_memory_bloc.dart';
import 'package:roadsyouwalked_app/bloc/position/position_bloc.dart';
import 'package:roadsyouwalked_app/ui/constants/app_spacing.dart';
import 'package:roadsyouwalked_app/ui/pages/map/position_in_map_page.dart';
import 'dart:developer' as dev;

class NewMemoyConfirmPage extends StatefulWidget {
  const NewMemoyConfirmPage({super.key});

  @override
  State<NewMemoyConfirmPage> createState() => _NewMemoyConfirmPageState();
}

class _NewMemoyConfirmPageState extends State<NewMemoyConfirmPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PositionBloc, PositionState>(
      listener: (context, state) {
        if (state is PositionLoaded) {
          if (state.position != null) {
            context.read<NewMemoryBloc>().add(
              AddPosition(position: state.position!),
            );
          } else {
            context.read<NewMemoryBloc>().add(RemovePosition());
          }
        }
      },
      builder: (context, state) {
        bool isPositionActive = state is PositionLoaded;

        return Scaffold(
          body: Stack(
            children: [
              if (state.position != null)
                Positioned.fill(
                  child: PositionInMapPage(
                    latitude: state.position!.latitude,
                    longitude: state.position!.longitude,
                    timestamp: DateTime.now(),
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
                        if (!isPositionActive) {
                          context.read<PositionBloc>().add(InitPosition());
                        } else {
                          if (state.position != null) {
                            dev.log("UI Clear position");
                            context.read<PositionBloc>().add(ClearPosition());
                          } else {
                            dev.log("UI Get position");
                            context.read<PositionBloc>().add(GetPosition());
                          }
                        }
                      },
                      child: Text(
                        isPositionActive
                            ? (state.position != null
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
                      onPressed: () {
                        context.read<NewMemoryBloc>().add(SaveMemory());
                      },
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
