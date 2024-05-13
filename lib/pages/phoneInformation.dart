

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhoneInfo extends StatefulWidget {
   PhoneInfo({super.key});
  @override
  State<PhoneInfo> createState() => _PhoneInfoState();
}

class _PhoneInfoState extends State<PhoneInfo> {
   String? phoneName,phoneModel,deviceId,brand,deviceType;
   bool isPhysical = false;
   List<String> phoneFeatures = List.empty();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDeviceInfo();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        centerTitle: true,
        title: Text("Device Information",style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Container(

                   width: screenSize.width/1.8,
        
                     decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(10),
                     ),
                     child: ClipRRect(
                       borderRadius: BorderRadius.circular(20),
                       child:  Image(
                         
                           image: AssetImage("assets/deviceinfo.png")),
                      ),
                 ),
                Card(
                  color: Colors.indigo,
                  elevation: 3,
                  child: Container(
                    width: screenSize.width/1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Device Name: "+phoneName.toString(),style: TextStyle(color: Colors.white,fontSize: 16),),
                          Divider(),
                          SizedBox(height: 20,),
                          Text("Device model: "+phoneModel.toString(),style: TextStyle(color: Colors.white,fontSize: 16),),
                          Divider(),
                          SizedBox(height: 20,),
                          Text("Device ID: "+deviceId.toString(),style: TextStyle(color: Colors.white,fontSize: 16),),
                          Divider(),
                          SizedBox(height: 20,),
                          Text("Device Brand: "+brand.toString(),style: TextStyle(color: Colors.white,fontSize: 16),),
                          Divider(),
                          SizedBox(height: 20,),
                          Text("Device Type: "+deviceType.toString(),style: TextStyle(color: Colors.white,fontSize: 16),),
                          Divider(),
                        ],

                      ),
                    ),
                  ),
                ),
                Container(
                  height: screenSize.height/8,
                  width: screenSize.width,
                  child: ListView.builder(
                    itemCount: phoneFeatures.length,
                      itemBuilder:(context, index) {
                        if(phoneFeatures.isNotEmpty)
                          {
                            return Text(":"+phoneFeatures[index].toString());
                          }
                        else
                          {
                            return Text("Nothing");
                          }
                      }, ),
                ),
                ElevatedButton(onPressed: (){getDeviceInfo();
                }, child: Text("Get Device info"))
              ],
            ),
          ),
        ),
      ),
    );
  }
  getDeviceInfo() async {
    var device = DeviceInfoPlugin();
    if(Platform.isAndroid)
      {
       var  androidInfo = await device.androidInfo;

         phoneName = androidInfo.device.toString();
         phoneModel = androidInfo.model.toString();
         deviceId = androidInfo.serialNumber.toString();
         isPhysical =  androidInfo.isPhysicalDevice;
       phoneFeatures = androidInfo.systemFeatures;
         if(isPhysical)
           {
             deviceType="Physical";
           }
         else
           {
             deviceType="Virtual";
           }
         brand= androidInfo.brand;

      }
    else if(Platform.isIOS)
      {
        var iosInfo = await device.iosInfo;
      }
    setState(() {
    });
  }
}
