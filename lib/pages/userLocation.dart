import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class UserLocation extends StatefulWidget {
  const UserLocation({super.key});


  @override
  State<UserLocation> createState() => _UserLocationState();
}

class _UserLocationState extends State<UserLocation> {
  String lat = "";
  String lon = "";
  String address="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }
  @override
  Widget build(BuildContext context) {
    var sSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("User Location"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.deepOrange,
                ),
                width: sSize.width/1.25,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Location :"+address,style: TextStyle(color: Colors.white),),
                      ),
                      Container(
                        width: sSize.width/1.25,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                          borderRadius: BorderRadius.circular(12),
                          border:Border.all(color: Colors.green)
                          ),


                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Lattitude: "+lat,style: TextStyle(color: Colors.white),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Longitude: "+lon,style: TextStyle(color: Colors.white),),
                            ),
                          ],
                        ),
                      ),
                      Center(child: ElevatedButton(onPressed: (){getLocation();}, child: Text("click")))

                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),

    );
  }

  Future<void> getLocation()
  async {
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission==LocationPermission.denied || permission==LocationPermission.deniedForever){
      getLocation();
      log("location Denied");
      LocationPermission ask = await Geolocator.requestPermission();
    }
    else
      {
        Position curerntPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
        log("latitude ${curerntPosition.latitude.toString()}");
        log("longitude ${curerntPosition.longitude.toString()}");
        lat=curerntPosition.latitude.toString();
        lon=curerntPosition.longitude.toString();
        List<Placemark> result  = await placemarkFromCoordinates(curerntPosition.latitude.toDouble(),curerntPosition.longitude.toDouble());
        if(result.isNotEmpty){
           address =  result[0].locality.toString()+","+result[0].administrativeArea.toString()+","+result[0].country.toString();

        }
        else
          {
            address="null";
          }
        setState(() {

        });
      }

  }

}
