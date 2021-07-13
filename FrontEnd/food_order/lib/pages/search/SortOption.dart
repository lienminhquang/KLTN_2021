import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/pages/presentation/Themes.dart';

enum SortFactor { Name, Favorite }

class SortOption extends StatefulWidget {
  const SortOption({Key? key, this.sortFactor}) : super(key: key);
  final SortFactor? sortFactor;
  @override
  _SortOptionState createState() => _SortOptionState(this.sortFactor);
}

class _SortOptionState extends State<SortOption> {
  _SortOptionState(SortFactor? sortFactor) {
    _sortFactor = sortFactor;
  }
  SortFactor? _sortFactor = SortFactor.Name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          RadioListTile<SortFactor>(
            title: const Text("Tên"),
            groupValue: _sortFactor,
            onChanged: (SortFactor? value) {
              setState(() {
                _sortFactor = value;
              });
            },
            value: SortFactor.Name,
          ),
          RadioListTile<SortFactor>(
              title: const Text("Yêu thích"),
              groupValue: _sortFactor,
              onChanged: (SortFactor? value) {
                setState(() {
                  _sortFactor = value;
                });
              },
              value: SortFactor.Favorite),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 40,
                width: 150,
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(_sortFactor);
                    },
                    child: Text("Áp dụng")),
              ),
              Container(
                  height: 40,
                  width: 150,
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Hủy")))
            ],
          )
        ]),
      ),
      appBar: AppBar(
        title: const Text("Sắp xếp theo"),
        backgroundColor: AppTheme.appBarBackground,
      ),
    );
  }
}
