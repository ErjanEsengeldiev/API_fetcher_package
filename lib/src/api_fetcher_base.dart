import 'dart:io';
import 'dart:convert';

import 'package:api_fetcher/src/method_enums.dart';

class RestApi {
  void sendRequest(
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

        _addHeaders(headers: headers, format: format, request: request);

        request.write(jsonEncode(parameters));

        final response = await request.close();

        _checkStatusCode(response.statusCode);

        break;
      case RequestMethod.get:
        final request = await client.getUrl(parsedUri);

        final response = await request.close();

        _checkStatusCode(response.statusCode);
        break;

      case RequestMethod.delete:
        final request = await client.deleteUrl(parsedUri);

        _addHeaders(headers: headers, format: format, request: request);

        request.write(jsonEncode(parameters));

        final response = await request.close();

        _checkStatusCode(response.statusCode);
        break;

      case RequestMethod.put:
        final request = await client.putUrl(parsedUri);

        _addHeaders(headers: headers, format: format, request: request);

        request.write(jsonEncode(parameters));

        final response = await request.close();

        _checkStatusCode(response.statusCode);
        break;
    }
  }

  void _addHeaders(
      {required List? headers,
      required HttpClientRequest request,
      required String format}) {
    if (headers != null) {
      for (var i = 0; i < headers.length; i++) {
        request.headers.add(headers[i]["name"], headers[i]["value"]);
      }
    } else {
      request.headers.add('Content-type', 'application/$format; charset=UTF-8');
    }
  }

  void _checkStatusCode(int statusCode) {
    switch (statusCode) {
      case 200:
        print('Все прошло удачно');
        break;
      case 500:
        print('Произошла неизвестная ошибка');
        throw Exception('statusCode 500');

      case 400:
        print('Данные не верны');
        throw Exception('statusCode 400');

      case 403:
        print('У Вас нету доступа на данный сервис');
        throw Exception('statusCode 403');
    }
  }
}
