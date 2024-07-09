// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:rider/AllScreens/mainScreen.dart';
// import 'package:rider/AllScreens/registrationScreen.dart';
// import 'package:rider/AllWidgets/progressDialog.dart';
// import 'package:rider/main.dart';
//
// class LoginSceen extends StatelessWidget {
//   static const String idScreen = 'login';
//   TextEditingController emailTextEditingController = TextEditingController();
//   TextEditingController passwordTextEditingController = TextEditingController();
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 35.0,
//               ),
//               Image(
//                 image: AssetImage("images/logo.png"),
//                 width: 390.0,
//                 height: 250.0,
//                 alignment: Alignment.center,
//               ),
//               Padding(
//                 padding: EdgeInsets.all(20.0),
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: 1.0,
//                     ),
//                     TextField(
//                       controller: emailTextEditingController,
//                       keyboardType: TextInputType.emailAddress,
//                       decoration: InputDecoration(
//                         labelText: "Email",
//                         labelStyle: TextStyle(
//                           fontSize: 14.0,
//                         ),
//                         hintStyle: TextStyle(
//                           color: Colors.grey,
//                           fontSize: 10.0,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 1.0,
//                     ),
//                     TextField(
//                       controller: passwordTextEditingController,
//                       obscureText: true,
//                       decoration: InputDecoration(
//                         labelText: "Password",
//                         labelStyle: TextStyle(
//                           fontSize: 14.0,
//                         ),
//                         hintStyle: TextStyle(
//                           color: Colors.grey,
//                           fontSize: 10.0,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10.0,
//                     ),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.deepPurple,
//                           foregroundColor: Colors.white,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(24.0),
//                           )),
//                       child: Container(
//                         height: 50.0,
//                         child: Center(
//                           child: Text(
//                             "Login",
//                             style: TextStyle(
//                               fontSize: 18.0,
//                               fontFamily: 'Brand Bold',
//                             ),
//                           ),
//                         ),
//                       ),
//                       onPressed: () {
//                         if(!emailTextEditingController.text.contains("@")){
//                           displayToastMessage("Email is not valid", context);
//                         }else if(passwordTextEditingController.text.isEmpty){
//                           displayToastMessage("Password is mandatory.", context);
//                         }else{
//                           loginAndAuthenticateUser(context);
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {
//                   Navigator.pushNamedAndRemoveUntil(context, RegistrationSceen.idScreen, (route) => false);
//                 },
//                 child: Text("Do not have any account? Register here."),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   void loginAndAuthenticateUser(BuildContext context) async{
//
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context){
//         return ProgressDialog(message: "Authenticating, please wait...",);
//       }
//     );
//
//     final User firebaseUser = (await _firebaseAuth.signInWithEmailAndPassword(
//     email: emailTextEditingController.text,
//     password: passwordTextEditingController.text,
//     ).catchError((errMsg){
//       Navigator.pop(context);
//       displayToastMessage("Error: " + errMsg.toString(), context);
//     })).user;
//
//     if(firebaseUser != null){
//       userRef.child(firebaseUser.uid).once().then((DataSnapshot snap){
//         if(snap.value != null){
//           Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
//           displayToastMessage("You are loged-in now.", context);
//         }else{
//           Navigator.pop(context);
//           _firebaseAuth.signOut();
//           displayToastMessage("No record exist for this user. Please create new account.", context);
//         }
//       });
//     }
//     else{
//       Navigator.pop(context);
//       displayToastMessage("Error occured, can't sing-in.", context);
//     }
//
//   }
// }
