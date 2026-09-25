import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_features_app/screens/google_map_screen.dart';
import 'package:flutter_device_features_app/widgets/navigation_text_button.dart';
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
  // Keep one known output path so the playback action can open the latest take.
  final path = '/storage/emulated/0/Download/myFile4.m4a';

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
                      // Playback is exposed only after stop() confirms a file
                      // was produced, so the player has a valid source path.
                      await player.play(DeviceFileSource(path));
                    },
                    child: Text("Play Audio"),
                  )
                : SizedBox(height: 20),

            TextButton(
              onPressed: () async {
                // The recorder package requests microphone access before capture.
                if (await record.hasPermission() && !isRecording) {
                  // Saving directly to the shared Downloads location makes the
                  // demo recording visible outside the app on Android.
                  await record.start(const RecordConfig(), path: path);

                  setState(() {
                    isRecording = true;
                  });
                } else if (isRecording == true) {
                  // Stop recording...
                  await record.stop();

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
            NavigationTextButton(
              text: "To Google Map Screen",
              destination: GoogleMapScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
