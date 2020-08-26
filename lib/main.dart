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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                      names.sort((a, b) =>  turkish.comparator(a.firstName,b.firstName));
                    else
                      names.sort((a, b) =>  turkish.comparator(b.firstName,a.firstName));
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
                      names.sort((a, b) =>  turkish.comparator(a.lastName,b.lastName));
                    else
                      names.sort((a, b) =>  turkish.comparator(b.lastName,a.lastName));
                    sortSurname=!sortSurname;
                  });
                },
                tooltip: "Soyad görüntüleme alanı",//Görmek için columnTitle'a basılı tut
              ),
            ],
            rows: names
                .map(
                  (name) => DataRow(
                cells: [
                  DataCell(
                    Text(name.firstName),
                    showEditIcon: false,
                    placeholder: false,
                  ),
                  DataCell(
                    Text(name.lastName),
                    showEditIcon: false,
                    placeholder: true,
                  )
                ],
              ),
            )
                .toList()),
      ),
    );
  }
}
class Name {
  String firstName;
  String lastName;

  Name({this.firstName, this.lastName});
}
var names = <Name>[
  Name(firstName: "Eyüp", lastName: "Akkaya"),
  Name(firstName: "Tolga", lastName: "Güler"),
  Name(firstName: "Emre", lastName: "Yalçın"),
  Name(firstName: "Cemrehan", lastName: "Çavdar"),
];