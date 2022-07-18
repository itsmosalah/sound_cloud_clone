
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sound_cloud_clone/components/components.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: defaultText(text: "SoundCloud", fontsize: 25),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(45.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 100,
              child: Row(
                children:
                [
                  Image(image: AssetImage('assets/images/amrdiab.png'),),
                  SizedBox(width: 10,),
                  Column(
                    children:
                    [
                      defaultText(text: 'SongName'),
                      SizedBox(height: 5,),
                      defaultText(text: 'ArtistName'),
                    ],
                  ),
                  Spacer(),
                  IconButton(onPressed: (){}, icon: Icon(Icons.play_arrow))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
