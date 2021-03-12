// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
//
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final FirebaseAuth _auth = FirebaseAuth.instance;
//final GoogleSignIn googleSignIn = GoogleSignIn();

String uid;
String name;
String userEmail;
String imageUrl;


String url = 'www.googleapis.com';

/// For checking if the user is already signed into the
/// app using Google Sign In
Future getUser() async {
  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool authSignedIn = prefs.getBool('auth') ?? false;

  final User user = _auth.currentUser;

  if (authSignedIn == true) {
    if (user != null) {
      uid = user.uid;
      name = user.displayName;
      userEmail = user.email;
      imageUrl = user.photoURL;
    }
  }
}

Future<String> registerWithEmailPassword(String email, String password) async {
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

    return 'Successfully registered, User UID: ${user.uid}';
  }

  return null;
}

Future<String> signInWithEmailPassword(String email, String password) async {
  await Firebase.initializeApp();

  final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
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

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('auth', true);

    return 'Successfully logged in, User UID: ${user.uid}';
  }

  return null;
}

Future<String> signOut() async {
  await _auth.signOut();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('auth', false);

  uid = null;
  userEmail = null;

  return 'User signed out';
}

  Future<String> extractTokenAndAccessSecureResource() async {
    var token = await extractToken();
    return await accessSecureResource(token);
  }

  Future<String> extractToken() async{
    //FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User user =  _auth.currentUser;
    //IdTokenResult token =  user.getIdToken();
    return user.getIdToken(true);
  }

  Future<String> accessSecureResource(token) async {

    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization" :"Bearer " + token
    };
    print("Token "+ token);
    //Response response = await get(Uri.http(url,"/usuarios",{"id": uid}), headers: headers);
    http.Response response = await http.get(Uri.http(url,"/books/v1/volumes"));
    int statusCode = response.statusCode;
    if(statusCode != 200){
      print("Could not get input from server");
      return "Could not get input from server";
    }
    print("Entro!!");
    return response.body.toString();
  }

