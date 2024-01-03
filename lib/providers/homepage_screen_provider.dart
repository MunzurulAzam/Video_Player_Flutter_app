import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qtecsolutiontask/model/play_list.dart';
import 'package:qtecsolutiontask/services/api/api_services.dart';
import 'package:video_player/video_player.dart';

class HomePageScreenProvider extends ChangeNotifier {
  late VideoPlayerController _videoPlayerController;

  final ApiServices _apiServices = ApiServices();

  List<Results> _videoList = [];
  List<Results> get videoList => _videoList;

  List<VideoPlayerController?> _videoPlayerControllers = [];
  List<VideoPlayerController?> get videoPlayerControllers => _videoPlayerControllers;

  int _pageNumber = 1;
  int get pageNumber => _pageNumber;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ScrollController scrollController = ScrollController();

  HomePageScreenProvider() {
    initializeScrollListener();
  }

  void initializeScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (!_isLoading) {
          fetchTrendingVideos(page: _pageNumber+=1); //................................................ Fetch next page
        }
      }
    });
  }

  Future<void> fetchTrendingVideos({int page = 1}) async {
    try {
      _isLoading = true;
      notifyListeners();

      final PlayList playlist = await _apiServices.fetchTrendingVideos(page);
      _videoList.addAll(playlist.results ?? []);

      //......................................................... Initialize video player controllers with url  from the API
      for (int i = 0; i < playlist.results!.length; i++) {
        _videoPlayerControllers.add(
          VideoPlayerController.networkUrl(Uri.parse(playlist.results![i].manifest ?? '')),
        );
        await _videoPlayerControllers[i]!.initialize();
      }

      _pageNumber = page;
    } catch (e) {
      print('Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void togglePlayPause(int index) {
    if (_videoPlayerControllers[index]?.value.isPlaying ?? false) {
      _videoPlayerControllers[index]?.pause();
    } else {
      _videoPlayerControllers[index]?.play();
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }
}




