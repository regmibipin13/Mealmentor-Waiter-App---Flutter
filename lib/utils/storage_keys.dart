// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:developer';

import 'package:get_storage/get_storage.dart';

import '../models/user.dart';

class StorageKeys {
  static const String USER = "user";
  static const String ACCESS_TOKEN = "accessToken";
}

class StorageHelper {
  static getToken() {
    try {
      final box = GetStorage();
      String token = box.read(StorageKeys.ACCESS_TOKEN);
      return token;
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      return null;
    }
  }

  static User? getUser() {
    try {
      final box = GetStorage();
      User user = User.fromJson(json.decode(box.read(StorageKeys.USER)));
      return user;
    } catch (e, s) {
      log("Failed fetch customer");
      return null;
    }
  }
}
