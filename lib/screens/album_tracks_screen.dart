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
import '../cubits/theme_manager/cubit.dart';

class AlbumTracksScreen extends StatelessWidget {
  const AlbumTracksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MusicManagerCubit,MusicManagerStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state){
        var cubit = MusicManagerCubit.get(context);

        return Scaffold(
          appBar: myAppBar(
              context,
              title: cubit.currentAlbum.name,
          ),
          body:ListView.separated(
              itemBuilder: (context, index){
                return InkWell(
                  onTap:  ()  {
                    cubit.nowPlaying = cubit.currentAlbum.trackList[index];
                    cubit.trackList = cubit.currentAlbum.trackList;
                    cubit.playlistIndex = index;
                    navigateTo(context, PlaybackScreen());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      children: [
                        Image(
                          image: NetworkImage(cubit.currentAlbum.trackList[index].image64URL,),
                          width: 100,
                        ),
                        SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 190,
                              child: defaultText(
                                text: cubit.currentAlbum.trackList[index].name,
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
                                  text: cubit.currentAlbum.trackList[index].albumName,
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
                              cubit.nowPlaying = cubit.currentAlbum.trackList[index];
                              cubit.trackList = cubit.currentAlbum.trackList;
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
              itemCount: cubit.currentAlbum.trackList.length
          ),
        );
      },

    );
  }
}
