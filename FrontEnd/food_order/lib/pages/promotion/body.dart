import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/bloc/Cart/CartBloc.dart';
import 'package:food_delivery/bloc/Cart/CartEvent.dart';
import 'package:food_delivery/bloc/Promotions/PromotionBloc.dart';
import 'package:food_delivery/bloc/Promotions/PromotionState.dart';
import 'package:food_delivery/configs/AppConfigs.dart';
import 'package:food_delivery/view_models/Promotions/PromotionVM.dart';

const List<Key> keys = [Key('Network')];

class Body extends StatelessWidget {
  double? totalPreis;
  Body(this.totalPreis);

  Widget _buildLoadedState(
      BuildContext context, PromotionLoadedState state, double? totalPreis) {
    return SafeArea(
      child: ListView.builder(
        itemCount: state.listPromotionVMs.length,
        itemBuilder: (context, index) {
          return (totalPreis == 0 ||
                  totalPreis! < state.listPromotionVMs[index].minPrice! ||
                  totalPreis == null)
              ? DisableItemPromotion(state.listPromotionVMs[index], totalPreis)
              : UseableItemPromotion(state.listPromotionVMs[index], totalPreis);
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
    return Container(child: Center(child: CircularProgressIndicator()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PromotionBloc, PromotionState>(
      builder: (context, state) {
        if (state is PromotionLoadingState) {
          return _buildLoadingState();
        }
        if (state is PromotionLoadedState) {
          return _buildLoadedState(context, state, totalPreis);
        }
        if (state is PromotionErrorState) {
          return _buildErrorState(state);
        }
        throw "Unknow state";
      },
    );
  }
}

class UseableItemPromotion extends StatelessWidget {
  final PromotionVM _promotionVM;
  final double? totalPreis;
  UseableItemPromotion(this._promotionVM, this.totalPreis);
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
                    builder: (context) => Dialog(
                        backgroundColor: Colors.transparent,
                        insetPadding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white),
                              padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
                              child: Column(children: [
                                Text(_promotionVM.name,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center),
                                SizedBox(height: 20),
                                Text(_promotionVM.desciption.toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade700)),
                                Text(
                                    "Áp dụng cho đơn hàng từ: ${AppConfigs.toPrice(_promotionVM.minPrice!)}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade700)),
                                Text(
                                    "Tối đa: ${AppConfigs.toPrice(_promotionVM.max!)}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade700)),
                              ]),
                            ),
                          ],
                        )),
                  );
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
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey.shade700),
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
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                            Center(
                              child: Text(
                                _promotionVM.code,
                                style: TextStyle(
                                  fontSize: 12,
                                  //fontWeight: FontWeight.w300,
                                  color: Colors.grey,
                                ),
                              ),
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

class DisableItemPromotion extends StatelessWidget {
  final PromotionVM _promotionVM;
  final double? totalPreis;
  DisableItemPromotion(this._promotionVM, this.totalPreis);
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
                    builder: (context) => Dialog(
                        backgroundColor: Colors.transparent,
                        insetPadding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: double.infinity,
                              //height: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white),
                              padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
                              child: Column(children: [
                                Text(_promotionVM.name,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center),
                                SizedBox(height: 20),
                                Text(_promotionVM.desciption.toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade700)),
                                Text(
                                    "Áp dụng cho đơn hàng từ: ${AppConfigs.toPrice(_promotionVM.minPrice!)}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade700)),
                                Text(
                                    "Tối đa: ${AppConfigs.toPrice(_promotionVM.max!)}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade700)),
                              ]),
                            ),
                          ],
                        )),
                  );
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
                        color: Colors.grey,
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
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Không thể áp dụng mã khuyến mãi!"),
                            content: Text(
                                "Đơn hàng của bạn không đủ điều kiện để sử dụng mã khuyến mãi này. Vui lòng kiểm ra lại!"),
                          );
                        });
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
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey.shade700),
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
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                            Center(
                              child: Text(
                                _promotionVM.code,
                                style: TextStyle(
                                  fontSize: 12,
                                  //fontWeight: FontWeight.w300,
                                  color: Colors.grey,
                                ),
                              ),
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
