import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: SizedBox(
        width: 115,
        height: 115,
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('images/item.png'),
            ),
            Positioned(
                bottom: 20,
                right: -8,
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: FlatButton(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: BorderSide(color: Colors.white)),
                      color: Colors.grey.shade200,
                      onPressed: () {},
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey,
                        size: 20,
                      )),
                ))
          ],
        ),
      ),
    );
  }
}
