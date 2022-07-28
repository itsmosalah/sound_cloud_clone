import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_cloud_clone/components/components.dart';
import 'package:sound_cloud_clone/cubits/music_manager/cubit.dart';
import 'package:sound_cloud_clone/cubits/music_manager/states.dart';
import 'package:sound_cloud_clone/cubits/music_playback/cubit.dart';
import 'package:sound_cloud_clone/cubits/music_playback/states.dart';
import 'package:sound_cloud_clone/cubits/theme_manager/cubit.dart';
import 'package:sound_cloud_clone/models/track_data.dart';
import 'package:sound_cloud_clone/screens/album_tracks_screen.dart';
import 'package:sound_cloud_clone/screens/playback_screen.dart';
import 'package:sound_cloud_clone/screens/search_screen.dart';
import '../components/constants.dart';

class TracksScreen extends StatelessWidget {
  const TracksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MusicManagerCubit, MusicManagerStates>(
      builder: (BuildContext context, state) {
        var manager = MusicManagerCubit.get(context);
        var cubit = MusicPlaybackCubit.get(context);
        //ScrollController _controller = ScrollController();
        //cubit.setAlbum();
        //List<TrackDataPlayback> dummyTrackList = manager.spaghettiAlbum.trackList;
        manager.loadMainScreenContent();

        return ConditionalBuilder(
          condition: manager.mainScreenContentLoaded,
          builder: (context) => Scaffold(
            appBar: myAppBar(context, title: 'SoundCloud', myActions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context, const SearchScreen());
                  },
                  icon: const Icon(Icons.search))
            ]),
            body: BlocConsumer<MusicPlaybackCubit,MusicPlaybackStates>(
              listener: (context, state) {},
              builder: (context, state) {
                return myPanel(
                    Screen: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            defaultText(
                                text: 'Albums:',
                                myStyle: Theme.of(context).textTheme.headline3),
                            SizedBox(height: 10),
                            Container(
                              height: 190,
                              child: ListView.separated(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return buildAlbum(
                                      manager.mainScreenAlbums[index], manager, context);
                                },
                                itemCount: manager.mainScreenAlbums.length,
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    width: 20,
                                  );
                                },
                              ),
                            ),
                            myDivider(),
                            const SizedBox(
                              height: 20,
                            ),
                            defaultText(
                                text: 'Tracks:',
                                myStyle: Theme.of(context).textTheme.headline3
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return buildTrack(
                                    manager.mainScreenTracks[index], context, manager, index, cubit);
                              },
                              itemCount: manager.mainScreenTracks.length,
                            ),
                          ],
                        ),
                      ),
                    ),
                    context: context,
                    cubit: cubit);
              },
            ),
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }

  Widget buildAlbum(albumData, manager, context) {
    return InkWell(
      onTap: () {
        manager.setAlbum(albumData);
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
          Container(
            width: 110,
            child: defaultText(
                text: albumData.name,
                myStyle: Theme.of(context).textTheme.subtitle2,textOverflow: TextOverflow.ellipsis),
          ),
          defaultText(
            text: albumData.releaseDate,
          ),
        ],
      ),
    );
  }

  Widget buildTrack(TrackDataPlayback track, context, manager, index, cubit) {
    return InkWell(
      onTap: () {
        cubit.stillPlaying = false;
        manager.nowPlaying = track;
        manager.trackList = manager.mainScreenTracks;
        manager.playlistIndex = index;
        navigateTo(context, const PlaybackScreen());
      },
      child: Row(
        children: [
          Container(
            width: 80,
            padding: const EdgeInsets.all(10),
            child: Image(
              image: NetworkImage(track.image64URL),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 210,
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
              onPressed: () {
                cubit.stillPlaying = false;
                manager.nowPlaying = track;
                manager.trackList = manager.mainScreenTracks;
                manager.playlistIndex = index;
                navigateTo(context, const PlaybackScreen());
              },
              icon: const Icon(Icons.play_arrow),
              color: ThemeManagerCubit.get(context).isDark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          SizedBox(width: 5,),
        ],
      ),
    );
  }
}
