// @author Hoàng Phi Đại
// @version
// @link ff3105.github.io
// @created  $
// @Usage

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/settings/settings_bloc.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          "Setting",
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is SettingsSuccess) {
            return SettingsList(
              backgroundColor: Theme.of(context).backgroundColor,
              sections: [
                SettingsSection(
                  title: "General",
                  tiles: [
                    SettingsTile.switchTile(
                      leading: Icon(Icons.brightness_2),
                      title: "Dark mode",
                      switchValue: state.setting.darkMode,
                      onToggle: (value) {
                        context.bloc<SettingsBloc>().add(SettingChange(
                            state.setting.copyWith(darkMode: value)));
                      },
                    ),
                  ],
                )
              ],
            );
          } else {
            return const Text("data");
          }
        },
      ),
    );
  }
}
