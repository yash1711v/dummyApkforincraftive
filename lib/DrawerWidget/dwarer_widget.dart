import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../Presentation/CatogariesPage.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final Dio _dio=Dio();

  String second='https://ecomm.dotvik.com/v2kart/service/categories/mainCategories';
  List<dynamic> mapOfcat=[];
 Future<void> fetchDate() async {
    final response = await _dio.get(second);
    Map<String,dynamic>  testvariable=  json.decode(response.toString());
   setState(() {
      mapOfcat=testvariable['data'];
   });
    print("hello map here ${mapOfcat}");
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDate();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20,),
        Row(
          children: [
            IconButton(onPressed: () {  }, icon: Icon(Icons.menu, ),),
          ],
        ),
        SizedBox(height: 0,),
        Container(
          height: 50,
          color: Colors.red,
          child: Row(
            children: [
              SizedBox(width: 10,),
              Icon(Icons.account_circle_outlined,color: Colors.white,),
              SizedBox(
                width: 165,
                  child: Text("Login",style: TextStyle(color: Colors.white),)),
              Icon(Icons.keyboard_arrow_down_sharp,color: Colors.white,),


            ],
          ),
        ),
        ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
        itemCount: mapOfcat.length,
        itemBuilder: (BuildContext context,int index){
              String image='https://pinnacle.works/wp-content/uploads/2022/06/dummy-image.jpg';
              if(mapOfcat[index]['images'].isNotEmpty){
                if(mapOfcat[index]['images'][0].containsKey('imageUrl')) {

                  image=mapOfcat[index]['images'][0]['imageUrl'];
                 }
              }
          return Container(
            height: 50,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(

                    children: [
                      GestureDetector(
                        onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Catogaries()));
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(image,),
                              fit: BoxFit.fill
                            )
                          )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: SizedBox(
                            width: 140,
                            child: Text(mapOfcat[index]['categoryName'])),
                      ),
                      IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Catogaries()));
                      }, icon: Icon(Icons.arrow_forward))
                    ],
                  ),
                ),
              ],
            ),
          );
    })







      ],
    );
  }
}
