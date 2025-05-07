import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:roadsyouwalked_app/data/repository/evaluation/evaluation_repository.dart';
import 'package:roadsyouwalked_app/data/repository/evaluation/i_evaluation_repository.dart';
import 'package:roadsyouwalked_app/model/evaluation/export/user_evaluation.dart';
import 'dart:developer' as dev;

part 'export_event.dart';
part 'export_state.dart';

class ExportBloc extends Bloc<ExportEvent, ExportState> {
  final IEvaluationRepository _evaluationRepository = EvaluationRepository();

  ExportBloc() : super(ExportInitial()) {
    on<Export>(onExport);
  }

  Future<void> onExport(
    Export event,
    Emitter<ExportState> emit
  ) async {
    try {
      emit(ExportingEvaluations());
      final List<UserEvaluation> evaluations = await _evaluationRepository.getUserEvaluationsLastNDays(
        event.userId,
        event.lastNDays
      );
      if (evaluations.isEmpty) {
        emit(ExportFailed(message: "There are no evaluations to export"));
      } else {
        final List<Map<String, dynamic>> jsonList = evaluations
          .map((eval) => eval.toJson()).toList();
        final jsonString = const JsonEncoder.withIndent("  ").convert(jsonList);
        dev.log(jsonString);
        
        final bytes = Uint8List.fromList(utf8.encode(jsonString));
        final String resPath = await FileSaver.instance.saveFile(
          name: "${event.userId}__exp__${DateFormat("dd_mm").format(evaluations.last.timestamp)}",
          bytes: bytes,
          ext: "json",
          mimeType: MimeType.json
        );
        emit(EvaluationsExported(message: "Export done in $resPath"));
      }
    } catch (e) {
      emit(ExportFailed(message: "Export failed"));
    }
  }
}
