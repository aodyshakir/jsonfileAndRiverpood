import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'state/state_management.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photos = ref.watch(photoProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo'),
      ),
      body: photos.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Text('Error: $err'),
        data: (photos) => ListView.builder(
          itemCount: photos.length,
          itemBuilder: (context, index) {
            final photo = photos[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(photo),
                  ),
                );
              },
              child: Card(
                color: Colors.grey[200],
                child: ListTile(
                  title: Text('${photo.title}'),
                  subtitle: Text('${photo.url}'),
                  leading: Image.network('${photo.thumbnailUrl}'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class DetailPage extends ConsumerWidget {
  final photo;
  const DetailPage(this.photo, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final  photos = ref.watch(photoProvider);
    

    return Scaffold(
      appBar: AppBar(),
      body: photos.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Text('Error: $err'),
        data: (photos) => Padding(
          padding: const EdgeInsets.all(30),
          child: ListView(
            children: [
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  '${photo.title}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Card(
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: SizedBox(
                    height: 600,
                    width: 600,
                    child: Image.network('${photo.url}'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
