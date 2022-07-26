import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_cloud_clone/components/components.dart';
import 'package:sound_cloud_clone/cubits/theme_manager/cubit.dart';
import 'package:sound_cloud_clone/cubits/theme_manager/states.dart';
import 'package:sound_cloud_clone/screens/playlists_screen.dart';
import 'package:sound_cloud_clone/screens/profile_screen.dart';

import 'login_screen.dart';

class SettingsModel {
  IconData? iconData;
  Widget? screen;
  String? text;
  bool? signOut;
  bool? darkMode;

  SettingsModel({
    required this.darkMode,
    required this.text,
    required this.signOut,
    required this.iconData,
    this.screen,
  });
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<SettingsModel> settingsList = [
      SettingsModel(
          iconData: Icons.person,
          text: "Profile",
          darkMode: false,
          screen: ProfileScreen(),
          signOut: false),
      SettingsModel(
          iconData: Icons.dark_mode_outlined,
          text: "Appearance",
          darkMode: true,
          signOut: false),
      SettingsModel(
          iconData: Icons.logout,
          text: "SignOut",
          darkMode: false,
          screen: LoginScreen(),
          signOut: true),
    ];

    return BlocConsumer<ThemeManagerCubit, ThemeManagerStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: myAppBar(context, title: 'Settings'),
        body: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: ListView.separated(
              itemBuilder: (context, index) =>
                  buildSettingsItem(settingsList[index], context),
              separatorBuilder: (context, index) => SizedBox(
                    height: 10,
                  ),
              itemCount: settingsList.length),
        ),
      ),
    );
  }
}
