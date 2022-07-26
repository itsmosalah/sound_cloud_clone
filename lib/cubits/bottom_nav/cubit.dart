import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_cloud_clone/cubits/bottom_nav/states.dart';
import 'package:sound_cloud_clone/screens/playlists_screen.dart';
import 'package:sound_cloud_clone/screens/settings_screen.dart';
import 'package:sound_cloud_clone/screens/tracks_screen.dart';

class BottomNavCubit extends Cubit<BottomNavStates>
{
  BottomNavCubit():super(BottomNavInitialState());
  static BottomNavCubit get(context)=>BlocProvider.of(context);

  int currentIndex = 0;
  void changeBottomNavScreen(int index)
  {
    currentIndex = index;
    emit(BottomNavSuccessState());
  }

  List<Widget> bottomNavScreens=
  [
    TracksScreen(),
    PlayListsScreen(),
    SettingsScreen()
  ];

}