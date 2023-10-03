import 'package:flutter/material.dart';
import 'package:threeclick/chatting/conversation_tab.dart';
import 'package:threeclick/screens/agent/agent_home_page.dart';
import 'package:threeclick/screens/agent/history_page.dart';
import 'package:threeclick/screens/common/profile_page.dart';
import 'package:threeclick/styles/app_colors.dart';

class AgentBottomNavigation extends StatefulWidget {
  const AgentBottomNavigation({Key? key}) : super(key: key);
  @override
  _AgentBottomNavigationState createState() => _AgentBottomNavigationState();
}

class _AgentBottomNavigationState extends State<AgentBottomNavigation> {
  int currentIndex = 0;

  /// Set a type current number a layout class
  Widget callPage(int current) {
    switch (current) {
      case 0:
        return const HistoryPage();
      case 1:
        return const ConversationTab();
      case 2:
        return const AgentHomePage();
      case 3:
        return const ConversationTab();
      case 4:
        return const ProfilePage();
      default:
        return const HistoryPage();
    }
  }

  /// Build BottomNavigationBar Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: callPage(currentIndex),
      bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              canvasColor: Colors.white,
              textTheme: Theme.of(context).textTheme.copyWith(
                  caption: TextStyle(color: Colors.black26.withOpacity(0.15)))),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            fixedColor: kPrimaryColor,
            onTap: (value) {
              currentIndex = value;
              setState(() {});
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 20.0,
                ),
                label: "Home",
                // ignore: deprecated_member_use
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_bag,
                  size: 20.0,
                ),
                label: "My Jobs",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.verified,
                  size: 20.0,
                ),
                label: "Applicants",
                // ignore: deprecated_member_use
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.chat,
                  size: 20.0,
                ),
                label: "Chats",
                // ignore: deprecated_member_use
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: 20.0,
                ),
                label: "Profile",
                // ignore: deprecated_member_use
              ),
            ],
          )),
    );
  }
}
