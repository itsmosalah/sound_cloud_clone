import 'package:flutter/material.dart';
import 'package:sound_cloud_clone/components/components.dart';

class PlayListsScreen extends StatelessWidget {
  const PlayListsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(
          'Playlists',style: Theme.of(context).textTheme.headline1,
        ),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
    );
  }
}
