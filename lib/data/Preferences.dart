import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/User.dart';

class Preferences {
  // User Userload = User.Empty();

  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> userMap =
        jsonDecode(prefs.getString("user")!); // ! quita null
    // userLoad = "f" as User;
    // Userload = User.fromJson(userMap);
    return userMap;
  }

  void setUser(User user) async {
    //  local store
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user", jsonEncode(user));
    // print("SaveUser");
    String json = jsonEncode(user);

    print(json);
  }

  Preferences.Empty();
}
