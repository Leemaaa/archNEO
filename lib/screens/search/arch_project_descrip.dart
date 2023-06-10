import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freelance_app/utils/global_methods.dart';
import 'package:freelance_app/utils/global_variables.dart';
import 'package:freelance_app/utils/clr.dart';
import 'package:freelance_app/utils/layout.dart';
import 'package:freelance_app/utils/txt.dart';
import 'package:uuid/uuid.dart';

class ProjUpload extends StatefulWidget {
  final String userID;

  const ProjUpload({super.key, required this.userID});
  @override
  State<ProjUpload> createState() => _ProjUploadState();
}
// _uploadProject1FormKey
//_eventSubject1Controller
//_eventSubject1FocusNode
//_eventTitle1Controller
//_eventTitle1FocusNode
//_eventDesc1Controller
// _eventDesc1FocusNode
//_eventDeadline1Controller
//_eventDeadline1FocusNode

class _ProjUploadState extends State<ProjUpload> {
  final _uploadProjectFormKey = GlobalKey<FormState>();

  final TextEditingController _projectSubjectController =
      TextEditingController();
  final FocusNode _projectSubjectFocusNode = FocusNode();

  final TextEditingController _projectTitleController = TextEditingController();
  final FocusNode _projectTitleFocusNode = FocusNode();

  final TextEditingController _projectDescController = TextEditingController();
  final FocusNode _projectDescFocusNode = FocusNode();

  final TextEditingController _projectDeadlineController =
      TextEditingController();
  final FocusNode _projectDeadlineFocusNode = FocusNode();
  DateTime? selectedDeadline;
  Timestamp? deadlineDateTimeStamp;

  bool _isLoading = false;

