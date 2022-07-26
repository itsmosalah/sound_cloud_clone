import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_cloud_clone/components/components.dart';
import 'package:sound_cloud_clone/cubits/bottom_nav/cubit.dart';
import 'package:sound_cloud_clone/cubits/bottom_nav/states.dart';
import 'package:sound_cloud_clone/models/music_player.dart';
import 'package:sound_cloud_clone/screens/playback_screen.dart';
import 'package:sound_cloud_clone/shared/network/remote/sound_api.dart';

import '../cubits/login&Register/cubit.dart';
import '../cubits/login&Register/states.dart';
import '../cubits/music_manager/cubit.dart';
import '../cubits/music_manager/states.dart';
import '../models/track_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = BottomNavCubit.get(context);
    return BlocConsumer<BottomNavCubit, BottomNavStates>(
      listener: (context, state) {},
      builder: (context, state) {

        return Scaffold(
          body: cubit.bottomNavScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (int index) {
              cubit.changeBottomNavScreen(index);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.format_list_bulleted_sharp),
                label: "Playlists"
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "Settings"),
            ],
          ),
        );
      },
    );
  }
}
