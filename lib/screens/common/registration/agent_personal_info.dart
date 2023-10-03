import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:threeclick/custom/app_button.dart';
import 'package:threeclick/custom/app_text.dart';
import 'package:threeclick/custom/app_text_field.dart';
import 'package:threeclick/custom/toast_message.dart';
import 'package:threeclick/custom/validate_connectivity.dart';
import 'package:threeclick/styles/app_colors.dart';
import 'package:threeclick/view_models/common/registration_provider.dart';

class AgentPersonalInfo extends StatefulWidget {
  final String name;
  final String password;
  final String email;
  final String phone;
  final String age;

  AgentPersonalInfo(
      {Key? key,
      required this.name,
      required this.password,
      required this.email,
      required this.phone,
      required this.age})
      : super(key: key);

  @override
  _AgentPersonalInfoState createState() => _AgentPersonalInfoState();
}

class _AgentPersonalInfoState extends State<AgentPersonalInfo> {
  String radioButtonItem = 'Monthly';
  String radioButtonGender = 'male';
  int id = 1;
  int genderID = 1;
  String planAmount = '100';
  File? _image;
  File? _image1;
  final TextEditingController _officeAddressController =
      TextEditingController();
  final TextEditingController _officeAddressRegisterController =
      TextEditingController();

  Future selectPhoto() async {
    await ImagePicker().pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = File(image!.path);
      });
    });
  }

  Future selectPhoto1() async {
    await ImagePicker().pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image1 = File(image!.path);
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: whiteColor,
          shadowColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(
              color: Colors.black,
              size: size.height * 0.05 //change your color here
              ),
          title: Container(
            margin: EdgeInsets.only(right: size.width * 0.07),
            child: Center(
              child: appText(
                title: "Personal Details",
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.015,
                ),
                uploadDoc('Barangay certificate \n(Maximum Size is 10 MB)',
                    _image, selectPhoto, 'Upload File/Image'),
                const SizedBox(
                  height: 20,
                ),
                uploadDoc('Police clearance \n(Maximum Size is 10 MB)', _image1,
                    selectPhoto1, 'Upload File/Image'),
                const SizedBox(
                  height: 20,
                ),
                AppTextField(
                  controller: _officeAddressController,
                  labelText: 'Office Address',
                ),
                const SizedBox(
                  height: 20,
                ),
                AppTextField(
                  controller: _officeAddressRegisterController,
                  labelText: 'Office Register Number(Optional)',
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: kPrimaryColor,
                        width: 1.0,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      appText(
                          title: 'Gender',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: kPrimaryLightColor,
                              borderRadius: BorderRadius.circular(29),
                            ),
                            child: Radio(
                              value: 1,
                              groupValue: genderID,
                              activeColor: kPrimaryColor,
                              focusColor: kPrimaryLightColor,
                              onChanged: (val) {
                                setState(() {
                                  radioButtonGender = 'male';
                                  genderID = 1;
                                  debugPrint("===========gender is $genderID");
                                });
                              },
                            ),
                          ),
                          appText(title: 'Male', fontSize: 17),
                          const SizedBox(
                            width: 50,
                          ),
                          Radio(
                            value: 2,
                            groupValue: genderID,
                            activeColor: kPrimaryColor,
                            focusColor: kPrimaryLightColor,
                            onChanged: (val) {
                              setState(() {
                                radioButtonGender = 'female';
                                genderID = 2;
                              });
                            },
                          ),
                          appText(title: 'Female', fontSize: 17),
                        ],
                      ),
                      const SizedBox(height: 12.0),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(color: primaryTextColor, spreadRadius: 0),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            appText(
                                title: "Select Plan",
                                fontSize: 16,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold),
                          ],
                        ),
                        const SizedBox(height: 12.0),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Radio(
                                      value: 1,
                                      groupValue: id,
                                      activeColor: kPrimaryColor,
                                      focusColor: kPrimaryLightColor,
                                      onChanged: (val) {
                                        setState(() {
                                          radioButtonItem = 'Monthly';
                                          id = 1;
                                          planAmount = '100';
                                        });
                                      },
                                    ),
                                    appText(title: 'Monthly', fontSize: 17),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 2,
                                      groupValue: id,
                                      activeColor: kPrimaryColor,
                                      focusColor: kPrimaryLightColor,
                                      onChanged: (val) {
                                        setState(() {
                                          radioButtonItem = 'Quarterly';
                                          id = 2;
                                          planAmount = '200';
                                        });
                                      },
                                    ),
                                    appText(title: 'Yearly', fontSize: 17),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 3,
                                      groupValue: id,
                                      activeColor: kPrimaryColor,
                                      focusColor: kPrimaryLightColor,
                                      onChanged: (val) {
                                        setState(() {
                                          radioButtonItem = 'Yearly';
                                          id = 3;
                                          planAmount = '300';
                                        });
                                      },
                                    ),
                                    appText(title: 'Quarterly', fontSize: 17)
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                Container(
                  margin:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "PlanAmount: " + planAmount + "  Peso",
                        style: const TextStyle(
                          fontSize: 17.0,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer<RegistrationProvider>(
                        builder: (context, provider, child) {
                      return AppButton(
                        isLoading: provider.showLoader,
                        title: "Submit",
                        textColor: Colors.white,
                        onPressed: () {
                          checkValidation();
                        },
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkValidation() {
    validateConnectivity(
        context: context,
        provider: () {
          if (_image == null) {
            showToast('Please upload barangay certificate.');
          } else if (_image1 == null) {
            showToast('Please upload police clearance.');
          } else if (_officeAddressController.text.isEmpty) {
            showToast('Please enter office address.');
          } else {
            var provider =
                Provider.of<RegistrationProvider>(context, listen: false);
            Map<String, dynamic> body = {
              'name': widget.name,
              'password': widget.password,
              'email': widget.email,
              'contact_no': widget.phone,
              'age': widget.age,
              'role': "agent",
              "gender": radioButtonGender.toString(),
              'officeaddress': _officeAddressController.text,
              'officeregister': _officeAddressRegisterController.text,
              'businesstype': radioButtonItem.toString(),
            };

            provider.registration(body, context: context, file: [
              _image!,
              _image1!
            ], fileKay: [
              'barangaycertificate',
              'policeclearance'
            ]).then((value) {
              if (value) {
                showToast('Agent registered successfully.', isSuccess: true);
                Navigator.of(context)
                  ..pop()
                  ..pop();
              }
            });
          }
        });
  }

  Widget uploadDoc(
      String title, File? imageFile, void Function() onTap, String subTitle) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(5),
            ),
            child: imageFile == null
                ? Center(
                    child: Icon(Icons.image, color: Colors.grey[400]),
                  )
                : FittedBox(
                    fit: BoxFit.fill,
                    child: Image.file(imageFile),
                  ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appText(title: '${title}*', fontWeight: FontWeight.bold),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: onTap,
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: appText(
                          title: subTitle,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
