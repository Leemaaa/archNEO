import "package:flutter/material.dart";
import 'package:freelance_app/utils/colors.dart';

import '../homescreen/sidebar.dart';

class FieldModel {
  String? eventTitle;
  String? authorName;
  FieldModel(this.eventTitle, this.authorName);
}

class Search extends StatefulWidget {
  static const routeName = "search";

  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
// sample lists for filtering

  static List<FieldModel> mainFieldList = [
    FieldModel("architecture", "b2b technology"),
    FieldModel("interior design", " Via solution "),
    FieldModel("flutter developer", "Adore Addis "),
    FieldModel("project management", "Rakan Travel Solution"),
  ];
  List<FieldModel> displayList = List.from(mainFieldList);
  void updateList(String value) {
// for filtering the list
    setState(() {
      displayList = mainFieldList
          .where((element) =>
              element.eventTitle!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideBar(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: white,
          iconTheme: const IconThemeData(
            color: Color(0xffD2A244),
          ),
          title: const Padding(
            padding: EdgeInsets.only(left: 180),
            child: Text(
              "ArchNEO",
              style: TextStyle(color: Color(0xffD2A244)),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 30.0, top: 40),
                child: Text("Search For A Event",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: black)),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: TextField(
                  onChanged: (value) => updateList(value),
                  style: TextStyle(color: yellow),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none),
                    hintText: "I'm looking for...",
                    prefixIcon: const Icon(Icons.search),
                    prefixIconColor: Color.fromRGBO(245, 186, 65, 1),
                    suffixIcon: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffD2A244),
                        //fixedSize: const Size.fromWidth(100),
                        padding: const EdgeInsets.all(22),
                      ),
                      onPressed: () {},
                      child: const Icon(Icons.search),
                    ),
                    suffixIconColor: yellow,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                height: 200,
                child: displayList.isEmpty
                    ? const Center(
                        child: Text("No result found",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            )))
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: displayList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text('${displayList[index].eventTitle!}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            subtitle:
                                Text('${displayList[index].authorName!}',
                                    style: const TextStyle(
                                      fontSize: 15,
                                    )),
                          );
                        },
                      ),
              )
            ],
          ),
        ));
  }
}
