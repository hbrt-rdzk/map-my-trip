import 'package:flutter/material.dart';
import 'package:mapmytrip/services/firestore.dart';
import 'package:mapmytrip/services/models.dart';
import 'package:mapmytrip/widgets/bottom_nav.dart';

import '../widgets/drawer.dart';
import '../widgets/error.dart';
import '../widgets/loading.dart';
import 'topic_item.dart';

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Topic>>(
        future: FirestoreService().getTopics(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          } else if (snapshot.hasError) {
            return Center(
                child: ErrorMessage(message: snapshot.error.toString()));
          } else if (snapshot.hasData) {
            var topics =
                snapshot.data!; //assertion operator to make sure its not null

            return Scaffold(
              drawer: TopicDrawer(
                topics: topics
              ),
              appBar: AppBar(
                backgroundColor: Colors.orange,
                title: const Text('Topics'),
              ),
              body: GridView.count(
                  //adds fixed number of items in the grid view
                  primary: false,
                  padding: const EdgeInsets.all(10.0),
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  children: topics.map((topic) => TopicItem(topic: topic)).toList()),
            );
          } else {
            return const Text(
                'No topics found in firestore, try checking your database');
          }
        });
  }
}
