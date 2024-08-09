import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart'; // Importa para cambiar la orientación

class VrVideoScreen extends StatefulWidget {
  final String videoUrl;

  const VrVideoScreen({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VrVideoScreenState createState() => _VrVideoScreenState();
}

class _VrVideoScreenState extends State<VrVideoScreen> {
  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
    _printReceivedUrl(); // Imprime la URL recibida
    // Cambiar la orientación a paisajística
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
    ]);
  }

  void _initializePlayer() {
    String? videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
    if (videoId != null) {
      _youtubeController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      );
    } else {
      print("Error: URL de YouTube no válida.");
    }
  }

  void _printReceivedUrl() {
    print("URL recibida: ${widget.videoUrl}"); // Imprime la URL en la consola
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    // Restablecer la orientación a la predeterminada
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Ver en VR'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: YoutubePlayer(
          controller: _youtubeController,
          showVideoProgressIndicator: true,
        ),
      ),
    );
  }
}
