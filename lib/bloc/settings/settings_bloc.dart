import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../utils/utils.dart';
import '../../model/setting.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial());

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {
    if (event is SettingStarted) {
      yield* _mapSettingInitialToState();
    } else if (event is SettingChange) {
      yield* _mapSettingChangeToState(event);
    }
  }

  Stream<SettingsState> _mapSettingInitialToState() async* {
    final setting = await SharePref().getDarkMode();
    yield SettingsSuccess(setting: Setting(darkMode: setting ?? false));
  }

  Stream<SettingsState> _mapSettingChangeToState(SettingChange event) async* {
    await SharePref().setDarkMode(darkMode:event.setting.darkMode);
    yield SettingsSuccess(setting: event.setting);
  }
}
