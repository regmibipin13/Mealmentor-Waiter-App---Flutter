import 'dart:convert';
import 'dart:developer';

import 'package:meal_mentor/models/past_order.dart';

import 'package:http/http.dart' as http;
import '../utils/apis.dart';
import '../utils/http_request.dart';
import '../utils/storage_keys.dart';

class MealMentorOrderRepo {
  static Future<void> getPastOrder({
    required Function(
      List<PastOrder> activeOrders,
      List<PastOrder> pastOrders,
    )
        onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var token = StorageHelper.getToken();
      var headers = {
        "Accept": "application/json",
        "Authorization": token.toString()
      };

      http.Response response = await HttpRequest.get(
        Uri.parse(Api.pastOrders),
        headers: headers,
      );

      dynamic data = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        log("past order");

        List<PastOrder> activeOrders =
            pastOrderFromJson(data["activeOrders"]["data"]);

        List<PastOrder> pastOrders =
            pastOrderFromJson(data["pastOrders"]["data"]);

        onSuccess(activeOrders, pastOrders);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      onError("Sorry! something went wrong");
    }
  }

  static Future<void> postOrder({
    required var items,
    required Function() onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var token = StorageHelper.getToken();
      // log(token.toString());
      var headers = {
        "Accept": "application/json",
        "Authorization": token.toString(),
        "Content-Type": "application/json",
      };

      var body = json.encode(items);
      log('--------json enconded ---------$body');
      http.Response response = await http.post(Uri.parse(Api.postOrder),
          headers: headers, body: body);

      dynamic data = json.decode(response.body);
      print(data);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        log("past order");
        onSuccess();
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      onError("Sorry! something went wrong");
    }
  }

  static Future<void> removeRemaimingOrderItem({
    required int tableId,
    required int itemId,
    required Function() onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var token = StorageHelper.getToken();
      var headers = {
        "Accept": "application/json",
        "Authorization": token.toString()
      };
      var body = {
        "item_id": itemId.toString(),
      };

      var url = Uri.parse('${Api.postOrder}/$tableId/items-remove');

      print(url.toString());
      http.Response response =
          await http.post(url, headers: headers, body: body);

      dynamic data = json.decode(response.body);
      print(data);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        log("past order");
        onSuccess();
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
