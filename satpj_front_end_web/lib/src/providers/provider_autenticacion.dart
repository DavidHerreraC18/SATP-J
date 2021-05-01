import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderAuntenticacion {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static String uid;
  static String name;
  static String userEmail;

  /// For checking if the user is already signed into the
  /// app using Google Sign In
  static Future getUser() async {
    await Firebase.initializeApp();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool authSignedIn = prefs.getBool('auth') ?? false;

    final User user = _auth.currentUser;

    if (authSignedIn == true) {
      if (user != null) {
        uid = user.uid;
        name = user.displayName;
        userEmail = user.email;
      }
    }
  }

  static Future<String> registerWithEmailPassword(
      String email, String password) async {
    await Firebase.initializeApp();

    final UserCredential userCredential =
        await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final User user = userCredential.user;

    if (user != null) {
      // checking if uid or email is null
      assert(user.uid != null);
      assert(user.email != null);

      uid = user.uid;
      userEmail = user.email;

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      var token = await user.getIdToken();
      print("TOKEN: " + token);

      print('Successfully registered, User UID: ${user.uid}');
      return user.uid;
    }

    return null;
  }

  static Future<String> signInWithEmailPassword(
      String email, String password) async {
    await Firebase.initializeApp();

    final UserCredential userCredential =
        await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final User user = userCredential.user;

    if (user != null) {
      // checking if uid or email is null
      assert(user.uid != null);
      assert(user.email != null);

      uid = user.uid;
      userEmail = user.email;

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      var token = await user.getIdToken();
      print("TOKEN: " + token);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('auth', true);

      return 'Successfully logged in, User UID: ${user.uid}';
    }

    return null;
  }

  static Future<String> signOut() async {
    await _auth.signOut();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('auth', false);

    uid = null;
    userEmail = null;

    return 'User signed out';
  }

  static Future<String> extractToken() async {
    User user = _auth.currentUser;
    return user.getIdToken(true);
  }

  static Future<Map<String, String>> accessSecureResource() async {
    Map<String, String> headers = {
      "Authorization": "Bearer " + await extractToken(),
      "Cache-Control": "no-cache",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
      "Connection": "keep-alive"
    };
    /*
    print("Token " + token);
    http.Response response =
        await http.get(Uri.http(url, "/usuarios/" + uid), headers: headers);
    int statusCode = response.statusCode;
    if (statusCode != 200) {
      print("Could not get input from server");
      return "Could not get input from server";
    }
    return response.body.toString();
    */
    return headers;
  }
}
