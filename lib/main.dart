import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:turkish/turkish.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool sortName=false;
  bool sortSurname=false;
  List<Name> selectedName;
  List<Name> nameList;
  @override
  void initState() {
    super.initState();
    selectedName=[];
    nameList=names;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Visibility(
            visible: selectedName.length>0,
            child: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                deleteSelected();
              },
            ),
          )
        ],
        title: Text("Data Table"),
      ),
      body: Container(
        child: DataTable(
            onSelectAll: (b) {},
            sortColumnIndex: 1,
            sortAscending: sortSurname,
            columns: <DataColumn>[
              DataColumn(
                label: Text("Ad"),
                numeric: false,
                onSort: (i, b) {
                  print("$i $b");
                  setState(() {
                    if(sortName)
                      nameList.sort((a, b) =>  turkish.comparator(a.firstName,b.firstName));
                    else
                      nameList.sort((a, b) =>  turkish.comparator(b.firstName,a.firstName));
                    sortName=!sortName;
                  });
                },
                tooltip: "Ad görüntüleme alanı",//Görmek için columnTitle'a basılı tut
              ),
              DataColumn(
                label: Text("Soyad"),
                numeric: false,
                onSort: (i, b) {
                  print("$i $b");
                  setState(() {
                    if(sortSurname)
                      nameList.sort((a, b) =>  turkish.comparator(a.lastName,b.lastName));
                    else
                      nameList.sort((a, b) =>  turkish.comparator(b.lastName,a.lastName));
                    sortSurname=!sortSurname;
                  });
                },
                tooltip: "Soyad görüntüleme alanı",//Görmek için columnTitle'a basılı tut
              ),
            ],
            rows: nameList
                .map(
                  (name) => DataRow(
                      selected: selectedName.contains(name),
                      onSelectChanged: (b) {
                        print("Onselect");
                        onSelectedRow(b, name);
                      },
                cells:dataRow(name)
              ),
            )
                .toList()),
      ),
    );
  }
  onSelectedRow(bool selected, Name user) async {
    setState(() {
      if (selected) {
        selectedName.add(user);
      } else {
        selectedName.remove(user);
      }
    });
  }
  List<DataCell> dataRow(Name name){
    List<DataCell> list = List();
    Map<String,dynamic> map = name.toJson();
    map.forEach((key, value) {
        list.add( DataCell(
          Text(value),
          showEditIcon: false,
          placeholder: false,
        ));
    });
    return list;
  }
  deleteSelected() async {
    setState(() {
      if (selectedName.isNotEmpty) {
        List<Name> temp = [];
        temp.addAll(selectedName);
        for (Name user in temp) {
          nameList.remove(user);
          selectedName.remove(user);
        }
      }
    });
  }
}
class Name {
  bool selected;
  String firstName;
  String lastName;

  Name({this.firstName, this.lastName,this.selected});
  Map<String,dynamic> toJson(){
    return {
      'firstName':firstName,
      'lastName':lastName
    };
  }
}
var names = <Name>[
  Name(firstName: "Eyüp", lastName: "Akkaya",selected: false),
  Name(firstName: "Tolga", lastName: "Güler",selected: false),
  Name(firstName: "Emre", lastName: "Yalçın",selected: false),
  Name(firstName: "Cemrehan", lastName: "Çavdar",selected: false),
];