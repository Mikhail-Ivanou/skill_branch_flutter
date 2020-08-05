import 'models/user.dart';
import 'models/user.dart';
import 'models/user.dart';
import 'models/user.dart';

class UserHolder {
  Map<String, User> users = {};

  void registerUser(String name, String phone, String email) {
    User user = User(name: name, phone: phone, email: email);

    if (!users.containsKey(user.login)) {
      users[user.login] = user;
    } else {
      throw Exception('A user with ths name already exists');
    }
  }

  User registerUserByEmail(String fullName, String email) {
    User user = User(name: fullName, email: email);

    if (!users.containsKey(user.login)) {
      users[user.login] = user;
      return user;
    } else {
      throw Exception('A user with ths email already exists');
    }
  }

  User registerUserByPhone(String fullName, String phone) {
    User user = User(name: fullName, phone: phone);

    if (!users.containsKey(user.login)) {
      users[user.login] = user;
      return user;
    } else {
      throw Exception('A user with ths phone already exists');
    }
  }

  User getUserByLogin(String login) {
    if (users.containsKey(login)) {
      return users[login];
    }
    return null;
  }

  void setFriends(String login, List<User> friends) {
    User user = getUserByLogin(login);
    if (user != null) {
      user.addFriends(friends);
    }
  }

  User findUserInFriends(String login, User friend) {
    User user = getUserByLogin(login);
    if (user != null && user.hasFriend(friend)) {
      return friend;
    } else {
      throw Exception("${user.login} is not a friend of the login");
    }
  }

  List<User> importUsers(List<String> list) {
    List<User> result = <User>[];
    for (var item in list) {
      result.add(User.fromCVS(item));
    }
    return result;
  }
}
