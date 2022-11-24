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

        switch (response.statusCode) {
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

        break;
      case RequestMethod.get:
        final request = await client.getUrl(parsedUri);

        final response = await request.close();

        switch (response.statusCode) {
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
        break;

      case RequestMethod.delete:
        final request = await client.deleteUrl(parsedUri);

        request.headers
            .add('Content-type', 'application/$format; charset=UTF-8');

        request.write(jsonEncode(parameters));

        final response = await request.close();

        switch (response.statusCode) {
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
        break;

      case RequestMethod.put:
        final request = await client.putUrl(parsedUri);

        request.headers
            .add('Content-type', 'application/$format; charset=UTF-8');

        request.write(jsonEncode(parameters));

        final response = await request.close();

        switch (response.statusCode) {
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
        break;
    }
  }
}
