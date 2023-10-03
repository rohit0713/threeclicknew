import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:threeclick/custom/app_button.dart';
import 'package:threeclick/custom/app_dropdown.dart';
import 'package:threeclick/custom/app_text.dart';
import 'package:threeclick/custom/app_text_field.dart';
import 'package:threeclick/custom/have_account.dart';
import 'package:threeclick/custom/navigation.dart';
import 'package:threeclick/custom/toast_message.dart';
import 'package:threeclick/screens/common/login.dart';
import 'package:threeclick/screens/common/registration/otp_verification.dart';
import 'package:threeclick/styles/app_colors.dart';
import 'package:threeclick/view_models/common/registration_provider.dart';

import '../../../custom/validate_connectivity.dart';

class EmployeeReg extends StatefulWidget {
  const EmployeeReg({super.key});

  @override
  State<EmployeeReg> createState() => _EmployeeRegState();
}

class _EmployeeRegState extends State<EmployeeReg> {
  bool isReferral = true;
  TextEditingController refCode = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController conPassword = TextEditingController();
  String suffix = 'Mr.';
  TextEditingController fName = TextEditingController();
  TextEditingController mName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController dob = TextEditingController();
  String? gender;
  String? nationality;
  TextEditingController buildingNo = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController village = TextEditingController();
  String? province;
  String? city;
  TextEditingController zipCode = TextEditingController();
  TextEditingController age = TextEditingController();
  int referredId = 2;
  int businessId = 1;
  String countryCode = '+63';
  bool isVerified = false;
  bool passOb = true;
  bool conPassOb = true;
  final _key = GlobalKey<FormState>();
  File? _image;
  File? _image1;
  File? _image2;
  _getNationality() {
    validateConnectivity(
        context: context,
        provider: () {
          var provider =
              Provider.of<RegistrationProvider>(context, listen: false);
          provider.getProvinceList(context: context);
        });
  }

