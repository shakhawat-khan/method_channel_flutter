import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List ringtones = [];
  late AudioPlayer player = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Method Channel'),
      ),
      body: Column(
        children: [
          if (ringtones.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: ringtones.length,
                itemBuilder: (context, index) {
                  final ringtone = ringtones[index];
                  return Card(
                    child: ListTile(
                      onTap: () async {
                        AudioPlayer audioPlayer = AudioPlayer();
                        await audioPlayer.setSource(
                          DeviceFileSource(
                            '/system/media/Ringtones/Music/$ringtone.wav',
                          ),
                        );
                      },
                      title: Text(ringtone),
                    ),
                  );
                },
              ),
            ),
          ElevatedButton(
              onPressed: () async {
                const channel = MethodChannel('flutter_channel');
                ringtones = await channel.invokeMethod('getRingtones');

                setState(() {});
              },
              child: const Text('Get Ringtones'))
        ],
      ),
    );
  }
}
