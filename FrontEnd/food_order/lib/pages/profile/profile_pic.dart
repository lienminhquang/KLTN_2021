import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 115,
      height: 115,
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('images/item.png'),
          ),
          Positioned(
              bottom: 0,
              right: -12,
              child: SizedBox(
                height: 46,
                width: 46,
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
                      size: 30,
                    )),
              ))
        ],
      ),
    );
  }
}
