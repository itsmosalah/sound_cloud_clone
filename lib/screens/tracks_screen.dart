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
        // cubit.setTrackList();
        // cubit.setNowPlaying(); idk why
        cubit.getTrack("dummy");
        cubit.setAlbum();
        //print("got tracks, loaded = " + cubit.loaded.toString());
        //print(cubit.userPlaylists.length);
        var searchController = TextEditingController();

        return Scaffold(
          appBar: myAppBar(context, title: 'SoundCloud'),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  child: defaultTextField(
                      labeltxt: 'Search',
                      txtinput: TextInputType.text,
                      prefixIcon: Icon(Icons.search),
                    controller: searchController,
                    onSubmit: (String searched) async {
                      var k = await SoundAPI.getSearchResults(searched);
                      SearchResults srch = SearchResults.fromJson(k);
                    }
                  ),
                ),
                Column(
                  children: [
                    ListView.separated(
                      //shrinkWrap: true,
                        itemBuilder: (context, index){
                          //return cubit.spaghettiAlbum.trackList[index];
                          return Container(
                            color: ThemeManagerCubit
                                .get(context)
                                .isDark
                                ? HexColor('333739')
                                : HexColor('e8e6ef'),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.fromLTRB(10, 5, 15, 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(26),
                                      boxShadow: [
                                        BoxShadow(
                                            color: defaultColor,
                                            offset: Offset(3, 3),
                                            blurRadius: 6)
                                      ],
                                    ),
                                    height: 100,
                                    width: 450,
                                    child: Row(
                                      children: [
                                        Image(
                                          image:
                                          NetworkImage(cubit.spaghettiAlbum.trackList[index].image64URL),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 170,
                                              child: defaultText(
                                                  text: cubit.spaghettiAlbum.trackList[index].name,
                                                  fontSize: 18,
                                                  textColor: Colors.black,
                                                  textOverflow: TextOverflow.ellipsis
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              width: 170,
                                              child: defaultText(
                                                  text: cubit.spaghettiAlbum.trackList[index].artistName,
                                                  textColor: Colors.grey[600],
                                                  fontSize: 15,
                                                  textOverflow: TextOverflow.ellipsis
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        CircleAvatar(
                                          backgroundColor: defaultColor,
                                          child: IconButton(
                                            onPressed: () {
                                              cubit.setUrlSrc(cubit.spaghettiAlbum.trackList[index].previewURL);
                                              cubit.togglePlayer();
                                              // cubit.setNowPlaying(cubit.nowPlaying);
                                              // cubit.loadPlayLists();
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      child: PlaybackScreen(),
                                                      type:
                                                      PageTransitionType.bottomToTop));
                                            },
                                            icon: Icon(Icons.play_arrow),
                                            color: Colors.black,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => myDivider(),
                        itemCount: cubit.spaghettiAlbum.trackList.length),
                  ],
                ),
                ConditionalBuilder(
                  condition: state is SoundCloudGotTrackAndPlaylistsState,
                  builder: (context) {
                    return WeSlide(
                      body: Container(
                        color: ThemeManagerCubit
                            .get(context)
                            .isDark
                            ? HexColor('333739')
                            : HexColor('e8e6ef'),
                        child: Padding(
                          padding: const EdgeInsets.all(35.0),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 5, 15, 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(26),
                                  boxShadow: [
                                    BoxShadow(
                                        color: defaultColor,
                                        offset: Offset(3, 3),
                                        blurRadius: 6)
                                  ],
                                ),
                                height: 100,
                                width: 450,
                                child: Row(
                                  children: [
                                    Image(
                                      image:
                                      NetworkImage(cubit.nowPlaying.image64URL),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 170,
                                          child: defaultText(
                                              text: cubit.nowPlaying.name,
                                              fontSize: 18,
                                              textColor: Colors.black,
                                            textOverflow: TextOverflow.ellipsis
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          width: 170,
                                          child: defaultText(
                                              text: cubit.nowPlaying.artistName,
                                              textColor: Colors.grey[600],
                                              fontSize: 15,
                                            textOverflow: TextOverflow.ellipsis
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    CircleAvatar(
                                      backgroundColor: defaultColor,
                                      child: IconButton(
                                        onPressed: () {
                                          cubit.setUrlSrc(cubit.nowPlaying.previewURL);
                                          cubit.togglePlayer();
                                          // cubit.setNowPlaying(cubit.nowPlaying);
                                          // cubit.loadPlayLists();
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  child: PlaybackScreen(),
                                                  type:
                                                  PageTransitionType.bottomToTop));
                                        },
                                        icon: Icon(Icons.play_arrow),
                                        color: Colors.black,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      panelMaxSize: 100,
                      panelMinSize: 85,

                      panel: cubit.urlSrc != "" ? InkWell(
                        onTap: () {
                          cubit.stillPlaying = true;
                          Navigator.push(context, PageTransition(
                              child: PlaybackScreen(),
                              type: PageTransitionType.bottomToTop));
                        },
                        child: Container(
                            padding: EdgeInsets.fromLTRB(20, 6, 20, 10),
                            color: ThemeManagerCubit
                                .get(context)
                                .isDark
                                ? HexColor('333739')
                                : Colors.white,
                            child: Row(
                              children: [
                                Image(
                                  image: NetworkImage(cubit.nowPlaying.image64URL),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 190,
                                      child: Text(
                                        cubit.nowPlaying.name,
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .subtitle2,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(cubit.nowPlaying.artistName,
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .bodyText2),
                                  ],
                                ),
                                Spacer(),
                                CircleAvatar(
                                  backgroundColor: defaultColor,
                                  child: IconButton(
                                    onPressed: () {
                                      cubit.setUrlSrc(cubit.nowPlaying.previewURL);
                                      cubit.togglePlayer();
                                    },
                                    icon: Icon(cubit.playerButtonIcon),
                                    color: ThemeManagerCubit
                                        .get(context)
                                        .isDark
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                )
                              ],
                            )),
                      ) : Container(),
                    );
                  },
                  fallback: (context) => Center(child: CircularProgressIndicator(),),
                ),
              ],
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
