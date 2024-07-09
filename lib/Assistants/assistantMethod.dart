import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rider/Assistants/requestAssistant.dart';
import 'package:rider/DataHandler/appData.dart';
import 'package:rider/Models/address.dart';
import 'package:rider/Models/allUsers.dart';
import 'package:rider/Models/directDetails.dart';
import 'package:rider/configMaps.dart';

class AssistantMethods{
  static Future<String> searchCoordinateAddress(Position position, context) async{
    String placeAddress = "";
    String sublocality, administrative_area_level_2, administrative_area_level_1,  country;
    String url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";

    var response = await RequestAssistant.getRequest(url);

    if(response != 'failed'){
      // placeAddress = response["results"][0]["formatted_address"];  //Complete address
      sublocality = response["results"][0]["address_components"][2]["long_name"];
      administrative_area_level_2 = response["results"][0]["address_components"][3]["long_name"];
      administrative_area_level_1 = response["results"][0]["address_components"][4]["short_name"];
      country = response["results"][0]["address_components"][5]["short_name"];
      placeAddress = sublocality + ", " + administrative_area_level_2 + ", " + administrative_area_level_1 + ", " + country;

      Address userPickerAddress = new Address();
      userPickerAddress.longitude = position.longitude;
      userPickerAddress.latitude = position.latitude;
      userPickerAddress.placeName = placeAddress;
      Provider.of<AppData>(context, listen: false).updatePickupLocationAddress(userPickerAddress);
    }
    return placeAddress;
  }

  static Future<DirectionDetails> obtainPlaceDirectionDetails(LatLng initialPosition, LatLng finalPosition) async{
    String directonUrl = "https://maps.googleapis.com/maps/api/directions/json?origin=${initialPosition.latitude},${initialPosition.longitude}&destination=${finalPosition.latitude},${finalPosition.longitude}&key=$mapKey";
    var res = await RequestAssistant.getRequest(directonUrl);
    // if(res == "failed"){
    //   return null;
    // }
    print("Multiples routes,${res}");

    DirectionDetails directionDetails = DirectionDetails();
    directionDetails.encodePoints = res["routes"][0]["overview_polyline"]["points"];
    directionDetails.distanceText = res["routes"][0]["legs"][0]["distance"]["text"];
    directionDetails.distanceValue = res["routes"][0]["legs"][0]["distance"]["value"];
    directionDetails.durationText = res["routes"][0]["legs"][0]["duration"]["text"];
    directionDetails.durationValue = res["routes"][0]["legs"][0]["duration"]["value"];

    return directionDetails;
  }

  // static int calculateFares(DirectionDetails directionDetails) {
  //   //interm of USD
  //   double timeTravelFare = (directionDetails.durationValue / 60) * 0.20;
  //   double distanceTravelFare = (directionDetails.distanceValue / 1000) * 0.02;
  //   double totalAmountFare = timeTravelFare + distanceTravelFare;
  //   //$1 = ₹82.17
  //   double totalLocalAmount = totalAmountFare * 8.17;
  //   return totalLocalAmount.truncate();
  // }

  // static void getCurrentOnlineUserInfo() async{
  //   firebaseUser = await FirebaseAuth.instance.currentUser;
  //   String userId = firebaseUser.uid;
  //   DatabaseReference reference = FirebaseDatabase.instance.reference().child("users").child(userId);
  //
  //   reference.once().then((DataSnapshot dataSnapShot){
  //     if(dataSnapShot.value != null){
  //       userCurrentInfo = Users.fromSnapshot(dataSnapShot);
  //     }
  //   });
  // }

}