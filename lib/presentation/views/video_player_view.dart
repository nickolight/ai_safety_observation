import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

import '../viewmodels/video_player_viewmodel.dart';

class VideoPlayerView extends ConsumerStatefulWidget {
  final String videoPath;

  const VideoPlayerView({super.key, required this.videoPath});

  @override
  ConsumerState<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends ConsumerState<VideoPlayerView> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    _videoController = VideoPlayerController.file(File(widget.videoPath));
    await _videoController!.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoController!,
      autoPlay: false,
      looping: false,
    );
    setState(() {});
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final annotations = ref.watch(videoPlayerViewModelProvider(widget.videoPath));

    return Scaffold(
      appBar: AppBar(title: const Text('Video and annotations')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_videoController?.value.isInitialized == true)
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Chewie(controller: _chewieController!),
                  )
                else
                  const Center(child: CircularProgressIndicator()),

                const SizedBox(height: 12),
                const Text(
                  'Annotations:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                annotations.when(
                  data: (list) {
                    if (list.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text('Annotations are missing'),
                      );
                    }
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: list.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (ctx, i) {
                        final a = list[i];
                        return ListTile(
                          leading: const Icon(Icons.label_important_outlined),
                          title: Text(a.label),
                          subtitle: Text(
                            '${a.startTimestamp.inSeconds}s – ${a.endTimestamp.inSeconds}s',
                          ),
                          onTap: () {
                            _videoController?.seekTo(a.startTimestamp);
                            _videoController?.play();
                          },
                        );
                      },
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(child: Text('Error: ${e.toString()}')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
