import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sound_cloud_clone/components/components.dart';
import 'package:sound_cloud_clone/components/constants.dart';
import 'package:sound_cloud_clone/cubits/music_manager/cubit.dart';
import 'package:sound_cloud_clone/cubits/music_manager/states.dart';
import 'package:sound_cloud_clone/screens/playback_screen.dart';

import '../cubits/theme_manager/cubit.dart';
import '../models/playlist.dart';

class PlayListTracksScreen extends StatelessWidget {
  PlayListTracksScreen(this.playlistIndex, {Key? key}) : super(key: key);
  int playlistIndex;
  @override
  Widget build(BuildContext context) {


    return BlocConsumer<SoundCloudMusicManagerCubit,SoundCloudMusicManagerStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state){
        var cubit = SoundCloudMusicManagerCubit.get(context);
        Playlist currentPlaylist = cubit.userPlaylists[playlistIndex];

        return Scaffold(
          appBar: myAppBar(
              context,
              title: currentPlaylist.name,
            myActions: 
            [
              IconButton(onPressed: ()
              {
                cubit.userPlaylists.removeAt(playlistIndex);
                Navigator.pop(context);
                cubit.updatePlaylists();

              }, icon: Icon(Icons.delete))
            ]
          ),
          body: ListView.separated(
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    children: [
                      Image(image: NetworkImage(currentPlaylist.trackList[index].image64URL)),
                      SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 190,
                            child: defaultText(
                                text: currentPlaylist.trackList[index].name,
                                myStyle: Theme
                                    .of(context)
                                    .textTheme
                                    .subtitle2,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            width: 190,
                            child: defaultText(
                                text: currentPlaylist.trackList[index].albumName,
                                myStyle: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyText2,
                              textOverflow: TextOverflow.ellipsis
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      CircleAvatar(
                        backgroundColor: defaultColor,
                        child: IconButton(
                          onPressed: ()  {
                            currentPlaylist.removeTrack(index);
                            cubit.updatePlaylists();
                          },
                          icon: Icon(Icons.delete),
                          color: ThemeManagerCubit
                              .get(context)
                              .isDark
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),

                      SizedBox(width: 4,),
                      CircleAvatar(
                        backgroundColor: defaultColor,
                        child: IconButton(
                          onPressed: ()  {
                            cubit.nowPlaying = currentPlaylist.trackList[index];
                            cubit.setUrlSrc(currentPlaylist.trackList[index].previewURL);
                            cubit.togglePlayer();
                            navigateTo(context, PlaybackScreen());
                          },
                          icon: Icon(Icons.play_arrow),
                          color: ThemeManagerCubit
                              .get(context)
                              .isDark
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => myDivider(),
              itemCount: currentPlaylist.size
          ),
        );
      },

    );
  }
}
