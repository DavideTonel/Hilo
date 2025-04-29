part of 'settings_bloc.dart';

@immutable
sealed class SettingsState {
  final AppSettings? settings;

  const SettingsState({required this.settings});
}

final class SettingsInitial extends SettingsState {
  const SettingsInitial({super.settings});
}

final class SettingsLoaded extends SettingsState {
  const SettingsLoaded({required super.settings});
}

final class SettingsSavedFailed extends SettingsState {
  const SettingsSavedFailed({required super.settings});
}

final class SettingsSavedSuccess extends SettingsState {
  const SettingsSavedSuccess({required super.settings});
}
