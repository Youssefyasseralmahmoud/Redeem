import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';

import 'package:redeem/core/function/notification_state_controller.dart';
import 'package:redeem/core/function/validationinput.dart';
import 'package:redeem/custom_widget/CustomAppBar.dart';
import 'package:redeem/custom_widget/custom_back_button.dart';
import 'package:redeem/custom_widget/custom_drawer.dart';
import 'package:redeem/custom_widget/custom_preloader.dart';
import 'package:redeem/custom_widget/custom_text_form_field.dart';
import 'package:redeem/events.dart';
import 'package:redeem/generated/l10n.dart';
import 'package:redeem/json_db/enum.dart';
import 'package:redeem/json_db/json_db.dart';
import 'package:redeem/json_db/utils.dart';
import 'package:redeem/screens/buy_points/buy_points.dart';
import 'package:redeem/screens/cart_screen/cart_screen_controller.dart';
import 'package:redeem/screens/cart_screen/webview_redeem.dart';
import 'package:redeem/screens/home_screen/home_screen.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/theme/custom_theme.dart';
import 'package:redeem/globals.dart' as globals;
import 'package:svg_flutter/svg_flutter.dart';

class CartScreen extends StatefulWidget {
  String? quickCheckout = "0";
  String? ItemType = "";
  int? id;
  CartScreen(
      {super.key, this.quickCheckout = "0", this.ItemType = "", this.id});

  @override
  State<CartScreen> createState() => _CartScreen();
}

class _CartScreen extends State<CartScreen> {
  String itemType = "Coupon";
  String returnCart = "true";
  String quick_checkout = "0";
  String forCheckOut = "true";
  bool isSelected = false;
  TextEditingController phoneController = TextEditingController();
  CartData? cartData;
  List<City> cities = [];
  // CartData? cartDataAddCart;
  bool loading = true;
  List<S2Choice<String>> Language2 = [
    S2Choice<String>(value: 'en', title: 'English'),
    S2Choice<String>(value: 'ar', title: 'Arabic'),
    S2Choice<String>(value: 'tur', title: 'turki'),
  ];
  List<S2Choice<String>> citys = [
    S2Choice<String>(value: 'd', title: 'Dubai'),
    S2Choice<String>(value: 'r', title: 'Riyad'),
    S2Choice<String>(value: 'j', title: 'Jadah'),
  ];
  bool is_switched = false;

  change_switch_case(bool val) {
    is_switched = val;
    // showPreLoader();
    // await new Timer(2.seconds, () {
    //   dismissPreLoader();
    // });
    setState(() {});
  }

  bool is_selected = false;

  void setSelected(bool selected) {
    is_selected = selected;

    setState(() {});
  }

