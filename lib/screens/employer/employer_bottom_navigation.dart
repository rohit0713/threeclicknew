import 'package:flutter/material.dart';
import 'package:threeclick/chatting/conversation_tab.dart';
import 'package:threeclick/screens/common/profile_page.dart';
import 'package:threeclick/screens/employer/my_job_applicants.dart';
import 'package:threeclick/screens/employer/my_jobs.dart';
import 'package:threeclick/screens/employer/search_screen.dart';
import 'package:threeclick/styles/app_colors.dart';

import 'employer_home_page.dart';

class BottomNavigationBarEmployer extends StatefulWidget {
  BottomNavigationBarEmployer({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarEmployer> createState() =>
      _BottomNavigationBarEmployerState();
}

class _BottomNavigationBarEmployerState
    extends State<BottomNavigationBarEmployer> {
  final PageController _pageController = PageController();
  int currentIndex = 0;
  List<Widget> _screens = [];

  bool singleVendor = false;

  @override
  void initState() {
    super.initState();
    _screens = [
      const EmployerHomePage(),
      const MyJobs(),
      const MyJobApplicants(),
      const ConversationTab(),
      const SearchScreen(),
      const ProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentIndex != 0) {
          _setPage(0);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.65),
          showUnselectedLabels: true,
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          items: _getBottomWidget(),
          onTap: (int index) {
            _setPage(index);
          },
          backgroundColor: kPrimaryColor,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _screens[currentIndex];
          },
        ),
      ),
    );
  }

  BottomNavigationBarItem _barItem(Widget icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: icon,
      label: label,
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      currentIndex = pageIndex;
    });
  }

  List<BottomNavigationBarItem> _getBottomWidget() {
    List<BottomNavigationBarItem> list = [];

    list.add(_barItem(
        (currentIndex == 0
            ? const Icon(
                Icons.home,
                size: 20.0,
              )
            : const Icon(
                Icons.home,
                size: 20.0,
              )),
        'Home',
        0));
    list.add(_barItem(
        (currentIndex == 0
            ? const Icon(
                Icons.shopping_bag,
                size: 20.0,
              )
            : const Icon(
                Icons.shopping_bag,
                size: 20.0,
              )),
        'My Jobs',
        1));
    list.add(_barItem(
        (currentIndex == 0
            ? const Icon(
                Icons.verified,
                size: 20.0,
              )
            : const Icon(
                Icons.verified,
                size: 20.0,
              )),
        'Applicants',
        2));
    list.add(_barItem(
        (currentIndex == 0
            ? const Icon(
                Icons.chat,
                size: 20.0,
              )
            : const Icon(
                Icons.chat,
                size: 20.0,
              )),
        'Chats',
        3));
    list.add(_barItem(
        (currentIndex == 0
            ? const Icon(
                Icons.search,
                size: 20.0,
              )
            : const Icon(
                Icons.search,
                size: 20.0,
              )),
        'Search',
        4));
    list.add(_barItem(
        (currentIndex == 0
            ? const Icon(
                Icons.person,
                size: 20.0,
              )
            : const Icon(
                Icons.person,
                size: 20.0,
              )),
        'Profile',
        5));

    return list;
  }
}
