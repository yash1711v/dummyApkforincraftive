import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
class Catogaries extends StatefulWidget {
  const Catogaries({super.key});

  @override
  State<Catogaries> createState() => _CatogariesState();
}

class _CatogariesState extends State<Catogaries> {
  final Dio _dio=Dio();
  String first='https://ecomm.dotvik.com/v2kart/service/categories/men/tree';
  String catogaryName="";
  Map<String,dynamic> mapOfCat={};
  List<dynamic>subCat=[];
  List<dynamic>childCat=[];
  List<dynamic>bottomWear=[];
  List<dynamic>footmWear=[];
  List<dynamic> winterWear=[];
  List<dynamic> indianAndFushionWear=[];
  List<dynamic> testing=[];
  List<dynamic> topWear=[];
  List<dynamic> allMenWear=[];

  Future<void> fetchDate() async {
    final response = await _dio.get(first);
    Map<String,dynamic>  testvariable=  json.decode(response.toString());
    setState(() {
      mapOfCat=testvariable;
      catogaryName=mapOfCat['data']['categoryName'];
      subCat=mapOfCat['data']['subCategory'];
      childCat=mapOfCat['data']['childCategory'];
      for(int i=0;i<childCat.length;i++){
        if(childCat[i]['parentId']==19949){
          topWear.add(childCat[i]);
        }
        if(childCat[i]['parentId']==19955){
          bottomWear.add(childCat[i]);
        }
        if(childCat[i]['parentId']==19961){
          footmWear.add(childCat[i]);
        }
        if(childCat[i]['parentId']==20559){
          winterWear.add(childCat[i]);
        }
        if(childCat[i]['parentId']==20123){
          indianAndFushionWear.add(childCat[i]);
        }
        if(childCat[i]['parentId']==479){
          testing.add(childCat[i]);
        }
        if(childCat[i]['parentId']==20134){
          allMenWear.add(childCat[i]);
      }
    }});
    print("hello map here ${mapOfCat}");
  }

  List<dynamic> whichListofCat(int idOfSubCat){
    if(idOfSubCat==19949){
      return topWear;
    }
    if(idOfSubCat==19955){
      return bottomWear;
    }
    if(idOfSubCat==19961){
      return footmWear;
    }
    if(idOfSubCat==20559){
      return winterWear;
    }if(idOfSubCat==20123){
      return indianAndFushionWear;
    }if(idOfSubCat==479){
      return testing;}
    if(idOfSubCat==20134){
      return allMenWear;
    }
    return [];
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDate();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("$catogaryName"),
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back),),
        actions: [
          IconButton(onPressed: () {  }, icon: Icon(Icons.cancel,color: Colors.white,),),
        ],
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: subCat.length,
              itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Row(
                          children: [
                            Text(subCat[index]['categoryName'],style: TextStyle(fontSize: 20),),
                          ],
                        ),
                      ),
                    Container(
                      height: 128,
                      width: double.infinity,
                      child: ListView.builder(

                        scrollDirection: Axis.horizontal,
                        itemCount: whichListofCat(subCat[index]['id']).length,
                        shrinkWrap: true,

                        itemBuilder: (context,i){
                         List<dynamic> data=whichListofCat(subCat[index]['id']);
                         String name="";
                         String image='https://pinnacle.works/wp-content/uploads/2022/06/dummy-image.jpg';
                         if(data[i]['images'].isNotEmpty){
                           if(data[i]['images'][0].containsKey('imageUrl')) {

                             image=data[i]['images'][0]['imageUrl'];
                           }
                         }
                        return Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      border: Border.all(color:Colors.redAccent,width: 2),
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                        image: NetworkImage(image),
                                        fit: BoxFit.cover
                                      )
                                    ),
                                  ),
                                  Center(
                                    child: SizedBox(
                                        width: 100,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(addLineBreaks(data[i]['categoryName']),style: TextStyle(fontSize: 10),),
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                                        ),
                    )

                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

String addLineBreaks(String text) {
  if (text.length <= 5) {
    return text;
  } else {
    String newText = '';
    for (int i = 0; i < text.length; i++) {
      newText += text[i];
      if ((i + 1) % 12 == 0) {
        newText += '\n    ';
      }
    }
    return newText;
  }
}
