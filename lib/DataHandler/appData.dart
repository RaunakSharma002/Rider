import 'package:flutter/cupertino.dart';
import 'package:rider/Models/address.dart';

class AppData extends ChangeNotifier{
  Address pickUpLocation, dropOffLocation;

  void updatePickupLocationAddress(Address pickupAddress){
    pickUpLocation = pickupAddress;
    notifyListeners();
  }

  void updateDropOffLocationAddress(Address dropOffAddress){
    dropOffLocation = dropOffAddress;
    notifyListeners();
  }
}