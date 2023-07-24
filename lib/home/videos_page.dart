import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VideosPage extends StatefulWidget {
  const VideosPage({Key? key}) : super(key: key);

  @override
  _VideosPageState createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  List<Video> videos = [
    Video(
      title: '5 Things I Wish I Knew as a Beginner Runner | Common Mistakes',
      thumbnailUrl: 'https://img.youtube.com/vi/Gy3Po9Wc4nc/sddefault.jpg',
      videoUrl: 'https://www.youtube.com/watch?v=Gy3Po9Wc4nc',
      category: 'running',
    ),
    Video(
      title: 'How To Run Properly | Running Technique Explained',
      thumbnailUrl: 'https://img.youtube.com/vi/_kGESn8ArrU/sddefault.jpg',
      videoUrl: 'https://www.youtube.com/watch?v=_kGESn8ArrU',
      category: 'running',
    ),
    Video(
      title: 'HOW TO RUN A FASTER 5K | With Jakob Ingebrigtsen',
      thumbnailUrl: 'https://img.youtube.com/vi/nDsFox7g0fo/sddefault.jpg',
      videoUrl: 'https://www.youtube.com/watch?v=nDsFox7g0fo',
      category: 'running',
    ),
    Video(
      title:
          'HOW TO IMPROVE & INCREASE RUNNING CADENCE to become a FASTER & more EFFICIENT RUNNER!',
      thumbnailUrl: 'https://img.youtube.com/vi/eacl52qzr4E/sddefault.jpg',
      videoUrl: 'https://www.youtube.com/watch?v=eacl52qzr4E',
      category: 'running',
    ),
    Video(
      title: 'How I Balance Weight Lifting and Running',
      thumbnailUrl: 'https://img.youtube.com/vi/ZSbxbdpoogg/sddefault.jpg',
      videoUrl: 'https://www.youtube.com/watch?v=ZSbxbdpoogg',
      category: 'lifting',
    ),
    Video(
      title: 'How To Do A Deadlift For BEGINNERS',
      thumbnailUrl: 'https://img.youtube.com/vi/vRKDvt695pg/sddefault.jpg',
      videoUrl: 'https://www.youtube.com/watch?v=vRKDvt695pg',
      category: 'lifting',
    ),
    Video(
      title: 'Squat Tutorial: How to Squat Properly',
      thumbnailUrl: 'https://img.youtube.com/vi/r4MzxtBKyNE/sddefault.jpg',
      videoUrl: 'https://www.youtube.com/watch?v=r4MzxtBKyNE',
      category: 'lifting',
    ),
  ];

  String filterCategory = '';

  @override
  Widget build(BuildContext context) {
    List<Video> filteredVideos = filterCategory.isEmpty
        ? videos
        : videos.where((video) => video.category == filterCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Videos'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: filterCategory,
              onChanged: (newValue) {
                setState(() {
                  filterCategory = newValue!;
                });
              },
              items: const [
                DropdownMenuItem(
                  value: '',
                  child: Text('All Videos'),
                ),
                DropdownMenuItem(
                  value: 'running',
                  child: Text('Running Videos'),
                ),
                DropdownMenuItem(
                  value: 'lifting',
                  child: Text('Lifting Videos'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredVideos.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: Image.network(filteredVideos[index].thumbnailUrl),
                    title: Text(filteredVideos[index].title),
                    onTap: () {
                      launch(filteredVideos[index].videoUrl);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Video {
  final String title;
  final String thumbnailUrl;
  final String videoUrl;
  final String category;

  Video({
    required this.title,
    required this.thumbnailUrl,
    required this.videoUrl,
    required this.category,
  });
}
