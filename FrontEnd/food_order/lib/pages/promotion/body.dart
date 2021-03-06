import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/bloc/Cart/CartBloc.dart';
import 'package:food_delivery/bloc/Cart/CartEvent.dart';
import 'package:food_delivery/bloc/Promotions/PromotionBloc.dart';
import 'package:food_delivery/bloc/Promotions/PromotionState.dart';
import 'package:food_delivery/configs/AppConfigs.dart';
import 'package:food_delivery/pages/home/AppLoadingScreen.dart';
import 'package:food_delivery/pages/presentation/Themes.dart';
import 'package:food_delivery/view_models/Promotions/PromotionVM.dart';

const List<Key> keys = [Key('Network')];

class Body extends StatelessWidget {
  Widget _buildLoadedState(BuildContext context, PromotionLoadedState state) {
    return SafeArea(
      child: ListView.builder(
        itemCount: state.listPromotionVMs.length,
        itemBuilder: (context, index) {
          // return (totalPreis != null &&
          //         (totalPreis < state.listPromotionVMs[index].minPrice! ||
          //             totalPreis == 0))
          //     ? DisableItemPromotion(state.listPromotionVMs[index], totalPreis)
          //     : UseableItemPromotion(state.listPromotionVMs[index], totalPreis);
          return PromotionItem(state.listPromotionVMs[index]);
        },
      ),
    );
  }

  Widget _buildErrorState(PromotionErrorState state) {
    return Container(
        child: Center(
      child: Text(
        state.error,
      ),
    ));
  }

  Widget _buildLoadingState() {
    return AppLoadingScreen();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PromotionBloc, PromotionState>(
      builder: (context, state) {
        if (state is PromotionLoadingState) {
          return _buildLoadingState();
        }
        if (state is PromotionLoadedState) {
          return _buildLoadedState(context, state);
        }
        if (state is PromotionErrorState) {
          return _buildErrorState(state);
        }
        throw "Unknow state";
      },
    );
  }
}

class PromotionItem extends StatelessWidget {
  final PromotionVM _promotionVM;

  PromotionItem(this._promotionVM);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 5),
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.grey),
            child: Row(children: [
              FlatButton(
                key: keys[0],
                padding: EdgeInsets.all(0),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => promotionDetail(_promotionVM));
                },
                child: SizedBox(
                  height: 100,
                  width: 90,
                  child: DecoratedBox(
                    child: Icon(
                      Icons.confirmation_num_outlined,
                      color: Colors.white,
                      size: 40,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
                        border: Border(
                            left: BorderSide(
                                width: 2,
                                color: Colors.red,
                                style: BorderStyle.solid))),
                  ),
                ),
              ),
              Expanded(
                child: FlatButton(
                  padding: EdgeInsets.only(left: 5, top: 5, bottom: 5),
                  height: 100,
                  onPressed: () {
                    context
                        .read<CartBloc>()
                        .add(CartAddPromotionEvent(_promotionVM.id));
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text("???? ??p d???ng m?? khuy???n m??i v??o gi??? h??ng")));
                    Navigator.of(context).pop();
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            _promotionVM.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Text(
                              "CODE: ",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Center(
                              child: Text(_promotionVM.code,
                                  style: Theme.of(context).textTheme.bodyText1),
                            ),
                          ],
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Text(
                              "HSD: ",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              AppConfigs.AppDateFormat.format(
                                  _promotionVM.endDate),
                              style: TextStyle(color: Colors.redAccent),
                            ),
                          ],
                        ),
                        alignment: Alignment.centerLeft,
                      )
                    ],
                  ),
                  color: Colors.white,
                ),
              ),
            ])),
      ),
    );
  }
}

Dialog promotionDetail(PromotionVM _promotionVM) {
  return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            //height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.white),
            padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(_promotionVM.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
              SizedBox(height: 20),
              Text(_promotionVM.desciption.toString(),
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
              Text("\n??i???u ki???n:",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700)),
              SizedBox(height: 3),
              Text(
                  "Th???i gian: ${AppConfigs.AppDateFormat.format(_promotionVM.startDate)} -> ${AppConfigs.AppDateFormat.format(_promotionVM.endDate)}",
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
              SizedBox(height: 3),
              Text(
                  "??p d???ng cho ????n h??ng t???: ${AppConfigs.toPrice(_promotionVM.minPrice!)}",
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
              SizedBox(height: 3),
              Text("T???i ??a: ${AppConfigs.toPrice(_promotionVM.max!)}",
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
              SizedBox(height: 3),
              Row(
                children: [
                  Text("S??? l???n s??? d???ng: ${_promotionVM.useTimes}",
                      style:
                          TextStyle(fontSize: 14, color: Colors.grey.shade700)),
                  Text(
                      " (???? s??? d???ng ${_promotionVM.timeUsedByCurrentUser} l???n)",
                      style: TextStyle(fontSize: 14, color: Colors.red)),
                ],
              ),
            ]),
          ),
        ],
      ));
}
