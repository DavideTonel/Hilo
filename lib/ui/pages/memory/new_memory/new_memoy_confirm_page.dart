import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadsyouwalked_app/bloc/memory/new_memory/new_memory_bloc.dart';
import 'package:roadsyouwalked_app/bloc/position/position_bloc.dart';
import 'package:roadsyouwalked_app/ui/constants/app_spacing.dart';
import 'package:roadsyouwalked_app/ui/pages/map/my_map_widget.dart';

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
          context.read<NewMemoryBloc>().add(AddPosition(position: state.position!));
          Future.delayed(Duration(milliseconds: 100), () {
            setState(() => _showMap = true);
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              if (state is PositionLoaded)
                AnimatedOpacity(
                  opacity: _showMap ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 3000),
                  curve: Curves.easeInOut,
                  child: Positioned.fill(
                    child: PositionInMapWidget(
                      latitude: state.position!.latitude,
                      longitude: state.position!.longitude,
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
                      onPressed: () => context.read<PositionBloc>().add(GetPosition()),
                      child: const Text("Get position"),
                    ),
                    const SizedBox(height: AppSpacingConstants.xl),
                    FilledButton(
                      style: FilledButton.styleFrom(
                        shadowColor: Colors.black,
                        elevation: 2,
                      ),
                      onPressed: () => context.read<NewMemoryBloc>().add(SaveMemory()),
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
