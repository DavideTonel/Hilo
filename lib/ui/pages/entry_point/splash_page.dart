import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadsyouwalked_app/bloc/media/media_bloc.dart';
import 'package:roadsyouwalked_app/bloc/navigation/global/navigation_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MediaBloc, MediaState>(
      listener: (context, state) {
        switch (state) {
          case MediaPermissionGranted _:
            context.read<MediaBloc>().add(LoadPhotos());
            context.read<NavigationBloc>().add(NavigateToHome());
            break;
          case MediaPermissionDenied _:
            break;
          default:
        }
      },
      builder: (context, state) {
        return Center(child: Text("Splash Logo"));
      },
    );
  }
}
