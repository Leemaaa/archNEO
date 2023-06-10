import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

import '../../utils/colors.dart';
import '../../utils/global_methods.dart';
import '../../utils/global_variables.dart';
import '../homescreen/sidebar.dart';
import './call.dart';
import 'package:freelance_app/utils/clr.dart';
import 'package:freelance_app/utils/layout.dart';
import 'package:freelance_app/utils/txt.dart';

class VideoCallPage extends StatefulWidget {
  final String? userID;

  const VideoCallPage({required this.userID});

  @override
  State<StatefulWidget> createState() => VideoCallState();
}

class VideoCallState extends State<VideoCallPage> {
  /// create a channelController to retrieve text value
  final _channelController = TextEditingController();

  /// if channel textField is validated to have error
  bool _validateError = false;

  ClientRole? _role = ClientRole.Broadcaster;

  @override
  void dispose() {
    // dispose input controller
    _channelController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getUserData();
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15, top: 20),
                child: Text(
                  "Create your own",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, bottom: 15),
                child: Text(
                  "Conference",
                  style: TextStyle(
                    color: Color(0xffD2A244),
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              conf(),
              //Bottomnavbar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget conf() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: const BoxDecoration(
        /*
        image: DecorationImage(
          image: AssetImage("assets/images/logo.png"),
        ),

        */
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 400,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _channelController,
                    decoration: InputDecoration(
                      errorText:
                      _validateError ? 'Conference name is mandatory' : null,
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(width: 1),
                      ),
                      hintText: 'Conference name',
                    ),
                  ),
                )
              ],
            ),
            // Column(
            //   children: [
            //     ListTile(
            //       title: Text(ClientRole.Broadcaster.toString()),
            //       leading: Radio(
            //         value: ClientRole.Broadcaster,
            //         groupValue: _role,
            //         onChanged: (ClientRole? value) {
            //           setState(() {
            //             _role = value;
            //           });
            //         },
            //       ),
            //     ),
            //     ListTile(
            //       title: Text(ClientRole.Audience.toString()),
            //       leading: Radio(
            //         value: ClientRole.Audience,
            //         groupValue: _role,
            //         onChanged: (ClientRole? value) {
            //           setState(() {
            //             _role = value;
            //           });
            //         },
            //       ),
            //     )
            //   ],
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: _createConfButton(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _createConfButton() {
    return MaterialButton(
      onPressed: onJoin,
      // elevation: layout.elevation,
      color: clr.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(layout.radius * 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(layout.padding * 0.75),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(
                Icons.video_call,
                color: Colors.white,
                size: layout.iconMedium,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                'Create Conference',
                style: txt.button,
              ),
            ]),
      ),
    );
  }

  void _addConference() async {
    final confID = const Uuid().v4();
      try {
        FirebaseFirestore.instance.collection('conferences').doc(confID).set(
          {
            'ID': confID,
            'Name': _channelController.text,
            'AuthorName' : name,
            'AuthorID' : id,
            'CreatedAt': Timestamp.now(),
          },
        );
        Navigator.canPop(context) ? Navigator.pop(context) : null;
      } catch (error) {
        GlobalMethod.showErrorDialog(
          context: context,
          icon: Icons.error,
          iconColor: clr.error,
          title: 'Error',
          body: error.toString(),
          buttonText: 'OK',
        );
      }
    }

  void getUserData() async {
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('architects')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      id = FirebaseAuth.instance.currentUser!.uid;
      name = userDoc.get('Name');
    });
  }

  Future<void> onJoin() async {
    _addConference();
    // update input validation
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });
    if (_channelController.text.isNotEmpty) {
      await _fetchData();
      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic(Permission.camera);
      await _handleCameraAndMic(Permission.microphone);
      // push video page with given channel name
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(
            channelName: _channelController.text,
            role: _role,
            userID: id,
            tokenFromServer: token,
            gID: guid,
          ),
        ),
      );
    }
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }

  void _generateUid() {
    Random random = Random();
    int min = 100000;
    int max = 999999;
    guid =  min + random.nextInt(max - min);
  }

  Future<void> _fetchData() async {
    _generateUid();
    uri = 'https://archneo-token-server.herokuapp.com/rtc/'+ _channelController.text + '/publisher/userAccount/'+ guid.toString() +'/';
    var url = Uri.parse(uri!);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        final data = json.decode(response.body);
        setState(() {
          token = data['rtcToken'];
        });
      });
    } else {
      throw Exception('Failed to fetch data');
    }

    print("uri: $uri token: $token");
  }
}
