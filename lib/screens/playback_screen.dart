import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_cloud_clone/cubits/login&Register/cubit.dart';
import '../components/components.dart';
import '../components/constants.dart';
import '../cubits/music_manager/cubit.dart';
import '../cubits/music_manager/states.dart';

class PlaybackScreen extends StatelessWidget {
  const PlaybackScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var cubit = SoundCloudMusicManagerCubit.get(context);
    cubit.setUrlSrc(cubit.nowPlaying.previewURL);

    //this should be called once, loading the playlist into a cubit for accessing
    cubit.loadPlayLists();

    var userCubit = SoundCloudLoginAndRegCubit();
    //this should only be called once upon log in AND when user modifies playlist
    userCubit.updatePlaylists(cubit.userPlaylists);

    return BlocConsumer<SoundCloudMusicManagerCubit,SoundCloudMusicManagerStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) => Scaffold(
        appBar: AppBar(
          backgroundColor: defaultColor,
          centerTitle: true,
          title: defaultText(
              text: 'Now Playing',
              textColor: Colors.white,
              fontsize: 25,
              letterSpacing: 2
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(cubit.nowPlaying.image640URL),
                radius: 150,
              ),
              defaultText(
                  text: cubit.nowPlaying.name,
                  fontsize: 30,
              ),
              defaultText(
                text: cubit.nowPlaying.albumName,
                fontsize: 20,
              ),
              defaultText(
                  text: "By ${cubit.nowPlaying.artistName}",
                  fontsize: 15
              ),
              Slider(
                  value: cubit.getPosition().toDouble(),
                  onChanged: (value) async {
                    cubit.slideTo(value);
                  },
                min: 0,
                max: 30,

              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(formattedTime(cubit.getPosition())),
                    InkWell(
                      onTap: (){
                        cubit.cycleSpeed();
                      },
                      child: Text(
                          "x${cubit.getCurrentSpeed()}",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black38
                        ),
                      ),

                    ),
                    Text(formattedTime(cubit.duration)),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(

                    customBorder: const CircleBorder(),
                    onTap: (){
                      cubit.rewind(5);
                    },
                    child: Stack(
                      children: const [
                        CircleAvatar(
                          backgroundColor: defaultColor,
                          radius: 25,
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: Icon(
                            Icons.keyboard_double_arrow_left,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      cubit.togglePlayer();
                    },
                    customBorder: const CircleBorder(),
                    child: Stack(
                      children: [

                        const CircleAvatar(
                          backgroundColor: defaultColor,
                          radius: 45,
                        ),
                        Positioned(
                          bottom: 15,
                          right: 15,
                          child:Icon(
                            cubit.playerButtonIcon,
                            color: Colors.white,
                            size: 60,
                          ),
                        ),
                      ]
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      //forwards
                      cubit.fastForward(5);
                    },
                    customBorder: const CircleBorder(),
                    child: Stack(
                      children: const [
                        CircleAvatar(
                          backgroundColor: defaultColor,
                          radius: 25,
                        ),
                        Positioned(
                          bottom: 10,
                          right: 7,
                          child: Icon(
                            Icons.keyboard_double_arrow_right,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25,),

            ],
          ),
        ),
      ),
    );
  }
}
