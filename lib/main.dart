import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_cloud_clone/components/components.dart';
import 'package:sound_cloud_clone/cubits/bottom_nav/cubit.dart';
import 'package:sound_cloud_clone/cubits/login&Register/cubit.dart';
import 'package:sound_cloud_clone/cubits/music_manager/cubit.dart';
import 'package:sound_cloud_clone/cubits/theme_manager/cubit.dart';
import 'package:sound_cloud_clone/cubits/theme_manager/states.dart';
import 'package:sound_cloud_clone/screens/login_screen.dart';
import 'package:sound_cloud_clone/styles/theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // to delete Collection

  // var collection = FirebaseFirestore.instance.collection('users');
  // var snapshots = await collection.get();
  // for (var doc in snapshots.docs) {
  //   await doc.reference.delete();
  // }

  runApp(const MyApp());

  /*String responseGetTrack = "{\"tracks\":[{\"album\":{\"album_type\":\"album\",\"artists\":[{\"external_urls\":{\"spotify\":\"https://open.spotify.com/artist/2zwHaEmXxX6DTv4i8ajNCM\"},\"id\":\"2zwHaEmXxX6DTv4i8ajNCM\",\"name\":\"KrisAllen\",\"type\":\"artist\",\"uri\":\"spotify:artist:2zwHaEmXxX6DTv4i8ajNCM\"}],\"external_urls\":{\"spotify\":\"https://open.spotify.com/album/4K3AXbUoyTVE4A6wV50cmB\"},\"id\":\"4K3AXbUoyTVE4A6wV50cmB\",\"images\":[{\"height\":640,\"url\":\"https://i.scdn.co/image/ab67616d0000b2735f3afe4cafb7a274497341b3\",\"width\":640},{\"height\":300,\"url\":\"https://i.scdn.co/image/ab67616d00001e025f3afe4cafb7a274497341b3\",\"width\":300},{\"height\":64,\"url\":\"https://i.scdn.co/image/ab67616d000048515f3afe4cafb7a274497341b3\",\"width\":64}],\"name\":\"Horizons\",\"release_date\":\"2014-08-12\",\"release_date_precision\":\"day\",\"total_tracks\":10,\"type\":\"album\",\"uri\":\"spotify:album:4K3AXbUoyTVE4A6wV50cmB\"},\"artists\":[{\"external_urls\":{\"spotify\":\"https://open.spotify.com/artist/2zwHaEmXxX6DTv4i8ajNCM\"},\"id\":\"2zwHaEmXxX6DTv4i8ajNCM\",\"name\":\"KrisAllen\",\"type\":\"artist\",\"uri\":\"spotify:artist:2zwHaEmXxX6DTv4i8ajNCM\"}],\"disc_number\":1,\"duration_ms\":198386,\"explicit\":false,\"external_ids\":{\"isrc\":\"QMF921450124\"},\"external_urls\":{\"spotify\":\"https://open.spotify.com/track/3nBmy2hAqIDmMOD0VZGB7I\"},\"id\":\"3nBmy2hAqIDmMOD0VZGB7I\",\"is_local\":false,\"is_playable\":true,\"name\":\"Lost\",\"popularity\":45,\"preview_url\":\"https://p.scdn.co/mp3-preview/6574de68d560b54a86d76b56ea5a414241627106?cid=f6a40776580943a7bc5173125a1e8832\",\"track_number\":5,\"type\":\"track\",\"uri\":\"spotify:track:3nBmy2hAqIDmMOD0VZGB7I\"}]}";
  final data = await json.decode(responseGetTrack);

  TrackData x = TrackData.fromJson(data);

  MusicPlayer mp = MusicPlayer();
  mp.setUrlSrc(x.previewURL);
  mp.play();*/
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
            create: (BuildContext context) => SoundCloudMusicManagerCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => BottomNavCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => ThemeManagerCubit(),
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
        defaultText(text: 'SoundCloud',fontsize: 32,textColor: Colors.white,)
      ],
    ),
  );
  //Image.asset();
}
