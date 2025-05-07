import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/data/repository/settings/i_settings_repository.dart';
import 'package:roadsyouwalked_app/data/repository/settings/settings_repository.dart';
import 'dart:developer' as dev;

import 'package:roadsyouwalked_app/model/settings/app_settings.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final ISettingsRepository _settingsRepository = SettingsRepository();
  SettingsBloc() : super(SettingsInitial(settings: null)) {
    on<GetSettings>(onGetSettings);
    on<UpdateSettings>(onUpdateSettings);
    on<SaveSettings>(onSaveSettings);
  }

  Future<void> onGetSettings(
    GetSettings event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      final settings = await _settingsRepository.getSetting();
      emit(SettingsLoaded(settings: settings));
    } catch (e) {
      dev.log(e.toString());
    }
  }

  Future<void> onSaveSettings(
    SaveSettings event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      await _settingsRepository.saveSettings(state.settings!);
      emit(SettingsSavedSuccess(settings: state.settings));
    } catch (e) {
      dev.log(e.toString());
      emit(SettingsSavedFailed(settings: state.settings));
    }
  }

  Future<void> onUpdateSettings(UpdateSettings event, Emitter<SettingsState> emit) async {
    await _settingsRepository.saveSettings(event.settings);
    await onGetSettings(GetSettings(), emit);
  }
}
