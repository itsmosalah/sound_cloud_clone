import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sound_cloud_clone/components/components.dart';
import 'package:sound_cloud_clone/components/constants.dart';
import 'package:sound_cloud_clone/cubits/music_manager/cubit.dart';
import 'package:sound_cloud_clone/cubits/music_manager/states.dart';
import 'package:sound_cloud_clone/cubits/music_playback/states.dart';
import 'package:sound_cloud_clone/screens/playback_screen.dart';
import 'package:sound_cloud_clone/screens/playlist_tracks_screen.dart';

import '../cubits/music_playback/cubit.dart';

class PlayListsScreen extends StatelessWidget {
  const PlayListsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();

    var manager = MusicManagerCubit.get(context);
    var cubit = MusicPlaybackCubit.get(context);

    //USER PLAYLISTS LOADED
    if (!manager.playlistsLoaded){
      manager.loadPlayLists();
    }

    return BlocConsumer<MusicManagerCubit,
        MusicManagerStates>(
      listener: (BuildContext context, Object? state) {
        if (state is SoundCloudAddPlaylistSuccessState) {
          Fluttertoast.showToast(
              msg: 'Added Successfully',
              backgroundColor: defaultColor,
              textColor: Colors.white);
          Navigator.pop(context);
          nameController.text = "";
        } else if (state is SoundCloudAddPlaylistErrorState) {
          Fluttertoast.showToast(
              msg: 'Playlist name already used', backgroundColor: Colors.red);
        }
      },
      builder: (BuildContext context, state) {


        return Scaffold(
          appBar: myAppBar(context, title: "Playlists", myActions: [
            IconButton(
              icon: Icon(
                Icons.add,
                size: 35,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: defaultText(text: 'Create playlist'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              defaultTextField(
                                  labeltxt: 'Playlist name',
                                  txtinput: TextInputType.name,
                                  enableBorder: true,
                                  controller: nameController),
                              SizedBox(height: 25),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: defaultText(
                                            text: "Cancel",
                                            textColor: Colors.white)),
                                    width: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: defaultColor,
                                    ),
                                  ),
                                  Container(
                                    width: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: defaultColor,
                                    ),
                                    child: TextButton(
                                        onPressed: () {
                                          manager.createPlaylist(
                                              nameController.text);
                                        },
                                        child: defaultText(
                                            text: "Add",
                                            textColor: Colors.white)),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ));
              },
            ),
          ]),
          body: BlocConsumer<MusicPlaybackCubit,MusicPlaybackStates>(
            builder: (context, state) {
              return myPanel(
                  Screen: ConditionalBuilder(
                    condition: manager.playlistsLoaded,
                    builder: (context) => ListView.separated(
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            navigateTo(context, PlayListTracksScreen(index));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    defaultText(
                                        text:
                                        manager.userPlaylists[index].name.toString(),
                                        myStyle: Theme.of(context).textTheme.subtitle2),
                                    defaultText(
                                        text:
                                        "Number of tracks ${manager.userPlaylists[index].size}",
                                        myStyle: Theme.of(context).textTheme.bodyText2),
                                  ],
                                ),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => myDivider(),
                      itemCount: manager.userPlaylists.length,
                    ),
                    fallback: (context) => Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  context: context,
                  cubit: cubit);
            },
            listener: (context, state) {

            },
          ),
        );
      },
    );
  }
}
