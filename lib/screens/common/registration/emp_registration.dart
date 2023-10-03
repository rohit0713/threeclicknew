import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:threeclick/custom/app_button.dart';
import 'package:threeclick/custom/app_dropdown.dart';
import 'package:threeclick/custom/app_text.dart';
import 'package:threeclick/custom/app_text_field.dart';
import 'package:threeclick/custom/navigation.dart';
import 'package:threeclick/custom/toast_message.dart';
import 'package:threeclick/custom/validate_connectivity.dart';
import 'package:threeclick/screens/common/registration/emp_personal_info.dart';
import 'package:threeclick/screens/common/registration/otp_verification.dart';
import 'package:threeclick/styles/app_colors.dart';
import 'package:threeclick/view_models/common/registration_provider.dart';

class EmpRegistration extends StatefulWidget {
  const EmpRegistration({super.key});

  @override
  State<EmpRegistration> createState() => _EmpRegistrationState();
}

class _EmpRegistrationState extends State<EmpRegistration> {
  String businessType = 'Company';
  bool isReferral = true;
  TextEditingController refCode = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController conPassword = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController companyLocation = TextEditingController();
  TextEditingController tinNumber = TextEditingController();
  TextEditingController estDate = TextEditingController();
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
  _getNationality() {
    validateConnectivity(
        context: context,
        provider: () {
          var provider =
              Provider.of<RegistrationProvider>(context, listen: false);
          provider.getNationalityList(context: context);
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
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    appText(
                                      title: "Business Type",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                      color: kPrimaryColor,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10.0),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: Radio(
                                              value: 1,
                                              groupValue: businessId,
                                              activeColor: kPrimaryColor,
                                              focusColor: kPrimaryLightColor,
                                              onChanged: (val) {
                                                setState(() {
                                                  businessType = 'Company';
                                                  businessId = 1;
                                                  countryCode = '+63';
                                                  age.text = '';
                                                });
                                              },
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          appText(
                                            title: 'Company',
                                            fontSize: 17.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: Radio(
                                              value: 2,
                                              groupValue: businessId,
                                              activeColor: kPrimaryColor,
                                              focusColor: kPrimaryLightColor,
                                              onChanged: (val) {
                                                setState(() {
                                                  businessType = 'Individual';
                                                  businessId = 2;
                                                  countryCode = '+91';
                                                  companyName.text = '';
                                                  companyLocation.text = '';
                                                  tinNumber.text = '';
                                                  estDate.text = '';
                                                  nationality = null;
                                                });
                                              },
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          appText(
                                            title: 'Individual',
                                            fontSize: 17.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 20.0),
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
                            Visibility(
                              visible: businessType.toLowerCase() == 'company',
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  appText(
                                      title: "Company Info",
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: kPrimaryColor),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: AppTextField(
                                          controller: companyName,
                                          labelText: 'Company Name*',
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: AppTextField(
                                          controller: companyLocation,
                                          labelText: 'Company Location*',
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: AppTextField(
                                          controller: tinNumber,
                                          labelText: 'Tin Number*',
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            _showDatePicker(estDate);
                                          },
                                          child: IgnorePointer(
                                            child: AppTextField(
                                              controller: estDate,
                                              labelText: 'Establishment Date*',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            appText(
                              title: "Personal Info",
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor,
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
                            Visibility(
                                visible:
                                    businessType.toLowerCase() != 'company',
                                child: IgnorePointer(
                                  child: AppTextField(
                                    controller: age,
                                    labelText: 'Age*',
                                    readOnly: true,
                                  ),
                                )),
                            Visibility(
                              visible: businessType.toLowerCase() == 'company',
                              child: Consumer<RegistrationProvider>(
                                  builder: (context, provider, child) {
                                return AppDropDown(
                                  dropdownValue: nationality,
                                  dropDownItems: provider.nationality,
                                  labelText: 'Select',
                                  hint: 'Nationality*',
                                  onChanged: (value) {
                                    setState(() {
                                      nationality = value!;
                                    });
                                  },
                                );
                              }),
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
    } else if (companyName.text.isEmpty &&
        businessType.toLowerCase() == 'company') {
      showToast('Please enter company name.');
    } else if (companyLocation.text.isEmpty &&
        businessType.toLowerCase() == 'company') {
      showToast('Please enter company location.');
    } else if (tinNumber.text.isEmpty &&
        businessType.toLowerCase() == 'company') {
      showToast('Please enter tin number.');
    } else if (estDate.text.isEmpty &&
        businessType.toLowerCase() == 'company') {
      showToast('Please enter establishment date.');
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
    } else if (nationality == null && businessType.toLowerCase() == 'company') {
      showToast('Please select nationality.');
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
    } else {
      navigateTo(
          context: context,
          to: EmployerPersonalInfo(
              fName: fName.text,
              mNname: mName.text,
              lNname: lName.text,
              password: password.text,
              companyName: companyName.text,
              CompanyLocation: companyLocation.text,
              referralCode: refCode.text,
              tinNumber: tinNumber.text,
              establishDate: estDate.text,
              prefix: suffix,
              role: businessType,
              dob: dob.text,
              street: street.text,
              village: village.text,
              houseNumber: buildingNo.text,
              pinCode: zipCode.text,
              city: city ?? '',
              state: province ?? '',
              email: email.text,
              phone: phoneNumber.text,
              age: age.text,
              nationalId: nationality ?? '',
              gender: gender?.toLowerCase() ?? '',
              nationality: nationality ?? '',
              accountType: businessType));
    }
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
      if (date == dob) {
        setState(() {
          age.text = calculateAge(pickedDate).toString();
        });
      }
    }
  }

  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
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
}
