import 'package:flutter/material.dart';
import 'package:recho/routs/CallLogScreen.dart';
import 'package:recho/routs/MyProfile.dart';
import 'package:recho/routs/Splashscreen.dart';
import 'package:recho/routs/WalletScreen.dart';
import 'dart:async';

import 'package:recho/widgets/Header_With_Gradient.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  @override
  void initState() {
    super.initState();
    _startTimer();
  }
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % sentences.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Directionality( // Explicitly set text direction to RTL
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          // title: Text(
          //   'Recho ',
          //   style: TextStyle(color: Colors.white),
          // ),
          // centerTitle: true,
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              // Container(
              //   color: Colors.blue,
              //   width: double.infinity,
              //   padding: EdgeInsets.all(20),
              //   child: Text(
              //     'مشتركين محترفين',
              //     textAlign: TextAlign.center,
              //     style: TextStyle(color: Colors.white, fontSize: 24),
              //   ),
              // ),
              const SizedBox(height: 10),
              HeaderWithGradient(
                text: sentences[currentIndex],
                gradientColors: gradients[currentIndex],
              ),
              const SizedBox(height: 30),
              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: 'ابحث عن مشتركك...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Categories
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Wrap(
                  spacing: 10,
                  children: [
                    _buildChip('الكل', Colors.blue),
                    _buildChip('طبيب', Colors.grey),
                    _buildChip('مهندس', Colors.grey),
                    _buildChip('مدرس', Colors.grey),
                    _buildChip('مترجم', Colors.grey),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Profile Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: Column(
                  children: [
                    Card(
                      elevation: 3,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                        title: Text(
                          'أحمد محمد',
                          textAlign: TextAlign.right,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'طبيب عام',
                              textAlign: TextAlign.right,
                            ),
                            Text(
                              'المملكة العربية السعودية',
                              textAlign: TextAlign.right,
                            ),
                            Text(
                              'طبيب عام مع خبرة 10 سنوات في مجال الطب العام والطوارئ.',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                        trailing: ElevatedButton(
                          style: const ButtonStyle(backgroundColor:WidgetStatePropertyAll(Colors.red)  ),
                          onPressed: () {},
                          child: Text('متصل',style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 3,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                        title: Text(
                          'أحمد محمد',
                          textAlign: TextAlign.right,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'طبيب عام',
                              textAlign: TextAlign.right,
                            ),
                            Text(
                              'المملكة العربية السعودية',
                              textAlign: TextAlign.right,
                            ),
                            Text(
                              'طبيب عام مع خبرة 10 سنوات في مجال الطب العام والطوارئ.',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                        trailing: ElevatedButton(
                          style: const ButtonStyle(backgroundColor:WidgetStatePropertyAll(Colors.grey)  ),
                          onPressed: () {},
                          child: Text('غير متصل',style: TextStyle(color: Colors.white),),
                      ),
                      ),
                    ),
                    Card(
                      elevation: 3,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                        title: Text(
                          'أحمد محمد',
                          textAlign: TextAlign.right,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'طبيب عام',
                              textAlign: TextAlign.right,
                            ),
                            Text(
                              'المملكة العربية السعودية',
                              textAlign: TextAlign.right,
                            ),
                            Text(
                              'طبيب عام مع خبرة 10 سنوات في مجال الطب العام والطوارئ.',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                        trailing: ElevatedButton(
                          style: const ButtonStyle(backgroundColor:WidgetStatePropertyAll(Colors.red)  ),
                          onPressed: () {},
                          child: Text('متصل',style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ),

                  ],
                ),

              ),
            ],
          ),
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

  Widget _buildChip(String label, Color color) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: color,
      side: BorderSide(style: BorderStyle.none ),
    );
  }
}