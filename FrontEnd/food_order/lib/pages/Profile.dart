import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Me"),
        ),
        body: Container(
          color: Colors.grey,
          child: ListView(
            children: [
              Container(
                color: Colors.grey[200],
                child: SizedBox(
                  height: 200,
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      CircleAvatar(
                          //minRadius: 50,
                          backgroundColor: Colors.white70,
                          radius: 60.0,
                          child: CircleAvatar(
                              radius: 50.0,
                              backgroundImage:
                                  AssetImage("images/ladybug.jpg"))),
                      SizedBox(height: 20),
                      Text(
                        "Minh Quang",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                color: Colors.white,
                margin: const EdgeInsets.fromLTRB(0, 2, 0, 2),
                child: ListTile(
                  leading: Icon(Icons.local_offer_outlined),
                  title: Text("Promotions"),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: (){
                    
                  },
                ),
              ),
              Container(
                color: Colors.white,
                child: ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text("Addresses"),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
              SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 2, 0, 2),
                color: Colors.white,
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text("Settings"),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
              Container(
                color: Colors.white,
                child: ListTile(
                  leading: Icon(Icons.announcement),
                  title: Text("About us"),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
              SizedBox(height: 20),
              Container(
                //color: Colors.white,
                child: OutlinedButton(
                    onPressed: () {},
                    child: Text(
                      "Sign out",
                      style: TextStyle(color: Colors.red),
                    ),
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                            side: BorderSide(width: 2, color: Colors.red)))),
              ),
            ],
          ),
        ));
  }
}
