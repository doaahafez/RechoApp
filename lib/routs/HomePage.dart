import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recho/routs/CallLogScreen.dart';
import 'package:recho/routs/MyProfile.dart';
import 'package:recho/routs/Splashscreen.dart';
import 'package:recho/routs/WalletScreen.dart';
import 'dart:async';

import 'package:recho/widgets/Header_With_Gradient.dart';

import 'ChatScreen.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final List<String> sentences = [
    "خدمات مميزة",
    "مشتركين محترفين",
    "توصيل مباشر",
  ];
  final List<List<Color>> gradients = [
    [Colors.green, Colors.green],
    [Colors.orange, Colors.blue],
    [Colors.purple, Colors.red],
  ];
  int currentIndex = 0;
  late Timer _timer;
  late TabController _tabController;


  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % sentences.length;
      });
    });
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  late final uid;
  late final email;
  late final userName;
  @override
  void initState() {
    super.initState();

    final User? user = FirebaseAuth.instance.currentUser;
    uid = user!.uid;
    // email = user.email;
    userName = user.displayName;
    print("userName from home $userName");

    _startTimer();
    _tabController = TabController(length: categories.length, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {}); // Update UI immediately when a tab is selected
      }
    });
  }
  final List<String> categories = ['الكل', 'طبيب', 'مهندس', 'مدرس', 'مترجم']; // Tab labels
  @override
  void dispose() {
    _tabController.dispose();
    _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Directionality( // Explicitly set text direction to RTL
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'اهلا بك $userName ',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
          actions: [
            Icon(Icons.person),
            SizedBox(width: 10),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Center(
                  child: Text(
                    'Recho',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),

              _buildDrawerItem(Icons.home, 'الرئيسية',HomePage()),
              _buildDrawerItem(Icons.person, 'حسابي الشخصي',Myprofile()),
              _buildDrawerItem(Icons.account_balance_wallet, 'محفظتي',WalletScreen()),
              _buildDrawerItem(Icons.call, 'سجل المكالمات',CallLogscreen()),
              _buildDrawerItem(Icons.file_copy, 'الشروط والأحكام',HomePage()),
              _buildDrawerItem(Icons.mail, 'اتصل بنا',HomePage()),
              _buildDrawerItem(Icons.logout, 'تسجيل الخروج',Splashscreen()),
            ],
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 10),
            HeaderWithGradient(
              text: sentences[currentIndex],
              gradientColors: gradients[currentIndex],
            ),
            const SizedBox(height: 10),

            TabBar(
              isScrollable: true,
              controller: _tabController,
              labelColor: Colors.white,
              // indicatorSize: TabBarIndicatorSize.tab,
              unselectedLabelColor: Colors.black,
              dividerHeight: 0,
              indicator: BoxDecoration(
                color: Colors.blue, // Selected tab background
                borderRadius: BorderRadius.circular(25), // Rounded corners
              ),

              // labelStyle: TextStyle( fontSize: 14),
              labelPadding: EdgeInsets.symmetric(horizontal: 8.0),
              tabAlignment: TabAlignment.start,
              tabs: List.generate(5, (index) {
                return _buildTab(
                  text: categories[index], // Text for the tab
                  isSelected: _tabController.index == index,
                  onTap: () {
                    // Update state and animate tab transition
                    setState(() {
                      _tabController.index = index;
                    });
                  },
                );
              }),
            ),
            SizedBox(height: 10),
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child:
              TextField(
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: 'ابحث عن مشتركك...',
                  filled: true,
                  fillColor: Colors.grey[200],
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),


            Expanded(
              child: TabBarView(controller: _tabController, children: [
                SingleChildScrollView(
                  child:Column(
                    children: [
                      GestureDetector(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // User avatar
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.blue,
                                  child: Text(
                                    "أ",
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                // User details
                                Column(
                                  children: [
                                    Text(
                                      "أحمد",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                    Text(
                                      "متصل الآن",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.green,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ],
                                ),
                                Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide.none
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 8),
                                        Text(
                                          "المهنة: طبيب",
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                          textAlign: TextAlign.right,
                                        ),
                                        Text(
                                          "المدينة: الرياض",
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                          textAlign: TextAlign.right,
                                        ),
                                        Text(
                                          "نبذة: مطور تطبيقات ويب بخبرة 5 سنوات",
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                          textAlign: TextAlign.right,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatScreen()));
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatScreen(reseiverId:Users[index]["UserUid"],)));
                        },
                      ),


                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // User avatar
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.blue,
                                child: Text(
                                  "س",
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              // User details
                              Column(
                                children: [
                                  Text(
                                    "سارة",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                  Text(
                                    "غير متصل",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                              Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide.none
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 8),
                                      Text(
                                        "المهنة: مهندسة",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                      Text(
                                        "المدينة: الرياض",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                      Text(
                                        "نبذة: مطور تطبيقات ويب بخبرة 5 سنوات",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // User avatar
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.blue,
                                child: Text(
                                  "م",
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              // User details
                              Column(
                                children: [
                                  Text(
                                    "محمد",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                  Text(
                                    "غير متصل",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                              Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide.none
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 8),
                                      Text(
                                        "المهنة: مدرس",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                      Text(
                                        "المدينة: الرياض",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                      Text(
                                        "نبذة: مطور تطبيقات ويب بخبرة 5 سنوات",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // User avatar
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.blue,
                                child: Text(
                                  "أ",
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              // User details
                              Column(
                                children: [
                                  Text(
                                    "أحمد",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                  Text(
                                    "متصل الآن",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.green,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                              Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide.none
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 8),
                                      Text(
                                        "المهنة: مترجم",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                      Text(
                                        "المدينة: الرياض",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                      Text(
                                        "نبذة: مطور تطبيقات ويب بخبرة 5 سنوات",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                  // child: Column(
                  //
                  //   children: [
                  //     Card(
                  //       elevation: 3,
                  //       child: ListTile(
                  //         leading: CircleAvatar(
                  //           backgroundColor: Colors.blue,
                  //           child: Icon(Icons.person, color: Colors.white),
                  //         ),
                  //         title: Text(
                  //           'أحمد محمد',
                  //           textAlign: TextAlign.right,
                  //         ),
                  //         subtitle: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.end,
                  //           children: [
                  //             Text(
                  //               'طبيب عام',
                  //               textAlign: TextAlign.right,
                  //             ),
                  //             Text(
                  //               'المملكة العربية السعودية',
                  //               textAlign: TextAlign.right,
                  //             ),
                  //             Text(
                  //               'طبيب عام مع خبرة 10 سنوات في مجال الطب العام والطوارئ.',
                  //               maxLines: 2,
                  //               overflow: TextOverflow.ellipsis,
                  //               textAlign: TextAlign.right,
                  //             ),
                  //           ],
                  //         ),
                  //         trailing: ElevatedButton(
                  //           style: const ButtonStyle(backgroundColor:WidgetStatePropertyAll(Colors.grey)  ),
                  //           onPressed: () {},
                  //           child: Text('غير متصل',style: TextStyle(color: Colors.white),),
                  //         ),
                  //       ),
                  //     ),
                  //     Card(
                  //       elevation: 3,
                  //       child: ListTile(
                  //         leading: CircleAvatar(
                  //           backgroundColor: Colors.blue,
                  //           child: Icon(Icons.person, color: Colors.white),
                  //         ),
                  //         title: Text(
                  //           ' محمد',
                  //           textAlign: TextAlign.right,
                  //         ),
                  //         subtitle: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.end,
                  //           children: [
                  //             Text(
                  //               'مهندس',
                  //               textAlign: TextAlign.right,
                  //             ),
                  //             Text(
                  //               'المملكة العربية السعودية',
                  //               textAlign: TextAlign.right,
                  //             ),
                  //             Text(
                  //               'طبيب عام مع خبرة 10 سنوات في مجال الطب العام والطوارئ.',
                  //               maxLines: 2,
                  //               overflow: TextOverflow.ellipsis,
                  //               textAlign: TextAlign.right,
                  //             ),
                  //           ],
                  //         ),
                  //         trailing: ElevatedButton(
                  //           style: const ButtonStyle(backgroundColor:WidgetStatePropertyAll(Colors.red)  ),
                  //           onPressed: () {},
                  //           child: Text('متصل',style: TextStyle(color: Colors.white),),
                  //         ),
                  //       ),
                  //     ),
                  //     Card(
                  //       elevation: 3,
                  //       child: ListTile(
                  //         leading: CircleAvatar(
                  //           backgroundColor: Colors.blue,
                  //           child: Icon(Icons.person, color: Colors.white),
                  //         ),
                  //         title: Text(
                  //           'أحمد',
                  //           textAlign: TextAlign.right,
                  //         ),
                  //         subtitle: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.end,
                  //           children: [
                  //             Text(
                  //               'مدرس',
                  //               textAlign: TextAlign.right,
                  //             ),
                  //             Text(
                  //               'المملكة العربية السعودية',
                  //               textAlign: TextAlign.right,
                  //             ),
                  //             Text(
                  //               'طبيب عام مع خبرة 10 سنوات في مجال الطب العام والطوارئ.',
                  //               maxLines: 2,
                  //               overflow: TextOverflow.ellipsis,
                  //               textAlign: TextAlign.right,
                  //             ),
                  //           ],
                  //         ),
                  //         trailing: ElevatedButton(
                  //           style: const ButtonStyle(backgroundColor:WidgetStatePropertyAll(Colors.red)  ),
                  //           onPressed: () {},
                  //           child: Text('متصل',style: TextStyle(color: Colors.white),),
                  //         ),
                  //       ),
                  //     ),
                  //     Card(
                  //       elevation: 3,
                  //       child: ListTile(
                  //         leading: CircleAvatar(
                  //           backgroundColor: Colors.blue,
                  //           child: Icon(Icons.person, color: Colors.white),
                  //         ),
                  //         title: Text(
                  //           'أحمد محمد',
                  //           textAlign: TextAlign.right,
                  //         ),
                  //         subtitle: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.end,
                  //           children: [
                  //             Text(
                  //               'مترجم',
                  //               textAlign: TextAlign.right,
                  //             ),
                  //             Text(
                  //               'المملكة العربية السعودية',
                  //               textAlign: TextAlign.right,
                  //             ),
                  //             Text(
                  //               'طبيب عام مع خبرة 10 سنوات في مجال الطب العام والطوارئ.',
                  //               maxLines: 2,
                  //               overflow: TextOverflow.ellipsis,
                  //               textAlign: TextAlign.right,
                  //             ),
                  //           ],
                  //         ),
                  //         trailing: ElevatedButton(
                  //           style: const ButtonStyle(backgroundColor:WidgetStatePropertyAll(Colors.red)  ),
                  //           onPressed: () {},
                  //           child: Text('متصل',style: TextStyle(color: Colors.white),),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ),

                SingleChildScrollView(
                  child:Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // User avatar
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.blue,
                                child: Text(
                                  "أ",
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              // User details
                              Column(
                                children: [
                                  Text(
                                    "أحمد",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                  Text(
                                    "متصل الآن",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.green,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                              Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide.none
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 8),
                                      Text(
                                        "المهنة: 'طبيب",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                      Text(
                                        "المدينة: الرياض",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                      Text(
                                        "نبذة: مطور تطبيقات ويب بخبرة 5 سنوات",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),                  // ProductsScreen(type: "hot",query: query,),
                ),

                SingleChildScrollView(
                  child:Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // User avatar
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.blue,
                                child: Text(
                                  "س",
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              // User details
                              Column(
                                children: [
                                  Text(
                                    "سارة",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                  Text(
                                    "غير متصل",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                              Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide.none
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 8),
                                      Text(
                                        "المهنة: مهندسة",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                      Text(
                                        "المدينة: الرياض",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                      Text(
                                        "نبذة: مطور تطبيقات ويب بخبرة 5 سنوات",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),                  // ProductsScreen(type: "hot",query: query,),
                ),
                SingleChildScrollView(
                  child:Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // User avatar
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.blue,
                                child: Text(
                                  "م",
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              // User details
                              Column(
                                children: [
                                  Text(
                                    "محمد",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                  Text(
                                    "غير متصل",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                              Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide.none
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 8),
                                      Text(
                                        "المهنة: مدرس",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                      Text(
                                        "المدينة: الرياض",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                      Text(
                                        "نبذة: مطور تطبيقات ويب بخبرة 5 سنوات",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),                  // ProductsScreen(type: "hot",query: query,),

                ),
                SingleChildScrollView(
                  child:Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // User avatar
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.blue,
                                child: Text(
                                  "أ",
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              // User details
                              Column(
                                children: [
                                  Text(
                                    "أحمد",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                  Text(
                                    "متصل الآن",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.green,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                              Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide.none
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 8),
                                      Text(
                                        "المهنة: مترجم",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                      Text(
                                        "المدينة: الرياض",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                      Text(
                                        "نبذة: مطور تطبيقات ويب بخبرة 5 سنوات",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  // ProductsScreen(type: "hot",query: query,),

                  // child: Card(
                  //   elevation: 3,
                  //   child: ListTile(
                  //     leading: CircleAvatar(
                  //       backgroundColor: Colors.blue,
                  //       child: Icon(Icons.person, color: Colors.white),
                  //     ),
                  //     title: Text(
                  //       'أحمد محمد',
                  //       textAlign: TextAlign.right,
                  //     ),
                  //     subtitle: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.end,
                  //       children: [
                  //         Text(
                  //           'مترجم',
                  //           textAlign: TextAlign.right,
                  //         ),
                  //         Text(
                  //           'المملكة العربية السعودية',
                  //           textAlign: TextAlign.right,
                  //         ),
                  //         Text(
                  //           'طبيب عام مع خبرة 10 سنوات في مجال الطب العام والطوارئ.',
                  //           maxLines: 2,
                  //           overflow: TextOverflow.ellipsis,
                  //           textAlign: TextAlign.right,
                  //         ),
                  //       ],
                  //     ),
                  //     trailing: ElevatedButton(
                  //       style: const ButtonStyle(backgroundColor:WidgetStatePropertyAll(Colors.red)  ),
                  //       onPressed: () {},
                  //       child: Text('متصل',style: TextStyle(color: Colors.white),),
                  //     ),
                  //   ),
                  // ),
                  // ProductsScreen(type: "hot",query: query,),
                ),


              ]),
            ),





            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title,NavigatorPag) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        textAlign: TextAlign.right,
      ),
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NavigatorPag),
        );
      },
    );
  }

// Helper function to create tabs with custom styling
  Widget _buildTab({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey[300], // Green for selected, gray for unselected
          borderRadius: BorderRadius.circular(25), // Rounded corners
        ),
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black, // White for selected, black for unselected
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }


}