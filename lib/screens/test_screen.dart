import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sound_cloud_clone/models/track_data.dart';
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
                /*String url = "https://p.scdn.co/mp3-preview/315b151078df729934712ed1cc21e11506c64017?cid=f6a40776580943a7bc5173125a1e8832";

                MusicPlayer player = MusicPlayer();
                player.setUrlSrc(url);
                player.play();*/
                /*var _audioPlayer = AudioPlayer();
                await _audioPlayer.setUrl(url);
                await _audioPlayer.play();*/

                String responseGetTrack = "{\"tracks\":[{\"album\":{\"album_type\":\"album\",\"artists\":[{\"external_urls\":{\"spotify\":\"https://open.spotify.com/artist/2zwHaEmXxX6DTv4i8ajNCM\"},\"id\":\"2zwHaEmXxX6DTv4i8ajNCM\",\"name\":\"KrisAllen\",\"type\":\"artist\",\"uri\":\"spotify:artist:2zwHaEmXxX6DTv4i8ajNCM\"}],\"external_urls\":{\"spotify\":\"https://open.spotify.com/album/4K3AXbUoyTVE4A6wV50cmB\"},\"id\":\"4K3AXbUoyTVE4A6wV50cmB\",\"images\":[{\"height\":640,\"url\":\"https://i.scdn.co/image/ab67616d0000b2735f3afe4cafb7a274497341b3\",\"width\":640},{\"height\":300,\"url\":\"https://i.scdn.co/image/ab67616d00001e025f3afe4cafb7a274497341b3\",\"width\":300},{\"height\":64,\"url\":\"https://i.scdn.co/image/ab67616d000048515f3afe4cafb7a274497341b3\",\"width\":64}],\"name\":\"Horizons\",\"release_date\":\"2014-08-12\",\"release_date_precision\":\"day\",\"total_tracks\":10,\"type\":\"album\",\"uri\":\"spotify:album:4K3AXbUoyTVE4A6wV50cmB\"},\"artists\":[{\"external_urls\":{\"spotify\":\"https://open.spotify.com/artist/2zwHaEmXxX6DTv4i8ajNCM\"},\"id\":\"2zwHaEmXxX6DTv4i8ajNCM\",\"name\":\"KrisAllen\",\"type\":\"artist\",\"uri\":\"spotify:artist:2zwHaEmXxX6DTv4i8ajNCM\"}],\"disc_number\":1,\"duration_ms\":198386,\"explicit\":false,\"external_ids\":{\"isrc\":\"QMF921450124\"},\"external_urls\":{\"spotify\":\"https://open.spotify.com/track/3nBmy2hAqIDmMOD0VZGB7I\"},\"id\":\"3nBmy2hAqIDmMOD0VZGB7I\",\"is_local\":false,\"is_playable\":true,\"name\":\"Lost\",\"popularity\":45,\"preview_url\":\"https://p.scdn.co/mp3-preview/6574de68d560b54a86d76b56ea5a414241627106?cid=f6a40776580943a7bc5173125a1e8832\",\"track_number\":5,\"type\":\"track\",\"uri\":\"spotify:track:3nBmy2hAqIDmMOD0VZGB7I\"}]}";
                final data = await json.decode(responseGetTrack);

                TrackData x = TrackData.fromJson(data);

                MusicPlayer mp = MusicPlayer();
                mp.setUrlSrc(x.previewURL);
                mp.play();
              },
              child: Icon(Icons.play_arrow),
            ),

          ],
        ),
      ),
    );
  }
}