  String? selectpayment = "";
  int counter = 1;
  void addToCart() async {
    debugPrint("in add to cart");
    // try {
    //  showPreLoader(context);
    await JsonDb()
        .addTocartCollections(widget.quickCheckout!, widget.id!, 1,
            widget.ItemType!, returnCart, forCheckOut)
        .then((res) {
      if (res.success) {
        print("in_add_succes");
        globals.countcart = res.data.countCart!;
        eventBus.fire(
          AppEvents(
            key_event: "change_cart_count",
          ),
        );
        // dismissPreLoader(context);
        cartData = res.data;

        loading = false;

        setState(() {});

        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          CustomTheme.CustomSnackBar(res.message, "success"),
        );
      } else {
        // dismissPreLoader(context);
        if (res.has_errors) {
          ScaffoldMessenger.of(context as BuildContext).showSnackBar(
            CustomTheme.CustomSnackBar(res.errors[0], "error"),
          );
        } else {
          ScaffoldMessenger.of(context as BuildContext).showSnackBar(
            CustomTheme.CustomSnackBar(res.message, "error"),
          );
        }
      }
    });
    // } catch (e) {
    //dismissPreLoader(context);
    //   ScaffoldMessenger.of(context as BuildContext).showSnackBar(
    //     CustomTheme.CustomSnackBar(
    //         S.of(context).Internet_connection_error, "warning"),
    //   );
    // }
  }

  void getcities() async {
    try {
      await JsonDb().getCityCollections().then((res) {
        if (res.success) {
          cities = res.data;
        } else {
          if (res.has_errors) {
            ScaffoldMessenger.of(context as BuildContext).showSnackBar(
              CustomTheme.CustomSnackBar(res.errors[0], "error"),
            );
          } else {
            ScaffoldMessenger.of(context as BuildContext).showSnackBar(
              CustomTheme.CustomSnackBar(res.message, "error"),
            );
          }
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        CustomTheme.CustomSnackBar(
            S.of(context).Internet_connection_error, "warning"),
      );
    }
  }

  void getData() async {
    // try {
    await JsonDb()
        .getCartDataCollections(widget.quickCheckout!, forCheckOut)
        .then((res) {
      if (res.success) {
        cartData = res.data;

        loading = false;

        setState(() {});
      } else {
        if (res.has_errors) {
          ScaffoldMessenger.of(context as BuildContext).showSnackBar(
            CustomTheme.CustomSnackBar(res.errors[0], "error"),
          );
        } else {
          ScaffoldMessenger.of(context as BuildContext).showSnackBar(
            CustomTheme.CustomSnackBar(res.message, "error"),
          );
        }
      }
    });
    // } catch (e) {
    //   ScaffoldMessenger.of(context as BuildContext).showSnackBar(
    //     CustomTheme.CustomSnackBar(
    //         S.of(context).Internet_connection_error, "warning"),
    //   );
    // }
  }

  void submitOrder() async {
    // try {
    // print("paymentLength ${cartData!.cart!.listPaymentMethod!.length}");
    await JsonDb()
        .submitOrderCollections(
            cartData!.cart!.total!, selectpayment!, phoneController.toString())
        .then((res) {
      if (res.success) {
        loading = false;
        if (res.redirect_link != "") {
          openWebView(res.redirect_link);
        } else {
          /*  ScaffoldMessenger.of(context as BuildContext).showSnackBar(
            CustomTheme.CustomSnackBar(res.message, "success"),
          ); */
          showSuccess(context: context, message: res.message);
        }

        setState(() {});
      } else {
        if (res.has_errors) {
          /*  ScaffoldMessenger.of(context as BuildContext).showSnackBar(
            CustomTheme.CustomSnackBar(res.errors[0], "error"),
          ); */
          showDanger(context: context, message: res.errors[0]);
        } else {
          /*   ScaffoldMessenger.of(context as BuildContext).showSnackBar(
            CustomTheme.CustomSnackBar(res.message, "error"),
          ); */
          showDanger(context: context, message: res.message);
        }
      }
    });
    // } catch (e) {
    //   ScaffoldMessenger.of(context as BuildContext).showSnackBar(
    //     CustomTheme.CustomSnackBar(
    //         S.of(context).Internet_connection_error, "warning"),
    //   );
    // }
  }

  Future<void> openWebView(String url) async {
    var res = await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => WebViewRedeem(url),
      ),
    );
    if (res != null) {
      if (res['back_message_style'] == 'danger') {
        showRepayment(
            context: context,
            onConfirmPressed: () {
              Navigator.of(context).pop();
              openWebView(url);
            },
            onFailedPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            });
      } else {
        showSuccess(context: context, message: res['back_message_style']);
      }

      /*  ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        CustomTheme.CustomSnackBar(
            res['back_message'], res['back_message_style']),
      ); */
    }
  }

  void submitOrderQuickCkeck() async {
    // try {
    // print("paymentLength ${cartData!.cart!.listPaymentMethod!.length}");
    await JsonDb()
        .submitOrderQuickCheckoutCollections(
            widget.id!,
            1,
            widget.ItemType!,
            widget.quickCheckout!,
            cartData!.cart!.total!,
            selectpayment!,
            phoneController.toString())
        .then((res) {
      if (res.success) {
        loading = false;

        if (res.redirect_link != "") {
          openWebView(res.redirect_link);
        } else {
          /* ScaffoldMessenger.of(context as BuildContext).showSnackBar(
            CustomTheme.CustomSnackBar(res.message, "success"),
          ); */
          showSuccess(context: context, message: res.message);
        }

        setState(() {});
      } else {
        if (res.has_errors) {
          /*  ScaffoldMessenger.of(context as BuildContext).showSnackBar(
            CustomTheme.CustomSnackBar(res.errors[0], "error"),
          ); */
          showDanger(context: context, message: res.errors[0]);
        } else {
          /*   ScaffoldMessenger.of(context as BuildContext).showSnackBar(
            CustomTheme.CustomSnackBar(res.message, "error"),
          ); */
          showDanger(context: context, message: res.message);
        }
      }
    });
    // } catch (e) {
    //   ScaffoldMessenger.of(context as BuildContext).showSnackBar(
    //     CustomTheme.CustomSnackBar(
    //         S.of(context).Internet_connection_error, "warning"),
    //   );
    // }
  }

  void changeQty(int itemId, int qty) async {
    // try {
    // showPreLoader(context);
    await JsonDb()
        .addTocartCollections(
            quick_checkout, itemId, qty, itemType, returnCart, forCheckOut)
        .then((res) {
      if (res.success) {
        // dismissPreLoader(context);
        globals.countcart = res.data.countCart!;
        eventBus.fire(
          AppEvents(
            key_event: "change_cart_count",
          ),
        );
        cartData = res.data;

        loading = false;

        setState(() {});
      } else {
        dismissPreLoader(context);
        if (res.has_errors) {
          ScaffoldMessenger.of(context as BuildContext).showSnackBar(
            CustomTheme.CustomSnackBar(res.errors[0], "error"),
          );
        } else {
          ScaffoldMessenger.of(context as BuildContext).showSnackBar(
            CustomTheme.CustomSnackBar(res.message, "error"),
          );
        }
      }
    });
    // } catch (e) {
    //dismissPreLoader(context);
    //   ScaffoldMessenger.of(context as BuildContext).showSnackBar(
    //     CustomTheme.CustomSnackBar(
    //         S.of(context).Internet_connection_error, "warning"),
    //   );
    // }
  }

  void removeFromCart(int itemId) async {
    // try {
    showPreLoader(context);
    await JsonDb()
        .removeFromcartCollections(
            itemId, itemType, quick_checkout, returnCart, forCheckOut)
        .then((res) {
      if (res.success) {
        dismissPreLoader(context);
        globals.countcart = res.data.countCart!;
        eventBus.fire(
          AppEvents(
            key_event: "change_cart_count",
          ),
        );
        cartData = res.data;

        loading = false;

        setState(() {});
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          CustomTheme.CustomSnackBar(res.message, "success"),
        );
      } else {
        dismissPreLoader(context);
        if (res.has_errors) {
          ScaffoldMessenger.of(context as BuildContext).showSnackBar(
            CustomTheme.CustomSnackBar(res.errors[0], "error"),
          );
        } else {
          ScaffoldMessenger.of(context as BuildContext).showSnackBar(
            CustomTheme.CustomSnackBar(res.message, "error"),
          );
        }
      }
    });
    // } catch (e) {
    //dismissPreLoader(context);
    //   ScaffoldMessenger.of(context as BuildContext).showSnackBar(
    //     CustomTheme.CustomSnackBar(
    //         S.of(context).Internet_connection_error, "warning"),
    //   );
    // }
  }

  @override
  void initState() {
    super.initState();
    getcities();
    widget.quickCheckout == "1" ? addToCart() : getData();
  }

  void increase(int index) {
    cartData!.cart!.listCartItem![index].qty =
        cartData!.cart!.listCartItem![index].qty! + 1;
    setState(() {});
  }

  void decrease(int index) {
    cartData!.cart!.listCartItem![index].qty =
        cartData!.cart!.listCartItem![index].qty! - 1;

    setState(() {});
  }

  void setpayment(String _selectedpayment) {
    // cartData!.cart!.enable_pay_with_points==false? selectpayment=null:
    selectpayment = _selectedpayment;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(choiselangitem: globals.Language2, cities: cities),
      bottomNavigationBar: cartData != null &&
              cartData!.cart!.listCartItem!.isNotEmpty
          ? Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      top: BorderSide(
                          color: CustomColors.thirdcolor.withOpacity(0.2)))),
              child: Padding(
                padding: const EdgeInsetsDirectional.all(8.0),
                child: Container(
                  margin: EdgeInsetsDirectional.symmetric(horizontal: 30),
                  child: ElevatedButton(
                    onPressed: () {
                      widget.quickCheckout == "0"
                          ? submitOrder()
                          : submitOrderQuickCkeck();

                      // showDanger(
                      //     context: context, message: "Success Created order");
                    },
                    child: Text(S.of(context).confirm_order),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        primary: CustomColors.secondarycolor),
                  ),
                ),
              ),
            )
          : null,
      backgroundColor: Colors.grey.shade50,
      appBar: CustomAppBar(
        leading: CustomBackButton(),
        title: Text(
          S.of(context).your_card,
          style: const TextStyle( color: CustomColors.primarycolor),
        ),
        backgroundColor: CustomColors.appbarbackgroundcolor,
        elevation: 0,
      ),
      body: loading == true
          ? const CustomPreloader()
          : SafeArea(
              child: cartData!.cart!.listCartItem!.isNotEmpty
                  ? SingleChildScrollView(
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.symmetric(vertical: 5),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              height:
                                  cartData!.cart!.listCartItem!.length * 150,
                              child: ListView.builder(
                                  itemCount:
                                      cartData!.cart!.listCartItem!.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                        padding: const EdgeInsetsDirectional
                                            .symmetric(horizontal: 14),
                                        child:
                                            cartData!.cart!.listCartItem![index]
                                                        .isCoupon ==
                                                    true
                                                ? Card(
                                                    elevation: 0,
                                                    shape: RoundedRectangleBorder(
                                                        side: BorderSide(
                                                            color: Colors
                                                                .grey.shade200),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .all(5.0),
                                                      child: Row(
                                                        children: [
                                                          // cartData!
                                                          //             .cart!
                                                          //             .listCartItem![index]
                                                          //             .isCoupon ==
                                                          //         true
                                                          //     ?
                                                          Container(
                                                            width: 90,
                                                            height: 90,
                                                            decoration: BoxDecoration(
                                                                image: DecorationImage(
                                                                    image: NetworkImage(
                                                                        "${cartData!.cart!.listCartItem![index].simpleCoupon!.image}"),
                                                                    fit: BoxFit
                                                                        .cover)),
                                                            // child: Image.network(
                                                            //   "${cartData!.cart!.listCartItem![index].simpleCoupon!.image}",
                                                            //   fit: BoxFit.cover,
                                                            // ),
                                                          ),
                                                          // : Container(),
                                                          const SizedBox(
                                                            width: 25,
                                                          ),
                                                          Expanded(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                // cartData!
                                                                //             .cart!
                                                                //             .listCartItem![
                                                                //                 index]
                                                                //             .isCoupon ==
                                                                //         true
                                                                //     ?
                                                                Text(
                                                                    "${cartData!.cart!.listCartItem![index].simpleCoupon!.getPropertyEffectedByLang("name_${globals.SelectedLang}")}"),
                                                                // : Text(
                                                                //     "${cartData!.cart!.listCartItem![index].pointsPackage!.getPropertyEffectedByLang("name_${globals.SelectedLang}")}"),
                                                                const SizedBox(
                                                                  height: 50,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    // cartData!
                                                                    //             .cart!
                                                                    //             .listCartItem![
                                                                    //                 index]
                                                                    //             .isCoupon ==
                                                                    //         true
                                                                    //     ?
                                                                    Text(
                                                                        "${cartData!.cart!.listCartItem![index].simpleCoupon!.price}"),
                                                                    // : Text(
                                                                    //     "${cartData!.cart!.listCartItem![index].pointsPackage!.price}"),
                                                                    Text(
                                                                      " x ${cartData!.cart!.listCartItem![index].qty}",
                                                                    ),
                                                                    Text(
                                                                      " = ${cartData!.cart!.listCartItem![index].total}" +
                                                                          " " +
                                                                          S.of(context).S_R,
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          cartData!.cart!
                                                                      .enable_change_qty ==
                                                                  true
                                                              ? Column(
                                                                  children: [
                                                                    OutlinedButton(
                                                                      onPressed:
                                                                          () {
                                                                        if (cartData!.cart!.listCartItem![index].qty! >
                                                                            1) {
                                                                          decrease(
                                                                              index);
                                                                          changeQty(
                                                                              cartData!.cart!.listCartItem![index].itemId!,
                                                                              cartData!.cart!.listCartItem![index].qty!);
                                                                        } else {
                                                                          cartData!.cart!.enable_remove_item == true
                                                                              //  &&
                                                                              //         cartData!.cart!.listCartItem!.length > 1
                                                                              ? removeFromCart(
                                                                                  cartData!.cart!.listCartItem![index].itemId!,
                                                                                )
                                                                              : debugPrint("cant't remove");
                                                                        }
                                                                      },
                                                                      style: OutlinedButton.styleFrom(
                                                                          side: const BorderSide(
                                                                              color: CustomColors
                                                                                  .secondarycolor),
                                                                          minimumSize: const Size(
                                                                              44,
                                                                              30),
                                                                          primary:
                                                                              CustomColors.secondarycolor),
                                                                      child: cartData!.cart!.listCartItem![index].qty! <=
                                                                              1
                                                                          ? const Align(
                                                                              alignment: Alignment.center,
                                                                              child: Icon(
                                                                                Icons.delete_outline_outlined,
                                                                                size: 17,
                                                                              ),
                                                                            )
                                                                          : const Align(
                                                                              alignment: Alignment.center,
                                                                              child: Text(
                                                                                "-",
                                                                                style: TextStyle(fontSize: 26),
                                                                              )),
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Text(
                                                                        "${cartData!.cart!.listCartItem![index].qty}"),
                                                                    const SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    OutlinedButton(
                                                                      onPressed:
                                                                          () {
                                                                        increase(
                                                                            index);
                                                                        changeQty(
                                                                            cartData!.cart!.listCartItem![index].itemId!,
                                                                            cartData!.cart!.listCartItem![index].qty!);
                                                                      },
                                                                      style: OutlinedButton.styleFrom(
                                                                          side: const BorderSide(
                                                                              color: CustomColors
                                                                                  .secondarycolor),
                                                                          minimumSize: const Size(
                                                                              30,
                                                                              30),
                                                                          primary:
                                                                              CustomColors.secondarycolor),
                                                                      child: const Align(
                                                                          alignment: Alignment.center,
                                                                          child: Text(
                                                                            "+",
                                                                            style:
                                                                                TextStyle(fontSize: 25),
                                                                          )),
                                                                    ),
                                                                  ],
                                                                )
                                                              : Container()
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                : cartData!
                                                            .cart!
                                                            .listCartItem![
                                                                index]
                                                            .isPointsPackage ==
                                                        true
                                                    ? Card(
                                                        elevation: 0,
                                                        shape: RoundedRectangleBorder(
                                                            side: BorderSide(
                                                                color: Colors
                                                                    .grey
                                                                    .shade200),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .all(8),
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .all(8),
                                                            height: 60,
                                                            width:
                                                                double.infinity,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            25),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade200)),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                        "${cartData!.cart!.listCartItem![index].pointsPackage!.getPropertyEffectedByLang("name_${globals.SelectedLang}")}"),
                                                                    Text(
                                                                        "(${cartData!.cart!.listCartItem![index].pointsPackage!.points})"),
                                                                    Text(
                                                                      S
                                                                          .of(context)
                                                                          .points,
                                                                    )
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                        "${cartData!.cart!.listCartItem![index].pointsPackage!.price}"),
                                                                    Text(
                                                                      S
                                                                          .of(context)
                                                                          .S_R,
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : Card(
                                                        elevation: 0,
                                                        shape: RoundedRectangleBorder(
                                                            side: BorderSide(
                                                                color: Colors
                                                                    .grey
                                                                    .shade200),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .all(8),
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .all(8),
                                                            height: 60,
                                                            width:
                                                                double.infinity,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            25),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade200)),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                        "${cartData!.cart!.listCartItem![index].subscriptionPackage!.getPropertyEffectedByLang("package_name_${globals.SelectedLang}")}"),
                                                                    Text(
                                                                        "(${cartData!.cart!.listCartItem![index].subscriptionPackage!.pointPrice})"),
                                                                    Text(
                                                                      S
                                                                          .of(context)
                                                                          .points,
                                                                    )
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                        "${cartData!.cart!.listCartItem![index].subscriptionPackage!.price}"),
                                                                    Text(
                                                                      S
                                                                          .of(context)
                                                                          .S_R,
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ));
                                  }),
                            ),

                            // const SizedBox(
                            //   height: 30,
                            // ),
                            Padding(
                              padding: const EdgeInsetsDirectional.symmetric(
                                  horizontal: 14),
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    side:
                                        BorderSide(color: Colors.grey.shade200),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.all(5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Switch(
                                              value: is_switched,
                                              activeColor:
                                                  CustomColors.secondarycolor,
                                              onChanged: (value) {
                                                change_switch_case(value);
                                              }),
                                          Text(
                                            S
                                                .of(context)
                                                .send_voucher_on_whatsapp,
                                          )
                                        ],
                                      ),
                                      Divider(
                                        color: Colors.grey.shade100,
                                      ),
                                      is_switched == true
                                          ? Text(
                                              S
                                                  .of(context)
                                                  .enter_your_whatsapp_number,
                                              style: CustomTheme.text18theme
                                                  .copyWith(
                                                      color: CustomColors
                                                          .secondarycolor),
                                            )
                                          : Container(),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      is_switched == true
                                          ? Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .all(8.0),
                                              child: customtextformfield(
                                                  keyboardType:
                                                      TextInputType.phone,
                                                  bordercolor:
                                                      Colors.grey.shade200,
                                                  validator: (val) {
                                                    return validinput(context,
                                                        val!, 10, 10, "phone");
                                                  },
                                                  hint: S
                                                      .of(context)
                                                      .phone_number,
                                                  controller: phoneController),
                                            )
                                          : Container()
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                               padding: const EdgeInsetsDirectional.symmetric(horizontal: 14),
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    side:
                                        BorderSide(color: Colors.grey.shade200),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: Padding(
                                  padding:
                                      const EdgeInsetsDirectional.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsetsDirectional.only(
                                                top: 10, start: 8),
                                        child: Text(
                                          S.of(context).payment_method,
                                          style: CustomTheme.text18theme
                                              .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: CustomColors
                                                      .primarycolor),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsetsDirectional.only(
                                                start: 8),
                                        child: Text(
                                          S.of(context).You_Will_earned +
                                              "${cartData?.cart!.total_earned_points} " +
                                              S.of(context).points,
                                          style: TextStyle(
                                              color: CustomColors.SuccessColor),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: cartData!.cart!
                                                .listPaymentMethod!.length *
                                            90,
                                        child: ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: cartData!.cart!
                                                .listPaymentMethod!.length,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  RadioListTile(
                                                    // shape: Border.all(color: Colors.grey.shade100),
                                                    shape: RoundedRectangleBorder(
                                                        side: BorderSide(
                                                            color: cartData!
                                                                        .cart!
                                                                        .listPaymentMethod![
                                                                            index]
                                                                        .key ==
                                                                    selectpayment
                                                                ? CustomColors
                                                                    .primarycolor
                                                                : Colors.grey
                                                                    .shade200),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),

                                                    controlAffinity:
                                                        ListTileControlAffinity
                                                            .trailing,
                                                    secondary: cartData!
                                                                .cart!
                                                                .listPaymentMethod![
                                                                    index]
                                                                .id ==
                                                            2
                                                        ? Text(S
                                                                .of(context)
                                                                .Pay_Using_Wallet +
                                                            " ${cartData!.cart!.balance} " +
                                                            S
                                                                .of(context)
                                                                .points)
                                                        : SizedBox(
                                                            width: 100,
                                                            height: 100,
                                                            child: cartData!
                                                                    .cart!
                                                                    .listPaymentMethod![
                                                                        index]
                                                                    .logo!
                                                                    .contains(
                                                                        'svg')
                                                                ? SvgPicture
                                                                    .network(
                                                                        "${cartData!.cart!.listPaymentMethod![index].logo}")
                                                                : Image.network(
                                                                    "${cartData!.cart!.listPaymentMethod![index].logo}"),
                                                          ),
                                                    activeColor: CustomColors
                                                        .primarycolor,
                                                    value:
                                                        "${cartData!.cart!.listPaymentMethod![index].key}",

                                                    groupValue: cartData!
                                                                    .cart!
                                                                    .listPaymentMethod![
                                                                        index]
                                                                    .key ==
                                                                "wallet" &&
                                                            cartData!.cart!
                                                                    .enable_pay_with_points ==
                                                                false
                                                        ? cartData!
                                                            .cart!
                                                            .listPaymentMethod![
                                                                0]
                                                            .key
                                                        : "${selectpayment}",
                                                    onChanged: cartData!
                                                                    .cart!
                                                                    .listPaymentMethod![
                                                                        index]
                                                                    .key ==
                                                                "wallet" &&
                                                            cartData!.cart!
                                                                    .enable_pay_with_points ==
                                                                false
                                                        ? (value) {
                                                            value = 0;
                                                          }
                                                        : (value) {
                                                            setpayment(
                                                                "${cartData!.cart!.listPaymentMethod![index].key}");
                                                          },
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  //youssef
                                                  // cartData!
                                                  //             .cart!
                                                  //             .listPaymentMethod![
                                                  //                 index]
                                                  //             .key ==
                                                  //         "wallet"
                                                  //     //  &&
                                                  //     // cartData!.cart!
                                                  //     //           .enable_pay_with_points ==
                                                  //     //       false
                                                  //     ? Text(
                                                  //         S
                                                  //                 .of(context)
                                                  //                 .your_balance_is +
                                                  //             "${cartData!.cart!.balance}" +
                                                  //             S
                                                  //                 .of(context)
                                                  //                 .and_you_cannot_purchase_via_points,
                                                  //         textAlign:
                                                  //             TextAlign.center,
                                                  //       )
                                                  //     : const Text(""),
                                                  cartData!.cart!.enable_pay_with_points ==
                                                              false &&
                                                          cartData!
                                                                  .cart!
                                                                  .listPaymentMethod![
                                                                      index]
                                                                  .key ==
                                                              "wallet"
                                                      ? TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .push(MaterialPageRoute(
                                                                    builder:
                                                                        (context) {
                                                              return const BuyPoints();
                                                            }));
                                                          },
                                                          child: Text(
                                                            S
                                                                .of(context)
                                                                .buy_points,
                                                            style: CustomTheme
                                                                .text16theme
                                                                .copyWith(
                                                                    color: CustomColors
                                                                        .secondarycolor,
                                                                    decoration:
                                                                        TextDecoration
                                                                            .underline,
                                                                    fontSize:
                                                                        14),
                                                          ))
                                                      : const Text("")
                                                ],
                                              );
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Padding(
                               padding: const EdgeInsetsDirectional.symmetric(horizontal: 14),
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    side:
                                        BorderSide(color: Colors.grey.shade200),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding:
                                      const EdgeInsetsDirectional.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsetsDirectional.only(
                                                top: 10),
                                        child: Text(
                                          S.of(context).order_summary,
                                          style: CustomTheme.text18theme
                                              .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: CustomColors
                                                      .primarycolor),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Divider(
                                        endIndent: 10,
                                        indent: 10,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            S.of(context).sub_total,
                                          ),
                                          Text(
                                            "${cartData!.cart!.subTotalAmount}" +
                                                " " +
                                                S.of(context).S_R,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Divider(
                                        endIndent: 10,
                                        indent: 10,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            S.of(context).discount,
                                            style: TextStyle(
                                                color: Colors.red.shade900),
                                          ),
                                          Text(
                                            "${cartData!.cart!.discountAmount}" +
                                                " " +
                                                S.of(context).S_R,
                                            style: TextStyle(
                                                color: Colors.red.shade900),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Divider(
                                        endIndent: 10,
                                        indent: 10,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            S.of(context).total,
                                            style: CustomTheme.text18theme
                                                .copyWith(color: Colors.black),
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${cartData!.cart!.total}" +
                                                      " ",
                                                  style: CustomTheme.text18theme
                                                      .copyWith(
                                                          color: Colors.black),
                                                ),
                                                Text(
                                                  S.of(context).S_R,
                                                  style: CustomTheme.text16theme
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                ),
                                                cartData!.cart!.listCartItem!
                                                            .isNotEmpty &&
                                                        cartData!
                                                                .cart!
                                                                .listCartItem![
                                                                    0]
                                                                .isCoupon ==
                                                            true
                                                    ? const Text(" = ")
                                                    : const Text(""),
                                                cartData!.cart!.listCartItem!
                                                            .isNotEmpty &&
                                                        cartData!
                                                                .cart!
                                                                .listCartItem![
                                                                    0]
                                                                .isCoupon ==
                                                            true
                                                    ? Text(
                                                        "${cartData!.cart!.totalPoints}" +
                                                            " ",
                                                        style: CustomTheme
                                                            .text18theme
                                                            .copyWith(
                                                                color: Colors
                                                                    .black),
                                                      )
                                                    : const Text(""),
                                                cartData!.cart!.listCartItem!
                                                            .isNotEmpty &&
                                                        cartData!
                                                                .cart!
                                                                .listCartItem![
                                                                    0]
                                                                .isCoupon ==
                                                            true
                                                    ? Text(
                                                        S.of(context).points,
                                                        style: CustomTheme
                                                            .text16theme
                                                            .copyWith(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                      )
                                                    : const Text("")
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Text(
                                        S
                                            .of(context)
                                            .all_prices_shown_are_inclusive_of_VAT_where_applicable,
                                        textAlign: TextAlign.center,
                                        style: CustomTheme.text15theme.copyWith(
                                            color: Colors.black, fontSize: 13),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Center(
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SvgPicture.asset(
                          "assets/images/empty-cart.svg",
                          width: 250,
                        ),
                        Text(
                          S.of(context).Oops +
                              "\n" +
                              S.of(context).The_Cart_is_Empty,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: CustomColors.primarycolor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: 150,
                          height: 50,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  primary: CustomColors.secondarycolor),
                              onPressed: () {
                                if (Navigator.canPop(context)) {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (context) {
                                    return HomeScreen();
                                  }));
                                }
                                ;
                              },
                              child: Text(
                                S.of(context).Go_Shopping,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              )),
                        )
                      ],
                    )),
            ),
    );
  }
}
