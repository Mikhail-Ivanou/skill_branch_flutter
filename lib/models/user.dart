import '../string_util.dart';

enum LoginType { email, phone }

class User with UserUtils{
  String email;
  String phone;
  String _lastName;
  String _firstName;
  LoginType _type;

  List<User> friends = <User>[];

  User._({String firstName, String lastName, String phone, String email})
      : _firstName = firstName,
        _lastName = lastName,
        this.phone = phone,
        this.email = email {
    _type = email != null ? LoginType.email : LoginType.phone;
  }

  factory User({String name, String phone, String email}) {
    if (name.isEmpty) throw Exception('User name is empty');
    if (phone?.isEmpty == true && email?.isEmpty == true)
      throw Exception('phone or email is empty');

    return User._(
        firstName: _getFirstName(name),
        lastName: _getLastName(name),
        phone: checkPhone(phone),
        email: checkEmail(email));
  }

  static String _getLastName(String userName) => userName.split(" ")[1];

  static String _getFirstName(String userName) => userName.split(" ")[0];

  static String checkPhone(String phone) {
    if (phone == null) return null;
    String pattern = "^(?:[+0])?[0-9]{11}";
    phone = phone.replaceAll(RegExp("[^+\\d]"), "");

    if (!RegExp(pattern).hasMatch(phone)) {
      throw Exception(
          'Enter a valid phone number starting with a + and containing 11 digits');
    }
    return phone;
  }

  static String checkEmail(String email) {
    if (email == null) return null;
    String pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    if (!RegExp(pattern).hasMatch(email)) {
      throw Exception(
          'Enter a valid email address');
    }
    return email;
  }

  String get login {
    if (_type == LoginType.phone) return phone;
    return email;
  }

  String get name => "${capitalize(_firstName)} ${capitalize(_lastName)}";

  @override
  bool operator ==(Object object) {
    if (object == null) {
      return false;
    }
    if (object is User) {
      return _firstName == object._firstName &&
          _lastName == object._lastName &&
          (phone == object.phone || email == object.email);
    }
  }

  void addFriends(Iterable<User> newFriends) {
    friends.addAll(newFriends);
  }

  void removeFriend(User user) {
    friends.remove(user);
  }

  bool hasFriend(User user) {
    return friends.contains(user);
  }

  String get userInfo => '''
    name: $name
    email: $email
    firstName: $_firstName
    lastName: $_lastName
    friends: ${friends.toList()}
  ''';

  @override
  String toString() {
    return '''
    name: $name
    email: $email
    friends: ${friends.toList()}
  ''';
  }

  static fromCVS(String userCSV) {
    var lines = userCSV.split(";");
    return User(email: lines[1].trim(), phone: lines[2].trim(), name: lines[0].trim());
  }
}
