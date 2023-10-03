import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:threeclick/custom/app_button.dart';
import 'package:threeclick/custom/app_dropdown.dart';
import 'package:threeclick/custom/app_text.dart';
import 'package:threeclick/custom/app_text_field.dart';
import 'package:threeclick/custom/toast_message.dart';
import 'package:threeclick/custom/validate_connectivity.dart';
import 'package:threeclick/styles/app_colors.dart';
import 'package:threeclick/view_models/common/registration_provider.dart';

class PostJob extends StatefulWidget {
  final String userName;
  final String userImage;
  const PostJob({Key? key, required this.userImage, required this.userName})
      : super(key: key);

  @override
  _PostJobState createState() => _PostJobState();
}

class _PostJobState extends State<PostJob> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController noOfVacancyController = TextEditingController();

  TextEditingController postTitleValue = TextEditingController();
  String? title;
  String? postVacancyValue;
  int stateID = 0;
  String? stateValue;
  String? cityValue;

  @override
  void initState() {
    getProvince();
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  getProvince() {
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          shadowColor: kPrimaryColor,
          title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                appText(
                  title: "Hello ${widget.userName}",
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(widget.userImage),
                )
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(child: Tab1(size)),
      ),
    );
  }

  Widget Tab1(Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: 20,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appText(
                title: 'Create Job',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              SizedBox(
                height: size.height * 0.035,
              ),
              AppDropDown(
                hint: 'Select Job Title*',
                dropDownItems: const [
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
                ],
                onChanged: (value) {
                  setState(() {
                    title = value;
                  });
                },
              ),
              Visibility(
                visible: title == 'Others',
                child: AppTextField(
                  controller: postTitleValue,
                  labelText: 'Other',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              AppTextField(
                controller: descriptionController,
                labelText: 'Post Description',
              ),
              const SizedBox(
                height: 20,
              ),
              AppDropDown(
                hint: 'Select Vacancy',
                dropDownItems: const [
                  '1',
                  "2",
                  "3",
                  "5",
                  "7",
                ],
                onChanged: (value) {
                  setState(() {
                    postVacancyValue = value;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer<RegistrationProvider>(
                  builder: (context, provider, child) {
                return AppDropDown(
                  dropdownValue: stateValue,
                  dropDownItems: provider.provinceName,
                  labelText: 'Select',
                  hint: 'Province*',
                  onChanged: (value) {
                    setState(() {
                      stateValue = value!;
                      var index = provider.provinceName.indexOf(value);
                      var id = provider.province[index].id.toString();
                      cityValue = null;
                      _getCity(id);
                    });
                  },
                );
              }),
              const SizedBox(
                height: 20,
              ),
              Consumer<RegistrationProvider>(
                  builder: (context, provider, child) {
                return AppDropDown(
                  dropdownValue: cityValue,
                  dropDownItems: provider.cityName,
                  labelText: 'Select',
                  hint: 'City*',
                  onChanged: (value) {
                    setState(() {
                      cityValue = value!;
                    });
                  },
                );
              }),
              const SizedBox(
                height: 50,
              ),
              AppButton(
                  width: 1,
                  onPressed: () {
                    validateConnectivity(
                        context: context,
                        provider: () {
                          checkValidation();
                        });
                  },
                  title: 'POST')
            ],
          ),
        ),
      ],
    );
  }

  void checkValidation() {
    if (title == null) {
      showToast('Please select job title.');
    }
    if (title == 'Others' && postTitleValue.text.isEmpty) {
      showToast('Please enter other Job Title.');
    } else if (descriptionController.text.isEmpty) {
      showToast('Please enter job description.');
    } else if (postVacancyValue == null) {
      showToast('Please select vacancy.');
    } else if (stateValue == null) {
      showToast('Please select province.');
    } else if (cityValue == null) {
      showToast('Please select city.');
    } else {
      postData();
    }
  }

  postData() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // print(prefs.getString('sessionToken'));
    // setState(() {
    //   isloading = true;
    // });
    // final uri = 'http://3clickjob.ph/public/api/v1/job/create';
    // final headers = {
    //   "Authorization": "Bearer ${prefs.getString('sessionToken')}"
    // };
    // Map<String, dynamic> body = {
    //   'post': title == 'Others' ? postTitleValue.text : title,
    //   'description': descriptionController.text,
    //   'vacancy': postVacancyValue.toString(),
    //   'city': cityValue.toString(),
    //   'state': stateValue.toString(),
    //   'user_id': "${prefs.getString('userId')}",
    // };
    // print(body);
    // final encoding = Encoding.getByName('utf-8');
    // Response response = await post(
    //   Uri.parse(uri),
    //   body: body,
    //   headers: headers,
    //   encoding: encoding,
    // );

    // int statusCode = response.statusCode;
    // String responseBody = response.body;
    // var res = jsonDecode(response.body);
    // var msg = res["message"];
    // print("responseAddPost::$responseBody");
    // if (statusCode == 200) {
    //   setState(() {
    //     isloading = false;
    //   });
    //   FocusScope.of(context).requestFocus(FocusNode());
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: Text(msg),
    //     backgroundColor: Colors.green,
    //   ));
    //   Navigator.pop(context);
    // } else {
    //   setState(() {
    //     // isloading = false;
    //   });
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: Text(msg),
    //     backgroundColor: Colors.red,
    //   ));
    // }
  }
}
