import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.purple),
              height: 500,
              child: CachedNetworkImage(
                  imageUrl:
                      'https://assignmentbuddy.in/wp-content/uploads/2024/02/casual-life-3d-lamp-books-and-objects-for-studying.png',
                  height: 200),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Learning is Everything',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Learning with Pleasure with Dear Programmer, Wherever you are.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 50),
                      SizedBox(
                        width: 300,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SecondScreen()),
                            );
                          },
                          child: Text('Get Start',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.purple),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 50, right: 16, left: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.dashboard,
                        color: Colors.white,
                      ),
                      Icon(
                        Icons.notifications,
                        color: Colors.white,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Hi, Porgrammer",
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search here...',
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(height: 20),
          ),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            children: [
              _buildCategoryItem(Icons.category, 'Category'),
              _buildCategoryItem(Icons.play_circle_fill, 'Classes'),
              _buildCategoryItem(Icons.book, 'Free Course'),
              _buildCategoryItem(Icons.store, 'BookStore'),
              _buildCategoryItem(Icons.live_tv, 'Live Course'),
              _buildCategoryItem(Icons.leaderboard, 'LeaderBoard'),
            ],
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text('Courses',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: [
                  _buildCourseCard(
                      context,
                      'Flutter',
                      'https://img.icons8.com/color/512/flutter.png',
                      ThirdScreen()),
                  _buildCourseCard(
                      context,
                      'React Native',
                      'https://cdn4.iconfinder.com/data/icons/logos-3/600/React.js_logo-512.png',
                      ThirdScreen()),
                  _buildCourseCard(
                      context,
                      'Python',
                      'https://brandslogos.com/wp-content/uploads/images/large/python-logo.png',
                      ThirdScreen()),
                  _buildCourseCard(
                      context,
                      'Dart',
                      'https://upload.wikimedia.org/wikipedia/commons/c/c6/Dart_logo.png',
                      ThirdScreen()),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.video_library), label: 'Courses'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Wishlist'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.purple.withValues(alpha: .2),
          child: Icon(icon, color: Colors.purple, size: 30),
        ),
        SizedBox(height: 5),
        Text(label, style: TextStyle(fontSize: 15)),
      ],
    );
  }

  Widget _buildCourseCard(
      BuildContext context, String title, String imageUrl, Widget screen) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (ctx) => ThirdScreen()));
      },
      child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              SizedBox(
                height: 12,
              ),
              CachedNetworkImage(
                imageUrl: imageUrl,
                width: 120,
              ),
              Text("Flutter"),
              Text("15 Videos")
            ],
          )),
    );
  }
}

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Complete Course')),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Card(
            child: CachedNetworkImage(
              imageUrl: 'https://img.icons8.com/color/512/flutter.png',
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            "Flutter Complete Course",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          Text(
            "Created by Kimun",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          Text("15 Videos"),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Colors.blue.shade600),
                child: Text(
                  "Videos",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                width: 150,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Colors.blue.shade600),
                child: Text(
                  "Description",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          ListTile(
            leading: Icon(
              Icons.play_circle_fill,
              color: Colors.purple,
              size: 50,
            ),
            title: Text('Introduction to Flutter'),
            subtitle: Text('20 min 50 sec'),
          ),
          ListTile(
            leading: Icon(
              Icons.play_circle_fill,
              color: Colors.purple,
              size: 50,
            ),
            title: Text('Installing Flutter on Windows'),
            subtitle: Text('20 min 50 sec'),
          ),
          ListTile(
            leading: Icon(
              Icons.play_circle_fill,
              color: Colors.purple,
              size: 50,
            ),
            title: Text('Setup Emulator on Windows'),
            subtitle: Text('20 min 50 sec'),
          ),
          ListTile(
            leading: Icon(
              Icons.play_circle_fill,
              color: Colors.purple,
              size: 50,
            ),
            title: Text('Creating Our First App'),
            subtitle: Text('20 min 50 sec'),
          ),
        ],
      ),
    );
  }
}
