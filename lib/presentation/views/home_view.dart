import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/home_viewmodel.dart';
import '../viewmodels/upload_progress_provider.dart';
import 'video_player_view.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModelProvider);

    ref.listen<AsyncValue<List>>(homeViewModelProvider, (prev, next) {
      if (next.hasError) {
        final err = next.error;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${err.toString()}')),
        );
      }
    });

    final uploadProgress = ref.watch(uploadProgressProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('AI Safety Observation')),
      body: Column(
        children: [
          if (uploadProgress > 0 && uploadProgress < 1)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: LinearProgressIndicator(value: uploadProgress),
            ),
          Expanded(
            child: state.when(
              data: (list) {
                if (list.isEmpty) {
                  return const Center(child: Text('No video. Tap record button.'));
                }
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (ctx, idx) {
                    final video = list[idx];
                    return ListTile(
                      title: Text(video.title),
                      subtitle: Text(video.timestamp.toLocal().toString()),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () =>
                            ref.read(homeViewModelProvider.notifier).delete(video),
                      ),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => VideoPlayerView(videoPath: video.path),
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: ${e.toString()}')),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(
            heroTag: 'fab_record',
            onPressed: () => ref.read(homeViewModelProvider.notifier).captureAndSync(),
            icon: const Icon(Icons.videocam),
            label: const Text('Record'),
          ),
          const SizedBox(height: 12),
          FloatingActionButton.extended(
            heroTag: 'fab_gallery',
            onPressed: () => ref.read(homeViewModelProvider.notifier).pickAndSync(),
            icon: const Icon(Icons.video_library),
            label: const Text('Gallery'),
          ),
        ],
      ),
    );
  }
}
