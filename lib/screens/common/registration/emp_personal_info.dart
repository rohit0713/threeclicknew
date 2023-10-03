import 'dart:io';

import 'package:flutter/cupertino.dart';
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

class EmployerPersonalInfo extends StatefulWidget {
  final String fName;
  final String mNname;
  final String lNname;
  final String password;
  final String companyName;
  final String CompanyLocation;
  final String referralCode;
  final String tinNumber;
  final String establishDate;
  final String prefix;
  final String dob;
  final String street;
  final String village;
  final String houseNumber;
  final String pinCode;
  final String city;
  final String state;
  final String email;
  final String phone;
  final String age;
  final String gender;
  final String nationality;
  final String role;
  final String accountType;
  final String nationalId;

  const EmployerPersonalInfo({
    Key? key,
    required this.fName,
    required this.mNname,
    required this.lNname,
    required this.password,
    required this.companyName,
    required this.CompanyLocation,
    required this.referralCode,
    required this.tinNumber,
    required this.establishDate,
    required this.prefix,
    required this.role,
    required this.dob,
    required this.street,
    required this.village,
    required this.houseNumber,
    required this.pinCode,
    required this.city,
    required this.state,
    required this.email,
    required this.phone,
    required this.age,
    required this.nationalId,
    required this.gender,
    required this.nationality,
    required this.accountType,
  }) : super(key: key);

  /*EmployerPersonalInfo(

  );*/

  @override
  _EmployerPersonalInfoState createState() => _EmployerPersonalInfoState();
}

class _EmployerPersonalInfoState extends State<EmployerPersonalInfo> {
  String radioButtonItem = 'Yearly';
  int id = 1;
  String planAmount = '1500';
  File? _image;
  File? _image1;
  File? _image2;
  String? dropdownValue;
  String? jobType;
  String? stay;
  TextEditingController _lookingForController = TextEditingController();
  TextEditingController _language = TextEditingController();
  TextEditingController _other = TextEditingController();
  bool isCheck = false;

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

