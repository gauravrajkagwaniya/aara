import 'dart:convert';

import 'package:aara/sizeconfi.dart';
import 'package:aara/subCategoryScreen.dart';
import 'package:aara/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'model/data.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Data> categoryData;
  var categoryId;

  String city;

  String addres = 'current location';

  /// calling api and fetching data
  fetchData() async {
    final response = await http
        .get("https://project252.aaratechnologies.in/web/common/category");
    // / got rspones and decoding body
    var data = json.decode(response.body);

    var jsonResults = data['response_data']['data'] as List;
// /maping json decoded data and inisializing  to the list of data
    print(data.toString());
    categoryData = jsonResults.map((place) => Data.fromJson(place)).toList();
    print(categoryData.toString());
  }

  @override
  void initState() {
    getLocation();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(
          Icons.menu,
          color: Styles.priColor,
        ),
        title: FittedBox(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.gps_fixed,
                color: Colors.black,
                size: 10,
              ),
              SizedBox(
                width: 10,
              ),
              Text('$addres',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Icon(
              Icons.search,
              color: Styles.priColor,
            ),
          )
        ],
      ),
      body: Container(
        // height: MediaQuery.of(context).size.height * .99,
        // width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Text(
                'Buddha Bowls',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: Styles.midFont),
              ),
            ),
            FutureBuilder(
              future: fetchData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: categoryData.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SubCategoryScreen(
                                  cateId: categoryData[index].catId,
                                  itemName: categoryData[index].title,
                                ),
                              ));
                        },
                        child: Container(
                          child: Container(
                            //margin: EdgeInsets.only(right: 10),

                            height: getProportionateScreenHeight(150),
                            width: getProportionateScreenWidth(100),
                            child: Stack(
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      gradient: new RadialGradient(
                                        center: Alignment.bottomCenter,
                                        radius: 7,
                                        focal: AlignmentGeometry.lerp(
                                            Alignment.centerRight,
                                            Alignment.centerLeft,
                                            1),
                                        colors: [
                                          Styles.backgroundColor,
                                          Colors.blueGrey
                                        ],
                                      ),
                                    ),
                                    height: getProportionateScreenHeight(150),
                                    width: getProportionateScreenWidth(325),
                                    padding: EdgeInsets.only(
                                      left: 30,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(categoryData[index].catId),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(categoryData[index].title),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(categoryData[index].createdAt),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                    right: 1,
                                    child: Container(
                                      height: getProportionateScreenHeight(150),
                                      width: getProportionateScreenWidth(150),
                                      child: Image(
                                          image: AssetImage('assets/bowl.png')),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Theme(
                    data: Theme.of(context).copyWith(accentColor: Colors.blue),
                    child: new Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
        //
      ),
    );
  }

  getLocation() async {
    final loc = await Geolocator().getCurrentPosition(
desiredAccuracy: LocationAccuracy.high
    );
    final coordinates = new Coordinates(
          loc.latitude, loc.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(
          coordinates);
    setState(() {
          city =addresses.first.locality;
          addres =addresses.first.addressLine;
        });
        print('$city,$addres');
  }
}
