import 'dart:io';
import 'dart:convert';

import 'package:api_fetcher/src/method_enums.dart';

class RestApi {
  static void sendRequest(
      {required String url,
      required RequestMethod method,
      Map<String, dynamic>? parameters,
      List? headers,
      String format = 'json'}) async {
    final Uri? parsedUri = Uri.tryParse(url);
    final HttpClient client = HttpClient();

    if (parsedUri == null) {
      throw Exception('Incorrect Url');
    }

    switch (method) {
      case RequestMethod.post:
        final request = await client.postUrl(parsedUri);

        request.headers
            .add('Content-type', 'application/$format; charset=UTF-8');
        request.write(jsonEncode(parameters));

        final response = await request.close();

        if (response.statusCode != 200) {
          throw Exception('error');
        } else {
          print('success');
        }

        break;
      case RequestMethod.get:
        final request = await client.getUrl(parsedUri);

        final response = await request.close();

        if (response.statusCode != 200) {
          throw Exception('error');
        } else {
          print('success');
          print('resault : $json');
        }

        break;
      case RequestMethod.delete:
        final request = await client.deleteUrl(parsedUri);

        request.headers
            .add('Content-type', 'application/$format; charset=UTF-8');

        request.write(jsonEncode(parameters));

        final response = await request.close();

        if (response.statusCode != 200) {
          throw Exception('error');
        } else {
          print('success');
        }
        break;
      case RequestMethod.put:
        final request = await client.putUrl(parsedUri);

        request.headers
            .add('Content-type', 'application/$format; charset=UTF-8');

        request.write(jsonEncode(parameters));

        final response = await request.close();

        if (response.statusCode != 200) {
          throw Exception('error');
        } else {
          print('success');
        }
        break;
    }
  }
}
