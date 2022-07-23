import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sound_cloud_clone/cubits/login&Register/cubit.dart';
import 'package:sound_cloud_clone/cubits/theme_manager/cubit.dart';
import '../components/constants.dart';
import '../cubits/music_manager/cubit.dart';
import '../cubits/music_manager/states.dart';

class PlaybackScreen extends StatefulWidget {
  const PlaybackScreen({Key? key}) : super(key: key);

  @override
  State<PlaybackScreen> createState() => _PlaybackScreenState();
}

class _PlaybackScreenState extends State<PlaybackScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var cubit = SoundCloudMusicManagerCubit.get(context);

    //this should be called once, loading the playlist into a cubit for accessing
    cubit.loadPlayLists();
    var userCubit = SoundCloudLoginAndRegCubit();
    if (!cubit.stillPlaying) {
      cubit.togglePlayer();
    }
    cubit.stillPlaying = false;
    return BlocConsumer<SoundCloudMusicManagerCubit,
        SoundCloudMusicManagerStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) => Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.keyboard_arrow_down_outlined,
                  size: 40,
                )),
            backgroundColor: ThemeManagerCubit.get(context).isDark
                ? HexColor('333739')
                : HexColor('e8e6ef'),
            centerTitle: true,
            elevation: 0,
            toolbarHeight: 60,
            title: Text("Now Playing",
                style: Theme.of(context).textTheme.bodyText1),
            actions: [
              IconButton(
                onPressed: () {
                  //this should only be called once upon log in AND when user modifies playlist
                  userCubit.updatePlaylists(cubit.userPlaylists);
                  Fluttertoast.showToast(
                      msg: 'Added to Playlist',
                      backgroundColor: Colors.green,
                      textColor: Colors.white);
                },
                icon: Icon(
                  Icons.add,
                  size: 30,
                ),
              )
            ],
          ),
          body: cubit.isPlaying
              ? AnimatedBackground(
                  behaviour: RandomParticleBehaviour(
                    options: ParticleOptions(
                        baseColor: defaultColor,
                        spawnMinSpeed: 10,
                        spawnMaxSpeed: 30),
                  ),
                  vsync: this,
                  child: playBackWidget(),
                )
              : playBackWidget()),
    );
  }

  Widget playBackWidget() {
    var cubit = SoundCloudMusicManagerCubit.get(context);
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(cubit.nowPlaying.image640URL),
              radius: 150,
            ),
            Container(
              margin: EdgeInsets.only(left: 16, top: 40),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cubit.nowPlaying.name,
                          style: Theme.of(context).textTheme.headline4),
                      Container(
                        margin: EdgeInsets.only(left: 3),
                        child: Text(cubit.nowPlaying.artistName,
                            style: Theme.of(context).textTheme.bodyText2),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Slider(
              value: cubit.getPosition().toDouble(),
              onChanged: (value) async {
                cubit.slideTo(value);
              },
              min: 0,
              max: 30,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formattedTime(cubit.getPosition())),
                  InkWell(
                    onTap: () {
                      cubit.cycleSpeed();
                    },
                    child: Text(
                      "x${cubit.getCurrentSpeed()}",
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Text(formattedTime(cubit.duration)),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () {
                    cubit.rewind(5);
                  },
                  child: Stack(
                    children: const [
                      CircleAvatar(
                        backgroundColor: defaultColor,
                        radius: 25,
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Icon(
                          Icons.keyboard_double_arrow_left,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    cubit.togglePlayer();
                  },
                  customBorder: const CircleBorder(),
                  child: Stack(children: [
                    const CircleAvatar(
                      backgroundColor: defaultColor,
                      radius: 45,
                    ),
                    Positioned(
                      bottom: 15,
                      right: 15,
                      child: Icon(
                        cubit.playerButtonIcon,
                        color: Colors.white,
                        size: 60,
                      ),
                    ),
                  ]),
                ),
                InkWell(
                  onTap: () {
                    //forwards
                    cubit.fastForward(5);
                  },
                  customBorder: const CircleBorder(),
                  child: Stack(
                    children: const [
                      CircleAvatar(
                        backgroundColor: defaultColor,
                        radius: 25,
                      ),
                      Positioned(
                        bottom: 10,
                        right: 7,
                        child: Icon(
                          Icons.keyboard_double_arrow_right,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
