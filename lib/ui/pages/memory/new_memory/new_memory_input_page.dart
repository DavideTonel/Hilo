import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadsyouwalked_app/bloc/camera/camera_bloc.dart';
import 'package:roadsyouwalked_app/model/media/media_type.dart';
import 'package:roadsyouwalked_app/ui/pages/camera/camera_page.dart';
import 'package:roadsyouwalked_app/ui/pages/memory/new_memory/new_memory_audio_page.dart';
import 'package:roadsyouwalked_app/ui/pages/memory/new_memory/new_memory_text_page.dart';

class NewMemoryInputPage extends StatefulWidget {
  final void Function(File? localFile, String? remoteUri, MediaType mediaType) onSaveMedia;

  const NewMemoryInputPage({super.key, required this.onSaveMedia});

  @override
  NewMemoryInputPageState createState() => NewMemoryInputPageState();
}

class NewMemoryInputPageState extends State<NewMemoryInputPage> {
  final PageController _horizontalController = PageController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CameraBloc()..add(InitializeCamera())),
      ],
      child: PageView(
        controller: _horizontalController,
        scrollDirection: Axis.horizontal,
        children: [
          CameraPage(
            onSaveMedia: widget.onSaveMedia,
          ),
          NewMemoryTextPage(),
          NewMemoryAudioPage()
        ],
      ),
    );
  }
}
