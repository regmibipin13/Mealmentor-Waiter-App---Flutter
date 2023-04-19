import 'dart:convert';
import 'dart:developer';

import 'package:meal_mentor/utils/http_request.dart';

import 'package:http/http.dart' as http;
import '../models/meal_mentor_category.dart';
import '../models/meal_mentor_item.dart';
import '../utils/apis.dart';
import '../utils/storage_keys.dart';

class ItemRepo {
  static Future<void> getCategory({
    required Function(List<MealMentorCategory> category) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var token = StorageHelper.getToken();
      var headers = {
        "Accept": "application/json",
        "Authorization": token.toString()
      };

      http.Response response = await HttpRequest.get(
        Uri.parse(Api.item),
        headers: headers,
      );
      dynamic data = json.decode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        List<MealMentorCategory> categories =
            itemCategoryFromJson(data["data"]);
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

  static Future<void> getItemByCategory({
    required int id,
    required Function(List<MealMentorItem> banners) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var token = StorageHelper.getToken();
      var headers = {
        "Accept": "application/json",
        "Authorization": token.toString()
      };
      var url = Uri.parse('${Api.itemByCategory}=$id');

      http.Response response = await HttpRequest.get(
        url,
        headers: headers,
      );

      dynamic data = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        List<MealMentorItem> banners = categoryFromJson(data["data"]);
        onSuccess(banners);
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