  _getCity(String id) {
    validateConnectivity(
        context: context,
        provider: () {
          var provider =
              Provider.of<RegistrationProvider>(context, listen: false);
          provider.getCityList(context: context, id: id);
        });
  }

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
    _getNationality();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: kPrimaryColor,
                height: size.height * 0.35,
                width: size.width,
                child: Image.asset(
                  "assets/icons/logo.png",
                  height: size.height * 0.35,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 4, right: 4),
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 30, left: 16, right: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                appText(
                                    title: "Do You Have Referral?",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                    color: kPrimaryColor)
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: Radio(
                                          value: 1,
                                          groupValue: referredId,
                                          activeColor: kPrimaryColor,
                                          focusColor: kPrimaryLightColor,
                                          onChanged: (val) {
                                            setState(() {
                                              isReferral = false;
                                              referredId = 1;
                                            });
                                            refCode.clear();
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      appText(
                                        title: 'No',
                                        fontSize: 17,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: Radio(
                                          value: 2,
                                          groupValue: referredId,
                                          activeColor: kPrimaryColor,
                                          focusColor: kPrimaryLightColor,
                                          onChanged: (val) {
                                            setState(() {
                                              isReferral = true;
                                              referredId = 2;
                                            });
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      appText(
                                        title: 'Yes',
                                        fontSize: 17,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Visibility(
                              visible: isReferral,
                              child: AppTextField(
                                controller: refCode,
                                labelText: 'Referral Code',
                                onChanged: (value) {
                                  if (refCode.text.isNotEmpty) {
                                    getReferralCode();
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            appText(
                              title: "Phone Number*",
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: kPrimaryColor,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              height: 60,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                  borderRadius: BorderRadius.circular(9)),
                              child: TextFormField(
                                controller: phoneNumber,
                                style: const TextStyle(
                                  fontFamily: 'WorkSans',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  prefix: const Text(
                                    "+91 ",
                                    style: TextStyle(
                                      fontFamily: 'WorkSans',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  suffixIcon: InkWell(
                                      onTap: () {
                                        if (phoneNumber.text.length < 10) {
                                          showToast(
                                              'Please enter valid phone number.');
                                        } else {
                                          sendOTP();
                                        }
                                      },
                                      child: !isVerified
                                          ? Container(
                                              width: 80,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 6),
                                              decoration: BoxDecoration(
                                                border: Border.all(width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                color: kPrimaryColor,
                                              ),
                                              child: Center(
                                                child: appText(
                                                  title: "Verify",
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          : const Icon(
                                              Icons
                                                  .check_circle_outline_outlined,
                                              size: 35,
                                              color: Colors.green,
                                            )),
                                  hintText: '',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: HexColor('#B9BABC'),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            AppTextField(
                              controller: email,
                              labelText: 'Email*',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            AppTextField(
                              controller: password,
                              labelText: 'Password*',
                              obscureText: passOb,
                              iconData: IconButton(
                                onPressed: () {
                                  setState(() {
                                    passOb = !passOb;
                                  });
                                },
                                icon: passOb
                                    ? const Icon(
                                        Icons.visibility,
                                        color: blackColor,
                                      )
                                    : const Icon(
                                        Icons.visibility_off,
                                        color: blackColor,
                                      ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            AppTextField(
                              controller: conPassword,
                              labelText: 'Confirm Password*',
                              obscureText: conPassOb,
                              iconData: IconButton(
                                onPressed: () {
                                  setState(() {
                                    conPassOb = !conPassOb;
                                  });
                                },
                                icon: conPassOb
                                    ? const Icon(
                                        Icons.visibility,
                                        color: blackColor,
                                      )
                                    : const Icon(
                                        Icons.visibility_off,
                                        color: blackColor,
                                      ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: AppDropDown(
                                    dropdownValue: suffix,
                                    dropDownItems: const ['Mr.', 'Mrs.'],
                                    labelText: 'Select',
                                    onChanged: (value) {
                                      setState(() {
                                        suffix = value!;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: AppTextField(
                                    controller: lName,
                                    labelText: 'Last Name*',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: AppTextField(
                                    controller: fName,
                                    labelText: 'First Name*',
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: AppTextField(
                                    controller: mName,
                                    labelText: 'Middle Name',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      _showDatePicker(dob);
                                    },
                                    child: IgnorePointer(
                                      child: AppTextField(
                                        controller: dob,
                                        labelText: 'Date of Birth*',
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: AppDropDown(
                                    dropdownValue: gender,
                                    dropDownItems: const [
                                      'Male',
                                      'Female',
                                      "Other"
                                    ],
                                    labelText: 'Select',
                                    hint: 'Gender*',
                                    onChanged: (value) {
                                      setState(() {
                                        gender = value!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                appText(
                                    title: "Where do you live?",
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: kPrimaryColor),
                                appText(
                                    title: "Your Local Address.",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: kPrimaryColor),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            AppTextField(
                              controller: buildingNo,
                              labelText: 'Unit no./House no./Building no',
                            ),
                            appText(title: 'Type N/A if not applicable'),
                            const SizedBox(
                              height: 20,
                            ),
                            AppTextField(
                              controller: street,
                              labelText: 'Street*',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            AppTextField(
                              controller: village,
                              labelText: 'Village/Subdivision*',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Consumer<RegistrationProvider>(
                                      builder: (context, provider, child) {
                                    return AppDropDown(
                                      dropdownValue: province,
                                      dropDownItems: provider.provinceName,
                                      labelText: 'Select',
                                      hint: 'Province*',
                                      onChanged: (value) {
                                        setState(() {
                                          province = value!;
                                          var index = provider.provinceName
                                              .indexOf(value);
                                          var id = provider.province[index].id
                                              .toString();
                                          city = null;
                                          _getCity(id);
                                        });
                                      },
                                    );
                                  }),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Consumer<RegistrationProvider>(
                                      builder: (context, provider, child) {
                                    return AppDropDown(
                                      dropdownKey: _key,
                                      dropdownValue: city,
                                      dropDownItems: provider.cityName,
                                      labelText: 'Select',
                                      hint: 'City*',
                                      onChanged: (value) {
                                        setState(() {
                                          city = value!;
                                        });
                                      },
                                    );
                                  }),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            AppTextField(
                              controller: zipCode,
                              labelText: 'Zip Code*',
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            uploadDoc('Barangay Certificate', _image,
                                selectPhoto, 'Upload/picture'),
                            const SizedBox(
                              height: 30,
                            ),
                            uploadDoc('Police Clearance', _image1, selectPhoto1,
                                'Upload/picture'),
                            const SizedBox(
                              height: 30,
                            ),
                            uploadDoc('Bio Data/Resume', _image2, selectPhoto2,
                                'Upload/Picture'),
                            const SizedBox(
                              height: 40,
                            ),
                            AppButton(
                              onPressed: () {
                                validateConnectivity(
                                    context: context,
                                    provider: () {
                                      _submitData();
                                    });
                              },
                              title: 'SIGN UP',
                              width: 1,
                            ),
                            SizedBox(height: size.height * 0.03),
                            AlreadyHaveAnAccountCheck(
                              login: false,
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const Login(
                                        role: 'Agent',
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _submitData() {
    if (phoneNumber.text.length < 10) {
      showToast('Please enter phone number.');
    } else if (int.tryParse(phoneNumber.text) == null) {
      showToast('Please enter valid phone number.');
    } else if (email.text.isNotEmpty && !isValidEmail(email.text)) {
      showToast('Please enter valid email.');
    } else if (password.text.isEmpty) {
      showToast('Please enter password.');
    } else if (!isValidPassword(password.text) || password.text.length < 8) {
      showToast(
          'Password must contain at least 8 characters with\none uppercase , one lowercase , one number and\none special character.');
    } else if (password.text != conPassword.text) {
      showToast('Password and confirm password did not match.');
    } else if (lName.text.isEmpty) {
      showToast('Please enter last name.');
    } else if (fName.text.isEmpty) {
      showToast('Please enter first name.');
    } else if (dob.text.isEmpty) {
      showToast('Please enter date of birth.');
    } else if (!isAdult(dob.text)) {
      showToast('Age should be 16 year or above');
    } else if (gender == null) {
      showToast('Please select gender.');
    } else if (street.text.isEmpty) {
      showToast('Please enter street.');
    } else if (village.text.isEmpty) {
      showToast('Please enter village/subdivision.');
    } else if (province == null) {
      showToast('Please select province.');
    } else if (city == null) {
      showToast('Please select city.');
    } else if (zipCode.text.isEmpty) {
      showToast('Please zip code.');
    } else if (_image == null) {
      showToast('Please barangay certificate.');
    } else if (_image1 == null) {
      showToast('Please police clearance.');
    } else if (_image2 == null) {
      showToast('Please upload bio data/resume.');
    } else {
      validateConnectivity(
          context: context,
          provider: () {
            var provider =
                Provider.of<RegistrationProvider>(context, listen: false);
            Map<String, dynamic> body = {
              'password': password.text,
              'name': fName.text,
              'email': email.text,
              'contact_no': phoneNumber.text,
              'age': age.text,
              'gender': gender?.toLowerCase(),
              'role': 'user',
              'Preferjoblocation': city,
              'birthdate': dob.text,
              'province': province,
              'city': city,
              'state': street.text,
              'country': 'India',
              'zipcode': zipCode.text,
              'address': '${buildingNo.text} ${street.text} ${village.text}',
              'jobtype': '',
              'reference_code': refCode.text,
              'tinnumber': '',
              'fullyvaccinated': 'yes',
              'alternatephonenumber': '',
              'company_name': '',
              'Looking': '',
              'end_date': '',
              'refer_code': refCode.text
            };
            provider.registration(body, context: context, file: [
              _image!,
              _image1!,
              _image2!
            ], fileKay: [
              'barangaycertificate',
              'policeclearance',
              'biodata'
            ]).then((value) {
              if (value) {
                showToast('Employee registered successfully.', isSuccess: true);
                Navigator.pop(context);
              }
            });
          });
    }
  }

  void sendOTP() async {
    validateConnectivity(
        context: context,
        provider: () {
          var provider =
              Provider.of<RegistrationProvider>(context, listen: false);
          Map<String, dynamic> body = {
            'mobile_no': phoneNumber.text,
          };
          provider.sendOtp(context: context, body: body).then((value) async {
            if (value) {
              showToast('OTP has been sent on your mobile number.',
                  isSuccess: true);
              var res = await navigateTo(
                  context: context,
                  to: OTPVerification(
                    phone: phoneNumber.text,
                    hashKey: provider.hashKey,
                    isVerified: isVerified,
                  ));
              if (res != null) {
                setState(() {
                  isVerified = true;
                });
              }
            }
          });
        });
  }

  void getReferralCode() async {
    validateConnectivity(
        context: context,
        provider: () {
          var provider =
              Provider.of<RegistrationProvider>(context, listen: false);
          Map<String, dynamic> body = {
            'refer_code': refCode.text,
          };
          provider.getReferral(context: context, body: body);
        });
  }

  _showDatePicker(TextEditingController date) async {
    var pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        date.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  Widget uploadDoc(
      String title, File? imageFile, void Function() onTap, String subTitle) {
    return SizedBox(
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
                    style: const TextStyle(fontWeight: FontWeight.bold),
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
                          style: const TextStyle(fontWeight: FontWeight.w600),
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

  bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  bool isValidPassword(String password) {
    return RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)").hasMatch(password);
  }

  bool isAdult(String birthDateString) {
    String datePattern = "dd/MM/yyyy";

    DateTime birthDate = DateFormat(datePattern).parse(birthDateString);
    DateTime today = DateTime.now();

    int yearDiff = today.year - birthDate.year;
    int monthDiff = today.month - birthDate.month;
    int dayDiff = today.day - birthDate.day;

    return yearDiff > 16 ||
        yearDiff == 16 && monthDiff > 0 ||
        yearDiff == 16 && monthDiff == 0 && dayDiff >= 0;
  }
}
