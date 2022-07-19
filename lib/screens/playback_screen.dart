import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/components.dart';
import '../components/constants.dart';
import '../cubits/music_manager/cubit.dart';
import '../cubits/music_manager/states.dart';

class PlaybackScreen extends StatelessWidget {
  const PlaybackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = SoundCloudMusicManagerCubit.get(context);
    return BlocConsumer<SoundCloudMusicManagerCubit,SoundCloudMusicManagerStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) => Scaffold(
        appBar: AppBar(
          backgroundColor: defaultColor,
          centerTitle: true,
          title: defaultText(
              text: 'Now Playing',
              textColor: Colors.white,
              fontsize: 28,
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
                  fontsize: 30
              ),
              defaultText(
                text: cubit.nowPlaying.albumName,
                fontsize: 20,
              ),
              defaultText(
                  text: "By ${cubit.nowPlaying.artistName}",
                  fontsize: 15
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: defaultColor,
                        radius: 25,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 2,
                        child: IconButton(
                          onPressed: (){},
                          icon: Icon(
                            Icons.keyboard_double_arrow_left,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: defaultColor,
                        radius: 45,
                      ),
                      Positioned(
                        bottom: 33,
                        right: 35,
                        child: IconButton(
                          onPressed: (){
                            cubit.setUrlSrc(cubit.nowPlaying.previewURL);
                            cubit.togglePlayer();
                          },
                          icon: Icon(
                            cubit.playerButtonIcon,
                            color: Colors.white,
                            size: 60,
                          ),
                        ),
                      ),
                    ]
                  ),
                  Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: defaultColor,
                        radius: 25,
                      ),
                      Positioned(
                        bottom: 0,
                        right: -1,
                        child: IconButton(
                          onPressed: (){},
                          icon: Icon(
                            Icons.keyboard_double_arrow_right,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
