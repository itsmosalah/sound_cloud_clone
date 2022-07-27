

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sound_cloud_clone/components/components.dart';
import 'package:sound_cloud_clone/cubits/login&Register/cubit.dart';
import 'package:sound_cloud_clone/cubits/music_manager/cubit.dart';
import 'package:sound_cloud_clone/cubits/music_manager/states.dart';
import 'package:sound_cloud_clone/cubits/theme_manager/cubit.dart';
import 'package:sound_cloud_clone/models/search_results.dart';
import 'package:sound_cloud_clone/models/track_data.dart';
import 'package:sound_cloud_clone/screens/album_tracks_screen.dart';
import 'package:sound_cloud_clone/screens/playback_screen.dart';
import 'package:sound_cloud_clone/screens/search_screen.dart';
import 'package:we_slide/we_slide.dart';

import '../components/constants.dart';
import '../shared/network/remote/sound_api.dart';

class TracksScreen extends StatelessWidget {
  const TracksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MusicManagerCubit,
        MusicManagerStates>(
      builder: (BuildContext context, state) {
        var cubit = MusicManagerCubit.get(context);
        //ScrollController _controller = ScrollController();
        //cubit.setAlbum();
        //List<TrackDataPlayback> dummyTrackList = cubit.spaghettiAlbum.trackList;

        cubit.loadMainScreenContent();

        return ConditionalBuilder(
          condition: cubit.mainScreenContentLoaded,
          builder: (context) => Scaffold(
              appBar: myAppBar(
                  context,
                  title: 'SoundCloud',
                  myActions: [
                    IconButton(onPressed: (){
                      navigateTo(context, const SearchScreen());
                    }, icon: const Icon(Icons.search))
                  ]
              ),

              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      defaultText(
                          text: 'Albums:',
                          myStyle: Theme.of(context).textTheme.headline3
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 190,
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index){
                            return buildAlbum(cubit.mainScreenAlbums[index], cubit, context);
                          },
                          itemCount: cubit.mainScreenAlbums.length,
                          separatorBuilder: (context, index) {
                            return SizedBox(width: 20,);
                          },
                        ),

                      ),
                      myDivider(),
                      const SizedBox(height: 20,),
                      defaultText(
                          text: 'Tracks:',
                          myStyle: Theme.of(context).textTheme.headline3
                      ),

                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index){
                          return buildTrack(cubit.mainScreenTracks[index], context, cubit);
                        },
                        itemCount: cubit.mainScreenTracks.length,
                      ),
                    ],
                  ),
                ),
              )
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
  Widget buildAlbum(albumData, cubit, context){
    return InkWell(
      onTap: (){
        cubit.setAlbum(albumData);
        navigateTo(context, const AlbumTracksScreen());
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: NetworkImage(albumData.image640URL),
            height: 100,
            width: 100,
          ),
          defaultText(
              text: albumData.name,
              myStyle: Theme.of(context).textTheme.subtitle2
          ),
          defaultText(
            text: albumData.releaseDate,
          ),
        ],
      ),
    );
  }
  Widget buildTrack(TrackDataPlayback track, context, cubit){
    return InkWell(
      onTap: (){
        cubit.nowPlaying = track;
        navigateTo(context, const PlaybackScreen());
      },
      child: Row(
        children: [
          Container(
            width: 100,
            padding: const EdgeInsets.all(10),
            child: Image(
              image: NetworkImage(track.image64URL),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 100,
                child: defaultText(
                  text: track.name,
                  myStyle: Theme.of(context).textTheme.subtitle2,
                ),
              ),
              defaultText(text: track.albumName),
            ],
          ),
          const Spacer(),
          CircleAvatar(
          backgroundColor: defaultColor,
          child: IconButton(
            onPressed:  ()  {
              cubit.nowPlaying = track;
              navigateTo(context, const PlaybackScreen());
            },
            icon: const Icon(Icons.play_arrow),
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
  }

}