  Future selectPhoto2() async {
    await ImagePicker().pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image2 = File(image!.path);
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        iconTheme: IconThemeData(
            color: Colors.white,
            size: size.height * 0.03 //change your color here
            ),
        title: appText(
          title: "Personal Details",
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: whiteColor,
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.04,
              ),
              uploadDoc(
                  'NBI Certificate',
                  _image,
                  selectPhoto,
                  widget.role == 'User'
                      ? 'Upload Govt Id'
                      : 'Upload BIR/Work Permit/Barangay Permit'),
              const SizedBox(
                height: 30,
              ),
              uploadDoc('Take Selfie with ID', _image1, selectPhoto1,
                  'Upload/Take Picture'),
              const SizedBox(
                height: 30,
              ),
              uploadDoc('Profile Picture', _image2, _showPicker,
                  'Upload/Take Picture'),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  appText(
                      title: "Looking",
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: kPrimaryColor),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  Container(
                    margin: EdgeInsets.all(size.width * 0.01),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(color: primaryTextColor, spreadRadius: 0),
                      ],
                    ),
                    height: size.height * 0.06,
                    width: size.width * 0.5,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: dropdownValue,
                        onChanged: (newValue) {
                          setState(() {
                            dropdownValue = newValue;
                            _other.text = '';
                            _language.text = '';
                            _lookingForController.text = '';
                          });
                        },
                        hint: const Text(
                          'Looking for',
                          style: TextStyle(
                              fontFamily: 'WorkSans',
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: kPrimaryColor,
                        ),
                        items: <String>[
                          'Yaya',
                          'Sales Boy',
                          'Sales Girl',
                          'Translator',
                          'Nurse',
                          'Cleaner',
                          'Tourist Guide',
                          'Receptionist',
                          'Driver',
                          'Helper',
                          'Others'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              Visibility(
                  visible: dropdownValue == 'Yaya',
                  child: AppTextField(
                    controller: _other,
                    labelText: 'Others/Factory worker',
                  )),
              Visibility(
                visible: dropdownValue == 'Translator',
                child: AppTextField(
                  controller: _language,
                  labelText: 'Looking For Other',
                ),
              ),
              Visibility(
                visible: dropdownValue == 'Others',
                child: AppTextField(
                  controller: _lookingForController,
                  labelText: 'Looking For Other',
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(size.width * 0.01),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(color: primaryTextColor, spreadRadius: 0),
                          ],
                        ),
                        height: size.height * 0.06,
                        width: size.width * 0.5,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: jobType,
                            onChanged: (newValue) {
                              setState(() {
                                jobType = newValue;
                              });
                            },
                            hint: appText(
                              title: 'Job Type',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            icon: const Icon(
                              // Add this
                              Icons.arrow_drop_down,
                              color: kPrimaryColor,
                            ),
                            items: <String>['Part Time', 'Full Time']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(size.width * 0.01),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(color: primaryTextColor, spreadRadius: 0),
                          ],
                        ),
                        height: size.height * 0.06,
                        width: size.width * 0.5,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: stay,
                            onChanged: (newValue) {
                              setState(() {
                                stay = newValue;
                              });
                            },
                            hint: const Text(
                              'Stay',
                              style: TextStyle(
                                  fontFamily: 'WorkSans',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: kPrimaryColor,
                            ),
                            items: <String>['Staying', 'Staying out']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12.0),
              Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  children: [
                    Checkbox(
                      activeColor: kPrimaryColor,
                      value: isCheck,
                      onChanged: (value) {
                        setState(() {
                          isCheck = !isCheck;
                        });
                      },
                    ),
                    appText(title: 'Accept terms & conditions')
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer<RegistrationProvider>(
                      builder: (context, provider, child) {
                    return AppButton(
                        isLoading: provider.showLoader,
                        onPressed: () {
                          checkValidation();
                        },
                        title: 'Submit');
                  })
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkValidation() {
    if (id.toString() == 0) {
    } else if (_image == null) {
      showToast('Please Upload NBI Certificate');
    } else if (_image1 == null) {
      showToast('Please Upload Selfie with ID');
    } else if (_image2 == null) {
      showToast('Please Upload Profile Image');
    } else if (dropdownValue == null && _lookingForController.text.isEmpty) {
      showToast('Please provide looking for option');
    } else if (dropdownValue != null &&
        dropdownValue == 'Translator' &&
        _language.text.isEmpty) {
      showToast('Please enter translator language');
    } else if (dropdownValue != null &&
        dropdownValue == 'Yaya' &&
        _other.text.isEmpty) {
      showToast('Please enter others/factory workers');
    } else if (dropdownValue == 'Others' &&
        _lookingForController.text.isEmpty) {
      showToast('Please provide looking for option');
    } else if (jobType == null) {
      showToast('Please select job type');
    } else if (stay == null) {
      showToast('Please select stay type');
    } else if (!isCheck) {
      showToast('Please accept terms & conditions');
    } else {
      employerRegister();
    }
  }

  Future<void> employerRegister() async {
    validateConnectivity(
        context: context,
        provider: () {
          var provider =
              Provider.of<RegistrationProvider>(context, listen: false);
          Map<String, dynamic> body = {
            "password": widget.password,
            "name": widget.fName,
            "middle_name ": widget.mNname,
            "last_name ": widget.lNname,
            "email": widget.email,
            "contact_no": widget.phone,
            "age": widget.age,
            "gender": widget.gender,
            "role": widget.role,
            "Preferjoblocation": widget.city,
            "birthdate": widget.dob,
            "province": widget.state,
            "city": widget.city,
            "state": widget.state,
            "country": "India",
            "zipcode": widget.pinCode,
            "address":
                "${widget.houseNumber} ${widget.street} ${widget.village}",
            "businesstype": widget.accountType,
            "tinnumber": widget.tinNumber,
            "company_name": widget.companyName,
            "refer_code": widget.referralCode,
            "national_id": widget.nationalId,
            "Looking": dropdownValue == 'Others'
                ? _lookingForController.text
                : dropdownValue,
            "jobtype": jobType ?? '',
            "stay": stay ?? '',
            "translator": _language.text,
            "plan": radioButtonItem,
            "plan_amount": planAmount,
            "worker": _other.text
          };
          provider.registration(body, context: context, file: [
            _image!,
            _image1!,
            _image2!
          ], fileKay: [
            'barangaycertificate',
            'selfiwith_id',
            'userimage'
          ]).then((value) {
            if (value) {
              showToast('Registered successfully.', isSuccess: true);
              Navigator.of(context)
                ..pop()
                ..pop();
            }
          });
        });
  }

  Widget uploadDoc(
      String title, File? imageFile, void Function() onTap, String subTitle) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 80,
              width: 80,
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
                height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${title}*',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
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
                          child: Text(
                            subTitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.w600),
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
      ),
    );
  }

  _showPicker() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Photo Library'),
                    onTap: () {
                      selectPhoto2();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    _getFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  _getFromCamera() async {
    await ImagePicker().pickImage(source: ImageSource.camera).then((image) {
      setState(() {
        _image2 = File(image!.path);
      });
    });
  }
}
