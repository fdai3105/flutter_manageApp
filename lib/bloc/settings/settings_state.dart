part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();
}

class SettingsInitial extends SettingsState {
  @override
  List<Object> get props => [];
}

class SettingsProgress extends SettingsState {
  @override
  List<Object> get props => [];
}

class SettingsSuccess extends SettingsState {
  final Setting setting;

  const SettingsSuccess({this.setting});

  @override
  List<Object> get props => [setting];
}
