

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:jsonfile/model/photo.dart';
import 'package:jsonfile/network/network_request.dart';

final photoProvider = FutureProvider<List<Photo>>((ref) async {
  return fetchPhotos(http.Client());
});






