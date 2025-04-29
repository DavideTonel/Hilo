part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent {}

final class GetSettings extends SettingsEvent {}

final class UpdateSettings extends SettingsEvent {
  final AppSettings settings;

  UpdateSettings({required this.settings});
}

final class SaveSettings extends SettingsEvent {}
