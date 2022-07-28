import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sound_cloud_clone/components/components.dart';
import 'package:sound_cloud_clone/components/constants.dart';
import 'package:sound_cloud_clone/cubits/music_manager/cubit.dart';
import 'package:sound_cloud_clone/cubits/music_manager/states.dart';
import 'package:sound_cloud_clone/cubits/music_playback/cubit.dart';
import 'package:sound_cloud_clone/cubits/music_playback/states.dart';
import 'package:sound_cloud_clone/screens/playback_screen.dart';

import '../cubits/theme_manager/cubit.dart';
import '../models/playlist.dart';

class PlayListTracksScreen extends StatelessWidget {
  PlayListTracksScreen(this.playlistIndex, {Key? key}) : super(key: key);
  int playlistIndex;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MusicManagerCubit, MusicManagerStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        var manager = MusicManagerCubit.get(context);
        Playlist currentPlaylist = manager.userPlaylists[playlistIndex];

        return Scaffold(
          appBar: myAppBar(context, title: currentPlaylist.name, myActions: [
            IconButton(
                onPressed: () {
                  myDialog(
                      text: 'Are you sure to delete this Playlist ?',
                      declineText: 'Cancel',
                      acceptText: "YES",
                      context: context,
                      declineFn: () {
                        Navigator.pop(context);
                      },
                      acceptFn: () {
                        Fluttertoast.showToast(
                            msg:
                            'Playlist deleted',
                            backgroundColor: defaultColor,
                            textColor: Colors.white);
                        manager.userPlaylists.removeAt(playlistIndex);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        manager.updatePlaylists();
                      });
                },
                icon: Icon(Icons.delete))
          ]),
          body: BlocConsumer<MusicPlaybackCubit, MusicPlaybackStates>(
            listener: (context, state) {

            },
            builder: (context, state) {
              var cubit = MusicPlaybackCubit.get(context);
              return myPanel(
                  Screen: ListView.separated(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Row(
                            children: [
                              Image(
                                image: NetworkImage(
                                    currentPlaylist.trackList[index].image64URL),
                                width: 50,
                              ),
                              SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 170,
                                    child: defaultText(
                                      text: currentPlaylist.trackList[index].name,
                                      myStyle: Theme.of(context).textTheme.subtitle2,
                                      textOverflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    child: defaultText(
                                        text:
                                        currentPlaylist.trackList[index].albumName,
                                        myStyle: Theme.of(context).textTheme.bodyText2,
                                        textOverflow: TextOverflow.ellipsis),
                                  ),
                                ],
                              ),
                              Spacer(),
                              CircleAvatar(
                                backgroundColor: defaultColor,
                                child: IconButton(
                                  onPressed: () {
                                    myDialog(
                                        context: context,
                                        text:
                                        "Are you sure to delete this Song from your Playlist ?",
                                        declineText: "Cancel",
                                        acceptText: "YES",
                                        acceptFn: () {
                                          Fluttertoast.showToast(
                                              msg:
                                              'Song deleted',
                                              backgroundColor: defaultColor,
                                              textColor: Colors.white
                                          );
                                          currentPlaylist.removeTrack(index);

                                          Navigator.pop(context);

                                          manager.updatePlaylists();

                                        },
                                        declineFn: () {
                                          Navigator.pop(context);
                                        });
                                  },
                                  icon: Icon(Icons.delete),
                                  color: ThemeManagerCubit.get(context).isDark
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              CircleAvatar(
                                backgroundColor: defaultColor,
                                child: IconButton(
                                  onPressed: () {
                                    cubit.stillPlaying = false;
                                    manager.nowPlaying = currentPlaylist.trackList[index];
                                    manager.trackList = currentPlaylist.trackList;
                                    manager.playlistIndex = index;
                                    navigateTo(context, PlaybackScreen());
                                  },
                                  icon: Icon(Icons.play_arrow),
                                  color: ThemeManagerCubit.get(context).isDark
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => myDivider(),
                      itemCount: currentPlaylist.size),
                  context: context,
                  cubit: cubit
              );
            },

          ),
        );
      },
    );
  }
}
