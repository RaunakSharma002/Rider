// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:rider/AllScreens/loginScreen.dart';
// import 'package:rider/AllScreens/mainScreen.dart';
// import 'package:rider/AllWidgets/progressDialog.dart';
// import 'package:rider/main.dart';
//
// class RegistrationSceen extends StatelessWidget {
//   static const String idScreen = 'register';
//
//   TextEditingController nameTextEditingController = TextEditingController();
//   TextEditingController emailTextEditingController = TextEditingController();
//   TextEditingController phoneTextEditingController = TextEditingController();
//   TextEditingController passwordTextEditingController = TextEditingController();
//
//   // const RegistrationSceen({Key? key}) : super(key: key);
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
//
//               SizedBox(
//                 height: 20.0,
//               ),
//               Image(
//                 image: AssetImage("images/logo.png"),
//                 width: 390.0,
//                 height: 250.0,
//                 alignment: Alignment.center,
//               ),
//
//               SizedBox(height: 1.0,),
//               Text(
//                 "Register as a Rider",
//                 style: TextStyle(fontSize: 24.0, fontFamily: 'Brand Bold'),
//                 textAlign: TextAlign.center,
//               ),
//
//               Padding(
//                 padding: EdgeInsets.all(20.0),
//                 child: Column(
//                   children: [
//
//                     SizedBox(
//                       height: 1.0,
//                     ),
//                     TextField(
//                       controller: nameTextEditingController,
//                       keyboardType: TextInputType.text,
//                       decoration: InputDecoration(
//                         labelText: "Name",
//                         labelStyle: TextStyle(
//                           fontSize: 14.0,
//                         ),
//                         hintStyle: TextStyle(
//                           color: Colors.grey,
//                           fontSize: 10.0,
//                         ),
//                       ),
//                     ),
//
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
//
//                     SizedBox(
//                       height: 1.0,
//                     ),
//                     TextField(
//                       controller: phoneTextEditingController,
//                       keyboardType: TextInputType.phone,
//                       decoration: InputDecoration(
//                         labelText: "Phone",
//                         labelStyle: TextStyle(
//                           fontSize: 14.0,
//                         ),
//                         hintStyle: TextStyle(
//                           color: Colors.grey,
//                           fontSize: 10.0,
//                         ),
//                       ),
//                     ),
//
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
//
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
//                             "Create Account",
//                             style: TextStyle(
//                               fontSize: 18.0,
//                               fontFamily: 'Brand Bold',
//                             ),
//                           ),
//                         ),
//                       ),
//                       onPressed: () {
//                         if(nameTextEditingController.text.length < 4){
//                           displayToastMessage("Name must be atleast 3 charcter", context);
//                         }else if(!emailTextEditingController.text.contains("@")){
//                           displayToastMessage("Email is not valid", context);
//                         }else if(phoneTextEditingController.text.isEmpty){
//                           displayToastMessage("Phone no. is mandatory", context);
//                         }else if(passwordTextEditingController.text.length < 7){
//                           displayToastMessage("Password must atleast 6 characters.", context);
//                         }
//                         else{
//                           registerNewUser(context);
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {
//                   Navigator.pushNamedAndRemoveUntil(context, LoginSceen.idScreen, (route) => false);
//                 },
//                 child: Text("Already have any account? Login here."),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//
//   void registerNewUser( BuildContext context) async{
//
//     showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context){
//           return ProgressDialog(message: "Authenticating, please wait...",);
//         }
//     );
//
//     final User firebaseUser = (await _firebaseAuth.createUserWithEmailAndPassword(
//       email: emailTextEditingController.text,
//       password: passwordTextEditingController.text,
//     ).catchError((errMsg){
//       Navigator.pop(context);
//       displayToastMessage("Error: " + errMsg.toString(), context);
//     })).user;
//
//     if(firebaseUser != null){
//       //save user info to the database
//       Map userDataMap = {
//         "name": nameTextEditingController.text.trim(),
//         "email": emailTextEditingController.text.trim(),
//         "phone": phoneTextEditingController.text.trim(),
//       };
//       userRef.child(firebaseUser.uid).set(userDataMap);
//       displayToastMessage("Hey, Congratulation your account has been created.", context);
//
//       Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
//     }
//     else{
//       Navigator.pop(context);
//       displayToastMessage("New user account has not been created", context);
//     }
//   }
//
// }
//
// displayToastMessage(String message, BuildContext context){
//   Fluttertoast.showToast(msg: message);
//   print('message working');
// }