import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qtecsolutiontask/components.dart';
import 'package:qtecsolutiontask/model/play_list.dart';
import 'package:qtecsolutiontask/providers/homepage_screen_provider.dart';
import 'package:qtecsolutiontask/views/widget/custom_text_field_widget.dart';
import 'package:qtecsolutiontask/views/widget/on_process_button_widget.dart';
import 'package:video_player/video_player.dart';
import 'package:timeago/timeago.dart' as timeago;

class VideoDetailScreen extends StatelessWidget {
  static const routeName = '/videoDetailPage';

  const VideoDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    if (args == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Video Detail'),
        ),
        body: const Center(
          child: Text('Arguments missing'),
        ),
      );
    }

    final Results video = args['video'] as Results;
    final VideoPlayerController videoPlayerController = args['videoPlayerController'] as VideoPlayerController;
    final HomePageScreenProvider provider = args['provider'] as HomePageScreenProvider;
    final int index = args['index'] as int;

    return Scaffold(
      appBar: AppBar(
        title: Text('${video.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // .............................. call method widget
            _videoShowerWidget(videoPlayerController, context, video, provider, index),

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
                    child: Icon(Icons.more_vert),
                  )
                ],
              ),
            ),
            SizedBox(height: defaultPadding / 2),
            //........................................ call method widget
            _likeShareRowButtons(context),

            Padding(
              padding:  EdgeInsets.all(defaultPadding / 3),
              child: Row(
                children: [
                  CircleAvatar(
                    foregroundImage: AssetImage('images/1.png'),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(
                        'Mega Bangla Tv',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Theme.of(context).colorScheme.onBackground, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '3M Subsribers',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onBackground),
                      ),
                    ),
                  ),
                  OnProcessButtonWidget(
                    backgroundColor: const Color(-13068036),
                    expanded: false,
                    child: Row(
                      children: [
                        Icon(Icons.add),
                        Text(
                          'Subsribe',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onBackground),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider(
              color: Theme.of(context).colorScheme.onInverseSurface
            ),
            SizedBox(height: defaultPadding / 3),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Comments  7.5k',style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onBackground), ),
                  SvgPicture.asset('images/frame.svg')
                ],
              ),
            ),
            SizedBox(height: defaultPadding / 3),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding / 3),
              child: CustomTextFormField(
                hintText: 'Add comments',
                hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onBackground),
                suffixIcon: Icon(Icons.send)
              ),
            )
          ],
        ),
      ),
    );
  }

  Row _likeShareRowButtons(BuildContext context) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OnProcessButtonWidget(
                contentPadding: EdgeInsets.all(defaultPadding / 3),
                backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
                expanded: false,
                child: Column(
                  children: [
                    SvgPicture.asset('images/love.svg'),
                    Text(
                      'MASH ALLAH(12k)',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    )
                  ],
                ),
              ),
              OnProcessButtonWidget(
                contentPadding: EdgeInsets.all(defaultPadding / 3),
                backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
                expanded: false,
                child: Column(
                  children: [
                    SvgPicture.asset('images/like.svg'),
                    Text(
                      'LIKE(12k)',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    )
                  ],
                ),
              ),
              OnProcessButtonWidget(
                contentPadding: EdgeInsets.all(defaultPadding / 3),
                backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
                expanded: false,
                child: Column(
                  children: [
                    SvgPicture.asset('images/share.svg'),
                    Text(
                      'SHARE',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    )
                  ],
                ),
              ),
              OnProcessButtonWidget(
                contentPadding: EdgeInsets.all(defaultPadding / 3),
                backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
                expanded: false,
                child: Column(
                  children: [
                    SvgPicture.asset('images/report.svg'),
                    Text(
                      'REPORT',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    )
                  ],
                ),
              ),
            ],
          );
  }

  Widget _videoShowerWidget(VideoPlayerController videoPlayerController, BuildContext context, Results video, HomePageScreenProvider provider, int index) {
    return Stack(
            children: [
              Container(
                height: defaultPadding * 8.5,
                width: double.infinity,
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: VideoPlayer(videoPlayerController),
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
          );
  }
}
