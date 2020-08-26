part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class SettingStarted extends SettingsEvent {
  @override
  List<Object> get props => [];
}

class SettingChange extends SettingsEvent {
  final Setting setting;

  const SettingChange(this.setting);

  @override
  List<Object> get props => [setting];
}
