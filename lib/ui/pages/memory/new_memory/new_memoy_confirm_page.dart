import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadsyouwalked_app/bloc/memory/new_memory/new_memory_bloc.dart';
import 'package:roadsyouwalked_app/bloc/position/position_bloc.dart';
import 'package:roadsyouwalked_app/ui/constants/app_spacing.dart';
import 'package:roadsyouwalked_app/ui/pages/map/position_in_map_page.dart';

class NewMemoyConfirmPage extends StatelessWidget {
  const NewMemoyConfirmPage({super.key});

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
        final isPositionActive = state is PositionLoaded;
        final isLoading = state is PositionLoading;

        return Scaffold(
          body: Stack(
            children: [
              if (state.position != null)
                Positioned.fill(
                  child: PositionInMapPage(
                    latitude: state.position!.latitude,
                    longitude: state.position!.longitude,
                    timestamp: DateTime.now(),
                    animate: true,
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
                      onPressed: isLoading
                          ? null
                          : () {
                              if (!isPositionActive) {
                                context.read<PositionBloc>().add(InitPosition());
                              } else {
                                if (state.position != null) {
                                  context.read<PositionBloc>().add(ClearPosition());
                                } else {
                                  context.read<PositionBloc>().add(GetPosition());
                                }
                              }
                            },
                      child: Text(
                        isLoading
                            ? "Getting position..."
                            : isPositionActive
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
              if (isLoading)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withAlpha(150),
                    child: const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(color: Colors.white),
                          SizedBox(height: 12),
                          Text(
                            "Getting your position...",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
