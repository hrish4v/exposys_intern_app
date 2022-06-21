import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> LoginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some problem occured";
    try {
      if (email != Null && password != Null) {
        await auth.signInWithEmailAndPassword(email: email, password: password);
        res = "Success";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> addData(
      {required String internship,
      required String name,
      required String branch,
      required String email,
      required String collegeName,
      required String number,
      required String tenthPer,
      required String twelthPer,
      required String location,
      required String months}) async {
    String res = "Waiting";
    try {
      Map<String, dynamic> mp = await firestore
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection("internships")
          .get() as Map<String, dynamic>;
      if (mp.containsKey(internship)) {
        res = "You have already applied for this intership";
        return res;
      } else {
        await firestore
            .collection("users")
            .doc(auth.currentUser!.uid)
            .collection("internships")
            .doc(internship)
            .set({
          "name": name,
          "branch": branch,
          "email": email,
          "college": collegeName,
          "email": email,
          "phone no": number,
          "10th percent": tenthPer,
          "12th percent": twelthPer,
          "location": location,
          "duration": months,
        });
        res = "success";
        return res;
      }
    } catch (e) {
      res = e.toString();
      print(res);
    }
    return res;
  }

  Future<String> SignInUser({
    required String email,
    required String name,
    required String password,
  }) async {
    String res = "Some error occured";
    try {
      if (email != Null && name != Null && password != Null) {
        await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        res = "Success";
      }
    } catch (e) {
      res = e.toString();
    }
    print(res);
    return res;
  }
}
