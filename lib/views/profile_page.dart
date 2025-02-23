import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_tutoial/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(context,listen: false);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
            top: 90,
          ),
          child: Consumer<UserProvider>(
            builder: (context,userProvider,_) {
              return userProvider.isLoading ? Center(child: CircularProgressIndicator(),): Column(
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Profile",
                        style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(
                                image:
                                    CachedNetworkImageProvider(userProvider.user.avatar ?? ''))),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 10,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Color(0xffFF9C6E),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white, width: 3)),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                  userProvider.user.name ?? 'No Name provided',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(userProvider.user.email ?? 'No Email provided',
                      style: TextStyle(fontSize: 18, color: Colors.grey)),
                  Expanded(
                      child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (ctx, index) {
                          return ListTile(
                            leading: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.orange.withValues(alpha: .2)),
                                child:
                                    Icon(Icons.settings, color: Color(0xffFF9C6E))),
                            title: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "Settings",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500),
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xffFF9C6E),
                            ),
                          );
                        }),
                  ))
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}

