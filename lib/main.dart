import 'dart:convert';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_cloud_clone/components/components.dart';
import 'package:sound_cloud_clone/cubits/bottom_nav/cubit.dart';
import 'package:sound_cloud_clone/cubits/login&Register/cubit.dart';
import 'package:sound_cloud_clone/cubits/music_manager/cubit.dart';
import 'package:sound_cloud_clone/cubits/theme_manager/cubit.dart';
import 'package:sound_cloud_clone/cubits/theme_manager/states.dart';
import 'package:sound_cloud_clone/models/album_data.dart';
import 'package:sound_cloud_clone/screens/home_screen.dart';
import 'package:sound_cloud_clone/screens/login_screen.dart';
import 'package:sound_cloud_clone/screens/tracks_screen.dart';
import 'package:sound_cloud_clone/shared/network/remote/sound_api.dart';
import 'package:sound_cloud_clone/styles/theme_data.dart';

import 'cubits/music_playback/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => SoundCloudLoginAndRegCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => MusicManagerCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => BottomNavCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => ThemeManagerCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => MusicPlaybackCubit(),
          ),
        ],
        child: BlocConsumer<ThemeManagerCubit, ThemeManagerStates>(
          listener: (context, state) {},
          builder: (context, state) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: LightMode,
            darkTheme: DarkMode,
            themeMode: ThemeManagerCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            // home: splash(),
            // home: HomeScreen(),
            home: (AnimatedSplashScreen(
              centered: true,
              splashIconSize: 900,
              splash: splash(),
              nextScreen:
              LoginScreen(),
            )),
          ),
        ));
  }
}

Widget splash() {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepOrange,Colors.orange]
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(image: AssetImage('assets/images/soundcloud_Splash.png'),width: 260,),
        defaultText(text: 'SoundCloud',fontSize: 32,textColor: Colors.white,)
      ],
    ),
  );
  //Image.asset();
}
