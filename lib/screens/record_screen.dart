import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';

class RecordScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  bool isRecording = false;
  final player = AudioPlayer();
  final record = AudioRecorder();
  bool recorded = false;
  final path =
      '/storage/emulated/0/Download/myFile4.m4a'; // Start recording to file

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Record"),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.mic_none, size: 200, color: Colors.green),
            SizedBox(height: 50),
            recorded
                ? TextButton(
                    onPressed: () async {
                      await player.play(DeviceFileSource(path));
                    },
                    child: Text("Play Audio"),
                  )
                : SizedBox(height: 20),

            TextButton(
              onPressed: () async {
                if (await record.hasPermission() && !isRecording) {
                  await record.start(const RecordConfig(), path: path);
                  // ... or to stream
                  // final stream = await record.startStream(
                  //   const RecordConfig(encoder: AudioEncoder.pcm16bits),
                  // );
                  setState(() {
                    isRecording = true;
                  });
                } else if (isRecording == true) {
                  // Stop recording...
                  final path = await record.stop();
                  // // ... or cancel it (and implicitly remove file/blob).
                  // await record.cancel();
                  // record.dispose();
                  setState(() {
                    isRecording = false;
                    recorded = true;
                  });
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: isRecording ? Colors.red : Colors.green,
                foregroundColor: Colors.white,
                fixedSize: Size(200, 50),
              ),
              child: Text(isRecording ? "Stop" : "Record Audio"),
            ),
          ],
        ),
      ),
    );
  }
}
