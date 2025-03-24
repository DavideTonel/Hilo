import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:roadsyouwalked_app/bloc/media/media_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget body = Center(child: Text("Splash Logo"));
    return BlocConsumer<MediaBloc, MediaState>(
      listener: (context, state) {
        final GoRouter router = GoRouter.of(context);
        switch (state) {
          case MediaPermissionGranted _:
            context.read<MediaBloc>().add(LoadPhotos());
            router.go("/home");
            break;
          case MediaPermissionDenied _:
            body = Center(child: Text("Permission Denied"));
            break;
          default:
        }
      },
      builder: (context, state) {
        return body;
      },
    );
  }
}
