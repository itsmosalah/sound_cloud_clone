import 'package:flutter/material.dart';
import '../models/music_player.dart';


class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Test Screen'),
      ),
      backgroundColor: Colors.white12,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: ()async{
                String url = "https://p.scdn.co/mp3-preview/315b151078df729934712ed1cc21e11506c64017?cid=f6a40776580943a7bc5173125a1e8832";

                MusicPlayer player = MusicPlayer();
                player.setUrlSrc(url);
                player.play();
                /*var _audioPlayer = AudioPlayer();
                await _audioPlayer.setUrl(url);
                await _audioPlayer.play();*/
              },
              child: Icon(Icons.play_arrow),
            ),

          ],
        ),
      ),
    );
  }
}
