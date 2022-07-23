import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_cloud_clone/components/components.dart';
import 'package:sound_cloud_clone/cubits/music_manager/cubit.dart';
import 'package:sound_cloud_clone/cubits/music_manager/states.dart';
import 'package:sound_cloud_clone/screens/playback_screen.dart';

class PlayListsScreen extends StatelessWidget {
  const PlayListsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SoundCloudMusicManagerCubit,SoundCloudMusicManagerStates>(
      builder: (BuildContext context, state){
        var cubit = SoundCloudMusicManagerCubit.get(context);
        // cubit.setTrackList();
        cubit.setNowPlaying();
        return Scaffold(
          appBar: AppBar(
            title:Text(
              'SoundCloud',style: Theme.of(context).textTheme.headline1,
            ),
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
                      Image(image: NetworkImage(cubit.userPlaylists[0].trackList[0].image64URL),),
                      SizedBox(width: 10,),
                      Column(
                        children:
                        [
                          defaultText(text: cubit.userPlaylists[0].trackList[0].name),
                          SizedBox(height: 5,),
                          defaultText(text: cubit.userPlaylists[0].trackList[0].artistName),
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
