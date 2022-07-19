
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_cloud_clone/components/components.dart';
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



    return BlocConsumer<SoundCloudMusicManagerCubit,SoundCloudMusicManagerStates>(
      builder: (BuildContext context, state){
        var cubit = SoundCloudMusicManagerCubit.get(context);
        // cubit.setTrackList();
        cubit.setNowPlaying();


        return Scaffold(
          appBar: AppBar(
            title: defaultText(text: "SoundCloud", fontsize: 25),
            centerTitle: true,
            backgroundColor: Colors.deepOrange,
          ),
          body: Padding(
            padding: const EdgeInsets.all(45.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 100,
                  child: Row(
                    children:
                    [
                      Image(image: NetworkImage(cubit.nowPlaying.image64URL),),
                      SizedBox(width: 10,),
                      Column(
                        children:
                        [
                          defaultText(text: cubit.nowPlaying.name),
                          SizedBox(height: 5,),
                          defaultText(text: cubit.nowPlaying.artistName),
                        ],
                      ),
                      Spacer(),
                      IconButton(onPressed: () {
                          /*MusicPlayer mp = MusicPlayer();
                          mp.setUrlSrc(cubit.nowPlaying.previewURL);
                          mp.play();*/


                        navigateTo(context, PlaybackScreen());
                      }, icon: Icon(Icons.play_arrow))
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {  },
    );
  }
}
