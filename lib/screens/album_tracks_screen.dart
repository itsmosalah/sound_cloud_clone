import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sound_cloud_clone/components/components.dart';
import 'package:sound_cloud_clone/cubits/music_manager/cubit.dart';
import 'package:sound_cloud_clone/cubits/music_manager/states.dart';
import 'package:sound_cloud_clone/cubits/music_playback/cubit.dart';
import 'package:sound_cloud_clone/screens/playback_screen.dart';
import 'package:we_slide/we_slide.dart';

import '../components/constants.dart';
import '../cubits/music_playback/states.dart';
import '../cubits/theme_manager/cubit.dart';

class AlbumTracksScreen extends StatelessWidget {
  const AlbumTracksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MusicManagerCubit,MusicManagerStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state){
        var manager = MusicManagerCubit.get(context);
        return Scaffold(
          appBar: myAppBar(
              context,
              title: manager.currentAlbum.name,
          ),
          body: BlocConsumer<MusicPlaybackCubit, MusicPlaybackStates> (
            listener: (context, state){},
            builder: (context, state) {
              var cubit = MusicPlaybackCubit.get(context);
              return myPanel(
                  context: context,
                  cubit: cubit,
                  Screen: ListView.separated(
                      itemBuilder: (context, index){
                        return InkWell(
                          onTap:  ()  {
                            cubit.stillPlaying = false;
                            manager.nowPlaying = manager.currentAlbum.trackList[index];
                            manager.trackList = manager.currentAlbum.trackList;
                            cubit.playlistIndex = index;
                            navigateTo(context, PlaybackScreen());
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Row(
                              children: [
                                Image(
                                  image: NetworkImage(manager.currentAlbum.trackList[index].image64URL,),
                                  width: 100,
                                ),
                                SizedBox(width: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 160,
                                      child: defaultText(
                                        text: manager.currentAlbum.trackList[index].name,
                                        myStyle: Theme
                                            .of(context)
                                            .textTheme
                                            .subtitle2,
                                        textOverflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Container(
                                      width: 160,
                                      child: defaultText(
                                          text: manager.currentAlbum.trackList[index].albumName,
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
                                    onPressed:  ()  {
                                      cubit.stillPlaying = false;
                                      manager.nowPlaying = manager.currentAlbum.trackList[index];
                                      manager.trackList = manager.currentAlbum.trackList;
                                      cubit.playlistIndex = index;
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
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => myDivider(),
                      itemCount: manager.currentAlbum.trackList.length
                  ),
                  );
            },
          ),
        );
      },

    );
  }
}
