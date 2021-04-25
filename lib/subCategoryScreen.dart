import 'package:aara/model/subCate/data.dart';
import 'package:aara/model/subCate/subcategory.dart';
import 'package:aara/sizeconfi.dart';
import 'package:aara/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SubCategoryScreen extends StatefulWidget {
  final String cateId;
  final String itemName;

  const SubCategoryScreen({Key key, @required this.cateId, this.itemName})
      : super(key: key);

  @override
  _SubCategoryScreenState createState() => _SubCategoryScreenState(cateId);
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  final String cateId;
  int loading = 0;

  int Count = 1;

  _SubCategoryScreenState(this.cateId);

  List<Data> subcategory;

  fetchData() async {
    final response = await http
        .get("https://project252.aaratechnologies.in/web/common/subcategory");
    var data = json.decode(response.body);
    var message = data["response_code"];
    var jsonResults = data['response_data']['data'] as List;
    print(data.toString());
    subcategory = jsonResults.map((place) => Data.fromJson(place)).toList();

    print(subcategory.toString());
  }

  Widget subData() {
    for (int i = 0; i <= subcategory.length; i++) {
      if (cateId == subcategory[i].catId) {
        return Container(
          // color: Colors.amber,
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: getProportionateScreenHeight(500),
          width: getProportionateScreenWidth(1000),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(cateId,
                  style: TextStyle(
                      fontSize: Styles.semiSmall2Font,
                      color: Styles.fontActive2)),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.itemName,
                style: TextStyle(fontSize: Styles.midFont),
              ),
              SizedBox(
                height: 10,
              ),
              heading('what is in it'),
              SizedBox(
                height: 5,
              ),
              content(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
              SizedBox(
                height: 10,
              ),
              heading('This is the subcategory from API'),
              SizedBox(
                height: 5,
              ),
              content(subcategory[i].subcategory),
              SizedBox(
                height: 10,
              ),
              heading('This is the title from API'),
              SizedBox(
                height: 5,
              ),
              content(subcategory[i].title),
              SizedBox(
                height: 10,
              ),
              heading('created at'),
              SizedBox(
                height: 5,
              ),
              content(subcategory[i].createdAt),
            ],
          ),
        );
      }
    }
  }

  Text heading(String txt) {
    return Text(txt,
        style: TextStyle(
            fontSize: Styles.semiSmall2Font,
            color: Styles.fontActive,
            fontWeight: FontWeight.bold));
  }

  Text content(String text) {
    return Text(text,
        style: TextStyle(
            fontSize: Styles.semiSmall2Font,
            color: Styles.fontActive2,
            fontWeight: FontWeight.bold));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            ///sliver appbar should be here
            sliverAppBar(context)
          ];
        },
        body: Container(
          height: MediaQuery.of(context).size.height * .99,
          width: getProportionateScreenWidth(200),
          child: FutureBuilder(
              future: fetchData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return subData();
                } else {
                  return Theme(
                    data: Theme.of(context).copyWith(accentColor: Colors.blue),
                    child: new Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              }),
        ),
      ),
      floatingActionButton: Container(
        height: getProportionateScreenHeight(130),
        width: getProportionateScreenWidth(1000),
        color: Colors.white70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: getProportionateScreenWidth(100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                          onTap: () {
                            if (Count != 0) {
                              setState(() {
                                Count--;
                              });
                            }
                            return 0;
                          },
                          child: FaIcon(
                            FontAwesomeIcons.minus,
                            size: 10,
                          )),
                      Text('$Count'),
                      InkWell(
                        onTap: () {
                          setState(() {
                            Count++;
                          });
                        },
                        child: Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.euroSign,
                      size: 20,
                    ),
                    Text(
                      '${8.91 * Count}',
                      style: TextStyle(fontSize: Styles.midFont),
                    ),
                  ],
                ),
              ],
            ),
            FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                color: Colors.black,
                onPressed: () {},
                child: Container(
                  width: getProportionateScreenWidth(300),
                  height: getProportionateScreenHeight(50),
                  child: Center(
                    child: Text(
                      'ADD TO CART',
                      style: TextStyle(
                          color: Colors.white, fontSize: Styles.midFont),
                    ),
                  ),
                )),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget sliverAppBar(
    BuildContext context,
  ) {
    return SliverAppBar(
      elevation: 0,
      stretch: true,
      onStretchTrigger: () {
        // Function callback for stretch
        return;
      },
      expandedHeight: 300,
      toolbarHeight: 50,
      floating: true,
      primary: true,
      leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios,
            color: Styles.priColor,
          )),
      pinned: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: FlexibleSpaceBar(
          stretchModes: <StretchMode>[
            StretchMode.zoomBackground,
            StretchMode.blurBackground,
          ],

          /// image of dish
          background: Container(
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
                child: Image.asset(
              'assets/bowl.png',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            )),
          ),
        ),
      ),
    );
  }
}