  @override
  void dispose() {
    _projectSubjectController.dispose();
    _projectSubjectFocusNode.dispose();
    _projectTitleController.dispose();
    _projectTitleFocusNode.dispose();
    _projectDescController.dispose();
    _projectDescFocusNode.dispose();
    _projectDeadlineController.dispose();
    _projectDeadlineFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        decoration: boxDecorationGradient(),
        child: Scaffold(
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
          ),
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.only(
              top: layout.padding * 3,
              bottom: layout.padding,
              left: layout.padding,
              right: layout.padding,
            ),
            child: SingleChildScrollView(
              child: Card(
                elevation: layout.elevation,
                color: clr.card,
                child: Padding(
                  padding: const EdgeInsets.all(layout.padding),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: layout.padding),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Project Description',
                              style: txt.titleDark,
                            ),
                          ),
                        ),
                        Form(
                          key: _uploadProjectFormKey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // _eventSubject1FormField
                                //_eventTitleForm1Field
                                //_eventDescForm1Field
                                //_eventDeadline1FormField
                                _projectSubjectFormField(),
                                _projectTitleFormField(),
                                _projectDescFormField(),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: layout.padding),
                                  child: _projectDeadlineFormField(),
                                ),
                              ]),
                        ),
                        _isLoading
                            ? const Align(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(
                                  top: 0,
                                  bottom: layout.padding,
                                  left: layout.padding,
                                  right: layout.padding,
                                ),
                                child: _uploadProjectButt(),
                              ),
                      ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _projectSubjectFormField() {
    return GestureDetector(
      onTap: () {
        //_showEventsSubjects1Dialog
        _showProjectsSubjectsDialog();
      },
      child: TextFormField(
        enabled: false,
        focusNode: _projectSubjectFocusNode,
        autofocus: false,
        controller: _projectSubjectController,
        style: txt.fieldDark,
        maxLines: 1,
        maxLength: 100,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        onEditingComplete: () => _projectTitleFocusNode.requestFocus(),
        decoration: InputDecoration(
          labelText: 'Select projects subject',
          labelStyle: txt.labelDark,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          floatingLabelStyle: txt.floatingLabelDark,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: clr.dark,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: clr.dark,
            ),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: clr.error,
            ),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Value is missing';
          }
          return null;
        },
      ),
    );
  }

  Widget _projectTitleFormField() {
    return TextFormField(
      enabled: true,
      focusNode: _projectTitleFocusNode,
      autofocus: false,
      controller: _projectTitleController,
      style: txt.fieldDark,
      maxLines: 1,
      maxLength: 100,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => _projectDescFocusNode.requestFocus(),
      decoration: InputDecoration(
        labelText: 'Title of the Project',
        labelStyle: txt.labelDark,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelStyle: txt.floatingLabelDark,
        // filled: true,
        // fillColor: clr.passive,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: clr.dark,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: clr.dark,
          ),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: clr.error,
          ),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Value is missing';
        }
        return null;
      },
    );
  }

  Widget _projectDescFormField() {
    return TextFormField(
      enabled: true,
      focusNode: _projectDescFocusNode,
      autofocus: false,
      controller: _projectDescController,
      style: txt.fieldDark,
      maxLines: 3,
      maxLength: 300,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => _projectDescFocusNode.unfocus(),
      decoration: InputDecoration(
        labelText: 'Description of the Project',
        labelStyle: txt.labelDark,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelStyle: txt.floatingLabelDark,
        // filled: true,
        // fillColor: clr.passive,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: clr.dark,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: clr.dark,
          ),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: clr.error,
          ),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Value is missing';
        }
        return null;
      },
    );
  }

  Widget _projectDeadlineFormField() {
    return GestureDetector(
      onTap: () {
        _selectDeadlineDialog();
      },
      child: TextFormField(
        enabled: false,
        focusNode: _projectDeadlineFocusNode,
        autofocus: false,
        controller: _projectDeadlineController,
        style: txt.fieldDark,
        maxLines: 1,
        maxLength: 100,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        onEditingComplete: () => _projectDeadlineFocusNode.unfocus(),
        decoration: InputDecoration(
          labelText: 'Select deadline date',
          labelStyle: txt.labelDark,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          floatingLabelStyle: txt.floatingLabelDark,
          // filled: true,
          // fillColor: clr.passive,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: clr.dark,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: clr.dark,
            ),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: clr.error,
            ),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Value is missing';
          }
          return null;
        },
      ),
    );
  }

  Widget _uploadProjectButt() {
    return MaterialButton(
      onPressed: () {
        _uploadProject();
      },
      elevation: layout.elevation,
      color: clr.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(layout.radius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(layout.padding * 0.75),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                'Upload Project   ',
                style: txt.button,
              ),
              Icon(
                Icons.upload_file,
                color: Colors.white,
                size: layout.iconMedium,
              ),
            ]),
      ),
    );
  }

  _showProjectsSubjectsDialog() {
    Size size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: Colors.black54,
            title: Padding(
              padding: const EdgeInsets.only(
                top: layout.padding,
                bottom: layout.padding,
              ),
              child: Text(
                'Project Subjects',
                textAlign: TextAlign.center,
                style: txt.titleLight.copyWith(color: clr.passiveLight),
              ),
            ),
            content: SizedBox(
              width: size.width * 0.9,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: projectSubjects.length,
                itemBuilder: ((context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _projectSubjectController.text = projectSubjects[index];
                        Navigator.pop(context);
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: index != projectSubjects.length - 1
                            ? layout.padding
                            : 0,
                      ),
                      child: Row(children: [
                        Icon(
                          Icons.business,
                          color: clr.passiveLight,
                          size: 25.0,
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: layout.padding * 1.25,
                            ),
                            child: Text(
                              projectSubjects[index],
                              style: txt.body2Light
                                  .copyWith(color: clr.passiveLight),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  );
                }),
              ),
            ),
            actions: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                InkWell(
                  onTap: () {
                    _projectSubjectController.text = '';
                    Navigator.canPop(context) ? Navigator.pop(context) : null;
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: layout.padding,
                      bottom: layout.padding * 2,
                    ),
                    child: Row(children: [
                      Icon(
                        Icons.cancel,
                        color: clr.passiveLight,
                        size: layout.iconSmall,
                      ),
                      const Text(
                        ' Cancel',
                        style: txt.button,
                      ),
                    ]),
                  ),
                ),
              ]),
            ]);
      },
    );
  }

  void _selectDeadlineDialog() async {
    selectedDeadline = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (selectedDeadline != null) {
      setState(
        () {
          _projectDeadlineController.text =
              '${selectedDeadline!.year} - ${selectedDeadline!.month} - ${selectedDeadline!.day}';
          deadlineDateTimeStamp = Timestamp.fromMicrosecondsSinceEpoch(
              selectedDeadline!.microsecondsSinceEpoch);
        },
      );
    } else {
      _projectDeadlineController.text = '';
      deadlineDateTimeStamp = null;
    }
  }

  void _uploadProject() async {
    getUserData();
    final projectID = const Uuid().v4();
    User? user = FirebaseAuth.instance.currentUser;
    final uid = user!.uid;
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('architects')
        .doc(widget.userID)
        .get();
    //final isValid = _uploadJobFormKey.currentState!.validate();

    // if (isValid) {
    if (_projectSubjectController.text == '' ||
        _projectTitleController.text == '' ||
        _projectDescController.text == '' ||
        _projectDeadlineController.text == '') {
      GlobalMethod.showErrorDialog(
        context: context,
        icon: Icons.error,
        iconColor: clr.error,
        title: 'Missing Information',
        body: 'Please enter all information about job.',
        buttonText: 'OK',
      );
      return;
      // }
    }
    setState(() {
      _isLoading = true;
    });
    setState(() {
      _isLoading = true;
      // user_image = userDoc.get('PhotoUrl');
    });
    try {
      await FirebaseFirestore.instance
          .collection('projects')
          .doc(projectID)
          .set({
        // 'CreatedAt': Timestamp.now(),
        'AuthorID': uid,
        'Description': _projectDescController.text,
        'ID': projectID,
        'ProjectImageUrl':
            'https://firebasestorage.googleapis.com/v0/b/getjob-ef46d.appspot.com/o/projects%2Funnamed.jpg?alt=media&token=0b461dbe-7c35-4d30-9f87-5c54f1793040',
        'Name': _projectTitleController.text,

        // 'Email': user.email,
        // 'Subjects': _projectSubjectController.text,
        // 'DeadlineDate': _projectDeadlineController.text,
        // 'DeadlineTimestamp': deadlineDateTimeStamp,
        // 'Recruiting': true,
        // 'Applicants': 0,
        // 'Comments': [],
        // 'ApplicantsList': [],
      });
      await Fluttertoast.showToast(
        msg: 'The project has been successfully uploaded.',
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.black54,
        fontSize: txt.textSizeDefault,
      );
      setState(() {
        _projectSubjectController.clear();
        _projectTitleController.clear();
        _projectDescController.clear();
        _projectDeadlineController.clear();
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      GlobalMethod.showErrorDialog(
          context: context,
          icon: Icons.error,
          iconColor: clr.error,
          title: 'Error',
          body: error.toString(),
          buttonText: 'OK');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void getUserData() async {
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('architects')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      id = userDoc.get('id');
      name = userDoc.get('Name');
      // user_image = userDoc.get('PhotoUrl');
      // venue = userDoc.get('address');
    });
  }
}

BoxDecoration boxDecorationGradient() {
  return BoxDecoration(
    gradient: LinearGradient(
      colors: [
        clr.backgroundGradient1,
        clr.backgroundGradient2,
      ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: const [0.2, 1.0],
    ),
  );
}