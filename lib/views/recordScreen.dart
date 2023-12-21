
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';

import '../constants/utils.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  late AudioRecorder audioRecord;
  late AudioPlayer audioPlayer;
  bool isRecording = false;
  String audioPath = "/storage/emulated/0/Download/myFile2.m4a";
  @override
  void initState() {
    // TODO: implement initState
    audioRecord = AudioRecorder();
    audioPlayer = AudioPlayer();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    audioPlayer.dispose();
    audioRecord.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Record Any Sound"),),
      body: _body()
    );
  }

  Widget _body(){
    return Container(
      height: Utils().SCREEN_HEIGHT(context),
      width: Utils().SCREEN_WIDTH(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                print("Button pressed");
                isRecording ? stopRecording() : startRecording();
              },
              child: isRecording ? Text("Stop Recording") : Text("Start Recording")
          ),
          ElevatedButton(
              onPressed: () {
                playRecording();
              },
              child: Text("Play Recording")
          ),
        ],
      ),
    );
  }

  Future<void> startRecording() async {
    try{
      if(await audioRecord.hasPermission()){
        await audioRecord.start(const RecordConfig(), path: '/storage/emulated/0/Download/myFile2.m4a');
        setState(() {
          isRecording = true;
        });
      }
    }
    catch(e){

    }
  }

  Future<void> stopRecording() async {
    try{
      String? path = await audioRecord.stop();
      setState(() {
        print("path : $path");
        isRecording = false;
        audioPath = path!;
      });
    }
    catch(e){

    }
  }

  Future<void> playRecording() async{
    try{
      Source urlSource = UrlSource(audioPath);
      print("urlSource : $urlSource");
      await audioPlayer.play(urlSource);
    }catch(e){

    }
  }
}
