import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qtecsolutiontask/components.dart';
import 'package:qtecsolutiontask/model/play_list.dart';
import 'package:qtecsolutiontask/providers/homepage_screen_provider.dart';
import 'package:qtecsolutiontask/views/video_details_screen.dart';
import 'package:video_player/video_player.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeScreen extends StatefulWidget {
  static const routeName = '/';

  const HomeScreen({Key? key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<void> _fetchData;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<HomePageScreenProvider>(context, listen: false);
    _fetchData = provider.fetchTrendingVideos();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomePageScreenProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Play List'),
      ),
      body: FutureBuilder<void>(
        future: _fetchData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              controller: provider.scrollController,
              itemCount: provider.videoList.length,
              itemBuilder: (BuildContext context, int index) {
                if (provider.videoPlayerControllers.length > index && provider.videoPlayerControllers[index] != null) {
                  Results video = provider.videoList[index];
                  VideoPlayerController? videoPlayerController = provider.videoPlayerControllers[index];

                  return InkWell(
                    onTap: () => Navigator.pushNamed(
                      context,
                      VideoDetailScreen.routeName,
                      arguments: {
                        'video': video,
                        'videoPlayerController': videoPlayerController,
                        'provider': provider,
                        'index': index,
                      },
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: defaultPadding * 8.5,
                              width: double.infinity,
                              child: AspectRatio(
                                aspectRatio: 16 / 9,
                                child: VideoPlayer(videoPlayerController!),
                              ),
                            ),
                            Positioned(
                              bottom: defaultPadding / 3,
                              right: defaultPadding / 3,
                              child: Container(
                                padding: EdgeInsets.all(defaultPadding / 6),
                                color: Theme.of(context).colorScheme.onBackground,
                                child: Text(
                                  '${video.duration}',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: Theme.of(context).colorScheme.onPrimary,
                                      ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: defaultPadding / 3,
                              left: defaultPadding / 3,
                              child: Container(
                                padding: EdgeInsets.all(defaultPadding / 6),
                                color: Theme.of(context).colorScheme.onPrimary,
                                child: InkWell(
                                  onTap: () {
                                    provider.togglePlayPause(index);
                                  },
                                  child: Icon(
                                    videoPlayerController.value.isPlaying ? Icons.pause_circle_outline : Icons.play_arrow_outlined,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
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
                                  foregroundImage: NetworkImage(video.channelImage ?? ''),
                                ),
                              ),
                              SizedBox(width: defaultPadding / 3),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        '${video.title}',
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                              color: Theme.of(context).colorScheme.onBackground,
                                            ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        '${video.channelName} • ${video.viewers}k •  ${video.dateAndTime == null || video.dateAndTime!.isEmpty ? "" : timeago.format(DateTime.parse(video.dateAndTime!))}',
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              color: Theme.of(context).colorScheme.onBackground,
                                            ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () => print('Ready for navigate'),
                                child: const Icon(Icons.more_vert),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            );
          }
        },
      ),
    );
  }
}
