import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VideosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Video> videos = [
      Video(
        title: '5 Things I Wish I Knew as a Beginner Runner | Common Mistakes',
        thumbnailUrl: 'https://img.youtube.com/vi/Gy3Po9Wc4nc/sddefault.jpg',
        videoUrl: 'https://www.youtube.com/watch?v=Gy3Po9Wc4nc',
      ),
      Video(
        title: 'How To Run Properly | Running Technique Explained',
        thumbnailUrl: 'https://img.youtube.com/vi/_kGESn8ArrU/sddefault.jpg',
        videoUrl: 'https://www.youtube.com/watch?v=_kGESn8ArrU',
      ),
      Video(
        title: 'HOW TO RUN A FASTER 5K | With Jakob Ingebrigtsen',
        thumbnailUrl: 'https://img.youtube.com/vi/nDsFox7g0fo/sddefault.jpg',
        videoUrl: 'https://www.youtube.com/watch?v=nDsFox7g0fo',
      ),
      Video(
        title: 'HOW TO IMPROVE & INCREASE RUNNING CADENCE to become a FASTER & more EFFICIENT RUNNER!',
        thumbnailUrl: 'https://img.youtube.com/vi/eacl52qzr4E/sddefault.jpg',
        videoUrl: 'https://www.youtube.com/watch?v=eacl52qzr4E',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Videos'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: videos.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: Image.network(videos[index].thumbnailUrl),
                  title: Text(videos[index].title),
                  onTap: () {
                    launch(videos[index].videoUrl);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class Video {
  final String title;
  final String thumbnailUrl;
  final String videoUrl;

  Video({
    required this.title,
    required this.thumbnailUrl,
    required this.videoUrl,
  });
}
