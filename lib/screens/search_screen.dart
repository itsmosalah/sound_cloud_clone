import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_cloud_clone/components/components.dart';
import 'package:sound_cloud_clone/screens/playback_screen.dart';

import '../components/constants.dart';
import '../cubits/music_manager/cubit.dart';
import '../cubits/music_manager/states.dart';
import '../cubits/theme_manager/cubit.dart';
import '../models/search_results.dart';
import '../shared/network/remote/sound_api.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();

    var cubit = MusicManagerCubit.get(context);

    return BlocConsumer<MusicManagerCubit,
        MusicManagerStates>(
      builder: (BuildContext context, state){

        return Scaffold(
          appBar: myAppBar(context, title: 'Search'),
          body: Column(
            children: [
              //search
              Container(
                padding: EdgeInsets.all(15),
                child: defaultTextField(
                    labeltxt: 'Search',
                    // hintStyle: Theme.of(context).textTheme.subtitle2,
                    txtinput: TextInputType.text,
                    prefixIcon: Icon(Icons.search),
                    controller: searchController,
                    onSubmit: (String searchQuery) {
                        cubit.setSearchResults(searchQuery);
                    }
                ),
              ),

              // list of results
              if (cubit.searchResults.trackList.isNotEmpty)
              Container(
                width: 400,
                height: 500,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {

                      return Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          children: [
                            Image(image: NetworkImage(cubit.searchResults.trackList[index].image64URL)),
                            SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 190,
                                  child: defaultText(
                                    text: cubit.searchResults.trackList[index].name,
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
                                      text: cubit.searchResults.trackList[index].albumName,
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
                                  /*cubit.nowPlaying =*/
                                  cubit.getTrack(cubit.searchResults.trackList[index].id);
                                  // cubit.setNowPlaying();
                                  //use the index to access trackdata then id
                                  //then use id to get track using api
                                  //then set the track to nowNowPlaying
                                  //then navigate to the playback screen
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
                    itemCount: cubit.searchResults.trackList.length,
                ),
              )
            ],
          ),
        );
      },
      listener: (BuildContext context, state){},
    );
  }
}
