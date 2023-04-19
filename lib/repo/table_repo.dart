

import 'dart:convert';
import 'dart:developer';

import 'package:meal_mentor/models/meal_mentor_table.dart';

import '../utils/apis.dart';
import '../utils/http_request.dart';
import '../utils/storage_keys.dart';

import 'package:http/http.dart' as http;

class TableRepo {
  static Future<void> getTable({
    required Function(List<MealMentorTable> category) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var token = StorageHelper.getToken();
      var headers = {
        "Accept": "application/json",
        "Authorization": token.toString()
      };

      http.Response response = await HttpRequest.get(
        Uri.parse(Api.tables),
        headers: headers,
      );
      dynamic data = json.decode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        List<MealMentorTable> categories =
            tableFromJson(data["data"]);
        onSuccess(categories);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      onError("Sorry! something went wrong");
    }
  }
}