import 'package:ehjezly_app/Constant/constant.dart';
import 'package:ehjezly_app/Screens/forget_password_screen.dart';
import 'package:ehjezly_app/Screens/login_screen.dart';
import 'package:ehjezly_app/Screens/no_internet_screen.dart';
import 'package:ehjezly_app/Screens/signup_screen.dart';
import 'package:ehjezly_app/widgets/user_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Bottom_Navigation/Oppointment/select_doctor.dart';
import 'Bottom_Navigation/contact_us.dart';
import 'Bottom_Navigation/home_page.dart';
import 'Bottom_Navigation/notification_page.dart';
import 'Bottom_Navigation/setting_page.dart';

enum BottomSection {
  home,
  contact,
  appointment,
  notification,
  setting,
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedIndex = 2;
  PageController pageController = PageController();
   final List<Widget> _widgetOptions = <Widget>[
        const ContactUsPage(),
        const LoginScreen(),
        const HomePage(),
        const ForgetPasswordScreen(),
        const SettingPage()
  ];
  final Map<int, GlobalKey<NavigatorState>> navigatorKeys = {
    0: GlobalKey<NavigatorState>(),
    1: GlobalKey<NavigatorState>(),
    2: GlobalKey<NavigatorState>(),
    3: GlobalKey<NavigatorState>(),
    4: GlobalKey<NavigatorState>(),
  };

  String title = "";
  setTitle(int index) {
    setState(() {
      switch (index) {
        case 0:
          {
            title = "Contact Us";

          }
          break;
        case 1:
          {
            title = "Book a appointment";
          }
          break;
        case 2:
          {
            title = "Home";
          }
          break;
        case 3:
          {
            title = "Notifications";
          }
          break;
        case 4:
          {
            title = "Settings";
          }
          break;
      }
    });
  }
  @override
  void initState() {
    super.initState();
    setTitle(_selectedIndex);
    pageController = PageController(initialPage: 2);
  }

  Widget _buildOffstageNavigator(int tabItem) {
    return Offstage(
      offstage: _selectedIndex != tabItem,
      child: tabItem == 2
          ? const HomePage()
          : TabNavigator(
        navigateKey:
        navigatorKeys[tabItem]!,
        tabItem: tabItem,
      ),
    );
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      setTitle(index);
    });
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: TabNavigator(
      //   navigateKey:
      //   navigatorKeys[_selectedIndex]!,
      //   tabItem: _selectedIndex,
      // ),
      // Stack(
      //   children: [
      //     _buildOffstageNavigator(0),
      //     _buildOffstageNavigator(1),
      //     _buildOffstageNavigator(2),
      //     _buildOffstageNavigator(3),
      //     _buildOffstageNavigator(4),
      //   ],
      // ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu,color: kButtonColor,),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        elevation: 0,
        actions: [
          Obx(()=>(
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CircleAvatar(
                backgroundColor: kLightGreyColor,
                backgroundImage: userController.userData.value.profile != null?NetworkImage(userController.userData.value.profile!):null,
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: userController.userData.value.profile == null?const Image(
                    image: AssetImage('images/avatar.png'),
                    fit: BoxFit.cover,
                  ):null,
                ),
              ),
            )
          ))
        ],
        title: Text(title,style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: kButtonColor
        ),),
      ),
      drawer: const UserDrawer(),
      body: PageView(
        controller: pageController,
        onPageChanged: (page) {
          setState(() {
            _selectedIndex = page;
            setTitle(page);
          });
        },
        children: const [
          ContactUsPage(),
          AppointmentBook1(),
          HomePage(),
          NotificationPage(),
          SettingPage()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 16.0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.call,
            ),
            label: ""
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_today,
            ),
              label: ""
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
              label: ""
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
            ),
              label: ""
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
              label: ""
          ),
        ],
        unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        selectedItemColor: kButtonColor,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
  }



class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigateKey;
  final int tabItem;
  const TabNavigator(
      {Key? key, required this.navigateKey, required this.tabItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = const HomePage();
    if (tabItem == 0) {
      child = const ContactUsPage();
    } else if (tabItem == 1) {
      child = const AppointmentBook1();
    } else if (tabItem == 2) {
      child = const HomePage();
    } else if (tabItem == 3) {
      child = const NotificationPage();
    } else if (tabItem == 4) {
      child = const SettingPage();
    }

    return Navigator(
      key: navigateKey,
      onGenerateRoute: (routeSetting) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}
