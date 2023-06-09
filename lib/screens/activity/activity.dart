import 'package:flutter/material.dart';
import 'package:freelance_app/screens/homescreen/sidebar.dart';
import 'Activity_jobs_posted.dart';
import 'activity_jobs_taken.dart';

class Projects extends StatefulWidget {
  const Projects({super.key});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: SideBar(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
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
          bottom: const TabBar(
            tabs: [Tab(text: 'Projects'), Tab(text: 'Conferences')],
            labelColor: Colors.black,
            labelStyle: TextStyle(fontSize: 15),
          ),
        ),
        body: const TabBarView(children: [posted(), taken()]),
      ),
    );
  }
}
