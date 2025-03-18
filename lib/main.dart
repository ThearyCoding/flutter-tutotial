import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: YoutubeClonePage(),
    ));

class YoutubeClonePage extends StatefulWidget {
  const YoutubeClonePage({super.key});

  @override
  State<YoutubeClonePage> createState() => _YoutubeClonePageState();
}

class _YoutubeClonePageState extends State<YoutubeClonePage> {
  final List<String> headers = ["All", "Flutter", "Source Code", "Composer"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff131114),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            backgroundColor: Color(0xff131114),
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(50),
                child: SizedBox(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Chip(label: Text(headers[index]));
                        },
                        separatorBuilder: (context, index) => SizedBox(
                              width: 10,
                            ),
                        itemCount: headers.length),
                  ),
                )),
            actions: [
              Icon(
                Icons.tv,
                size: 26,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.notifications,
                color: Colors.white,
                size: 26,
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.search,
                color: Colors.white,
                size: 26,
              ),
              SizedBox(
                width: 10,
              ),
            ],
            title: Row(
              children: [
                Image.network(
                    width: 50,
                    height: 50,
                    "https://static.vecteezy.com/system/resources/previews/023/986/704/non_2x/youtube-logo-youtube-logo-transparent-youtube-icon-transparent-free-free-png.png"),
                Text(
                  "YOUTUBE",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                )
              ],
            ),
          ),

          SliverList(delegate: SliverChildBuilderDelegate(
            childCount: 10,
            (context,index){
            return Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.amber
              ),
            );
          }))
        ],
      ),
    );
  }
}
