

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
import 'package:sound_cloud_clone/screens/playback_screen.dart';
import 'package:sound_cloud_clone/screens/search_screen.dart';
import 'package:we_slide/we_slide.dart';

import '../components/constants.dart';
import '../shared/network/remote/sound_api.dart';

class TracksScreen extends StatelessWidget {
  const TracksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SoundCloudMusicManagerCubit,
        SoundCloudMusicManagerStates>(
      builder: (BuildContext context, state) {
        var cubit = SoundCloudMusicManagerCubit.get(context);
        ScrollController _controller = ScrollController();
        cubit.setAlbum();
        List<TrackDataPlayback> dummyTrackList = cubit.spaghettiAlbum.trackList;

        return Scaffold(
          appBar: myAppBar(
            context,
            title: 'SoundCloud',
            myActions: [
              IconButton(onPressed: (){
                navigateTo(context, SearchScreen());
              }, icon: Icon(Icons.search))
            ]
          ),

          body: SingleChildScrollView(
            child: Column(
              children: [
                Text('Albums:'),
                Container(
                  height: 100,
                  child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                        return Icon(Icons.add);
                      },
                      itemCount: 20,
                    separatorBuilder: (context, index) {
                      return SizedBox(width: 20,);
                    },
                  ),

                ),
                Text('Tracks:'),
                SizedBox(height: 30,),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index){
                      //return Icon(Icons.add);
                      return buildTrack(dummyTrackList[index], context);
                    },
                  itemCount: dummyTrackList.length,
                ),
              ],
            ),
          )
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
  Widget buildTrack(TrackDataPlayback track, context){
    return Row(
      children: [
        Container(
          width: 100,
          padding: EdgeInsets.all(10),
          child: Image(
            image: NetworkImage(track.image64URL),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              child: defaultText(
                text: track.name,
                myStyle: Theme.of(context).textTheme.subtitle2,
              ),
            ),
            defaultText(text: track.albumName),
          ],
        ),
        Spacer(),
        Icon(Icons.add),
      ],
    );
  }
}


