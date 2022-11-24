import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:untitled3/nextpage.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  OnAudioQuery _audioQuery = OnAudioQuery();

  Future<List<SongModel>> getallsongs() async {
    List<SongModel> allsongs = await _audioQuery.querySongs();
    return allsongs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: getallsongs(),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.done)
            {

              List<SongModel> songs = snapshot.data as List<SongModel>;
              return ListView.builder(
                
                itemBuilder: (context, index) {
                  SongModel s=songs[index];
                  return ListTile(onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return nextpage(songs,index);
                    },));
                  },
                    title: Text("${s.title}"),
                    subtitle: Text("${s.duration}"),
                  );
                },itemCount: songs.length,
              );
            }
          else
            {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
        },
      ),
    );
  }
}
