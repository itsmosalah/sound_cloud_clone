import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sound_cloud_clone/cubits/login&Register/cubit.dart';
import 'package:sound_cloud_clone/cubits/music_playback/cubit.dart';
import 'package:sound_cloud_clone/cubits/music_playback/states.dart';
import 'package:sound_cloud_clone/cubits/theme_manager/cubit.dart';
import 'package:sound_cloud_clone/models/playlist.dart';
import '../components/components.dart';
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
    var cubit = MusicPlaybackCubit.get(context);
    var manager = MusicManagerCubit.get(context);



    if(!cubit.stillPlaying) {
      cubit.setActiveTrack(manager.nowPlaying);
      cubit.setActivePlaylist(manager.trackList, manager.playlistIndex);
    }




    //this should be called once, loading the playlist into a cubit for accessing
    //cubit.loadPlayLists();
    /*if (!cubit.stillPlaying) {
      cubit.togglePlayer();
    }
    cubit.stillPlaying = false;*/
    return BlocConsumer<MusicPlaybackCubit, MusicPlaybackStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) => Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
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
                  myDialog(
                      text: "Choose a Playlist",
                      isItListView: true,
                      context: context,
                      content: Container(
                        width: 300,
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                bool newSong = false;
                                manager.userPlaylists[index].trackList
                                    .forEach((element) {
                                  if (element.name != cubit.activeTrack.name) {
                                    newSong = true;
                                  } else {
                                    newSong = false;
                                  }
                                });
                                if (newSong ||
                                    manager.userPlaylists[index].size == 0) {
                                  manager.userPlaylists[index]
                                      .addTrack(cubit.activeTrack);
                                  manager.updatePlaylists();
                                  Fluttertoast.showToast(
                                      msg:
                                          'Added to ${manager.userPlaylists[index].name}',
                                      backgroundColor: defaultColor,
                                      textColor: Colors.white);
                                } else {
                                  Fluttertoast.showToast(
                                      msg:
                                          'This Song is Already exists in this Playlist',
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white);
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        defaultText(
                                            text: manager
                                                .userPlaylists[index].name,
                                            myStyle: Theme.of(context)
                                                .textTheme
                                                .subtitle2),
                                        defaultText(
                                            text: "Number of tracks = " +
                                                '${manager.userPlaylists[index].size}',
                                            myStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText2),
                                      ],
                                    ),
                                    Spacer(),
                                    Icon(Icons.arrow_forward_ios),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount: manager.userPlaylists.length,
                        ),
                      ));
                },
                icon: Icon(
                  Icons.add,
                  size: 30,
                ),
              ),
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
                  child: playBackWidget(cubit,manager),
                )
              : playBackWidget(cubit,manager)),
    );
  }

  Widget playBackWidget(cubit,manager) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(cubit.activeTrack.image640URL),
                radius: 150,
              ),
              Container(
                margin: EdgeInsets.only(left: 16, top: 40),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 330,
                          child: defaultText(
                              text: cubit.activeTrack.name,
                              myStyle: Theme.of(context).textTheme.headline4,
                              textOverflow: TextOverflow.ellipsis),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 3),
                          child: Text(cubit.activeTrack.artistName,
                              style: Theme.of(context).textTheme.bodyText2),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Slider(
                value: cubit.getPosition().toDouble(),
                onChanged: (value) {
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
                    onLongPress: (){
                      cubit.previousTrack();
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

                      manager.panelAppear();
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
                    onLongPress: (){
                      cubit.nextTrack();
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
      ),
    );
  }
}

