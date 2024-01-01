import 'package:flutter/material.dart';
import 'package:qtecsolutiontask/components.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    // TODO: implement initState
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Play List'),
        ),
        body: ListView.builder(
          itemCount: 10, //.......................................................... for test
          itemBuilder: (BuildContext context, int index) => Column(
            children: [
              Stack(
                children: [
                  // Image.network(
                  //   // todo ...................................... set value from api with video player package
                  //   'https://www.leadquizzes.com/images/youtube-logo.png',
                  //   height: defaultPadding * 8.5,
                  //   width: double.infinity,
                  //   fit: BoxFit.cover,
                  // ),
                  Container(
                    height: defaultPadding * 8.5,
                    width: double.infinity,
                    child: _videoPlayerController.value.isInitialized
                        ? AspectRatio(
                      aspectRatio: _videoPlayerController.value.aspectRatio,
                      child: VideoPlayer(_videoPlayerController),
                    )
                        : Container(),
                  ),
                  Positioned(
                    bottom: defaultPadding / 3,
                    right: defaultPadding / 3,
                    child: Container(
                      padding: EdgeInsets.all(defaultPadding / 6),
                      color: Theme.of(context).colorScheme.onBackground,
                      child: Text(
                        '8.20',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(defaultPadding / 2),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => print('Navigate to another page'),
                      child: CircleAvatar(
                        foregroundImage: NetworkImage(
                            // todo ...................................... set value from api
                            'https://www.clipartmax.com/png/small/458-4583206_youtube-channel-icon-request-by-lovedakota-on-deviantart-logo-channel-youtube-kartun.png'),
                      ),
                    ),
                    SizedBox(
                      width: defaultPadding / 3,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              // todo ...................................... set value from api
                              'aaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbccccccccc',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onBackground),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              // todo ...................................... set value from api
                              'Munzurul Azam * 10k views * 6 days ago',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onBackground),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => print('Ready for navigate'),
                      child: Icon(Icons.more_vert),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _videoPlayerController.dispose();
  }
}
