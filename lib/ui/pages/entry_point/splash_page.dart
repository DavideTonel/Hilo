import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:roadsyouwalked_app/bloc/media/media_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MediaBloc, MediaState>(
      listener: (context, state) {
        final GoRouter router = GoRouter.of(context);
        switch (state) {
          case MediaPermissionGranted _:
            context.read<MediaBloc>().add(LoadPhotos());
            router.go("/home");
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
