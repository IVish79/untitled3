import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query_platform_interface/details/on_audio_query_helper.dart';

class nextpage extends StatefulWidget {
  List<SongModel> songs;
  int index;

  nextpage(this.songs, this.index);

  @override
  State<nextpage> createState() => _nextpageState();
}

class _nextpageState extends State<nextpage> {
  final player = AudioPlayer();
  bool play = false;
  double current_time = 0;

  @override
  void initState() {
    super.initState();
    print(widget.songs[widget.index]);
    player.onPositionChanged.listen((Duration p) {
      print('Current position: $p');
      setState(() {
        current_time = p.inMilliseconds.toDouble();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text("${widget.songs[widget.index].title}"),
          Slider(
            onChanged: (value) async {
              await player.seek(Duration(milliseconds: value.toInt()));
            },
            min: 0,
            max: widget.songs[widget.index].duration!.toDouble(),
            value: current_time,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: () {
                setState(() {
                  widget.index--;
                });
              }, child: Text("<<")),
              ElevatedButton(onPressed: () async {
                if(play)
                  {
                    await player.pause();
                  }
                else
                  {
                    String path=widget.songs[widget.index].data;
                    await player.play(DeviceFileSource(path));
                  }
                setState(() {
                  play=!play;
                });
              }, child: play?Icon(Icons.pause):Icon(Icons.play_arrow)),
              ElevatedButton(onPressed: () {
                setState(() {
                  widget.index++;
                });
              }, child: Text(">>")),
            ],
          )
        ],
      ),
    );
  }
}
