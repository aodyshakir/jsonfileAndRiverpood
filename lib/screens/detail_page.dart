
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../state/state_management.dart';

class DetailPage extends ConsumerWidget {
  final photo;
  const DetailPage(this.photo, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photos = ref.watch(photoProvider);

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
