import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:threeclick/custom/app_button.dart';
import 'package:threeclick/custom/app_text.dart';
import 'package:threeclick/custom/navigation.dart';
import 'package:threeclick/screens/employer/post_job.dart';
import 'package:threeclick/styles/app_colors.dart';
import 'package:threeclick/view_models/common/login_provider.dart';

class EmployerHomePage extends StatefulWidget {
  const EmployerHomePage({Key? key}) : super(key: key);

  @override
  State<EmployerHomePage> createState() => _EmployerHomePageState();
}

class _EmployerHomePageState extends State<EmployerHomePage> {
  String userName = "";
  String profileImage = '';
  List<String> list = [
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
  ];

  @override
  void initState() {
    getPreferenceData();
    super.initState();
  }

  getPreferenceData() async {
    var state = LoginProvider(await SharedPreferences.getInstance());
    setState(() {
      userName = state.userData.response?.user?[0].name ?? '';
      profileImage = state.userData.response?.user?[0].userimage ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Hello $userName",
                style: const TextStyle(
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white),
              ),
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(profileImage),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2 / 1.5,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                ),
                itemCount: list.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: appText(
                            title: '$index',
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      appText(
                        title: list[index],
                        color: Colors.black,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 40,
              ),
              AppButton(
                  width: 1,
                  onPressed: () {
                    slideTransition(
                        context: context,
                        to: PostJob(
                            userImage: profileImage, userName: userName));
                  },
                  title: 'Create job as per requirements'),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
