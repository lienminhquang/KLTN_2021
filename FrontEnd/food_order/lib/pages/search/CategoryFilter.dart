import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/pages/presentation/Themes.dart';
import 'package:food_delivery/view_models/Categories/CategoryVM.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryFilter extends StatefulWidget {
  const CategoryFilter({Key? key, required this.categoryVMs, required this.cid})
      : super(key: key);
  final List<CategoryVM> categoryVMs;
  final List<int>? cid;

  @override
  _SortCategoryFilter createState() => _SortCategoryFilter();
}

class _SortCategoryFilter extends State<CategoryFilter> {
  //List<CategoryVM> categoryVMs = [CategoryVM(), CategoryVM(), CategoryVM()];
  List<int> cid = [];

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }

  @override
  void initState() {
    if (widget.cid != null) {
      cid = widget.cid!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var listOptionWidget = List.generate(widget.categoryVMs.length, (index) {
      return Row(
        children: [
          Checkbox(
            checkColor: Colors.white,
            fillColor: MaterialStateProperty.resolveWith(getColor),
            value: cid.contains(widget.categoryVMs[index].id),
            onChanged: (bool? value) {
              setState(() {
                var id = widget.categoryVMs[index].id;
                if (cid.contains(id)) {
                  cid.remove(id);
                } else {
                  cid.add(id!);
                }
              });
            },
          ),
          Text(widget.categoryVMs[index].name!)
        ],
      );
    });

    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
        child: Column(
          children: [
            Column(mainAxisSize: MainAxisSize.min, children: listOptionWidget),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 40,
                  width: 150,
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(cid);
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
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Lọc kết quả",
          //style: GoogleFonts.getFont('Lato'),
        ),
        backgroundColor: AppTheme.appBarBackground,
      ),
    );
  }
}
