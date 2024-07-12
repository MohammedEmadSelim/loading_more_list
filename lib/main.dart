import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SimpleLoadingMoreList ',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:  SimpleLoadingMoreList(),
    );
  }
}

class SimpleSource extends LoadingMoreBase<String> {
  List<String> items = ["item 1", "item 2", "item 3", "item 4", "item 5"];
  int currentIndex = 0;

  @override
  Future<bool> loadData([bool isLoadMoreAction = false]) async {
    if (currentIndex >= items.length) return false;

    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    add(items[currentIndex]);
    currentIndex++;
    return true;
  }

  @override
  bool get hasMore => currentIndex < items.length;
}

class SimpleLoadingMoreList extends StatelessWidget {

  final SimpleSource source = SimpleSource();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Loading More List Example')),
      body: LoadingMoreList<String>(
        ListConfig<String>(
          itemBuilder: (BuildContext context, String item, int index) {
            return ListTile(
              title: Text(item),
            );
          },
          sourceList: source,
          padding: EdgeInsets.all(8.0),
          indicatorBuilder: (context, status) {
            switch (status) {
              case IndicatorStatus.loadingMoreBusying:
                return CircularProgressIndicator();
              case IndicatorStatus.error:
                return Text('Error occurred while loading');
              case IndicatorStatus.noMoreLoad:
                return Text('No more items');
              default:
                return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
