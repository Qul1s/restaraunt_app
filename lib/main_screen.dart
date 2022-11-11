
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaraunt_app/menu_page2.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'favorite_page.dart';
import 'order.dart';
import 'order_page.dart';
import 'package:iconsax/iconsax.dart';

import 'profile_page.dart';

class MainScreen extends StatefulWidget {
    const MainScreen({Key? key}) : super(key: key);

    @override
    State<MainScreen> createState() => _MainScreenState();
  }


class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin{

  int _bottomNavIndex  = 0;

  Widget returnPage(){
    switch(_bottomNavIndex){
      case 0: 
        return const MenuPage();
      case 1: 
        return const OrderPage();
      case 2: 
        return const FavoritePage();
      case 3: 
        return const ProfilePage();
      default: 
        return const MenuPage();
    }
  }


  List<IconData> iconList = [
    Iconsax.menu_14,
    Iconsax.menu_board,
    Iconsax.heart,
    Iconsax.profile_2user, 
  ];

  List<String> categories = ["Меню", "Замовлення", "Профіль", "Налаштування"];

  double sizeOfIcon(number){
    if(number == _bottomNavIndex){
      return 30;
    }
    else{
      return 18;
    }
  }

  Color colorOfIcon(number){
    if(number == _bottomNavIndex){
      return Colors.white;
    }
    else{
      return const Color.fromRGBO(180, 180, 180, 1);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: returnPage(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(254, 182, 102, 1),
        child: const Icon(Iconsax.shopping_cart, color: Color.fromRGBO(255, 255, 255, 1), size: 30),
        onPressed:() {
          ShowDialog(context);
      },),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          notchMargin: 5,
          itemCount: iconList.length,
          tabBuilder: (int index, bool isActive) {
            return Icon(
                  iconList[index],
                  size: sizeOfIcon(index),
                  color: colorOfIcon(index),
            );
          },
          backgroundColor: const Color.fromRGBO(18, 27, 40, 1),
          activeIndex: _bottomNavIndex,
          splashColor: const Color.fromRGBO(18, 27, 40, 1),
          splashSpeedInMilliseconds: 500,
          notchSmoothness: NotchSmoothness.smoothEdge,
          gapLocation: GapLocation.center,
          onTap: (index) => setState(() => _bottomNavIndex = index),
          hideAnimationController: AnimationController(
                                    duration: const Duration(milliseconds: 200),
                                    vsync: this,
                                  ),
        ),
      );
}
      

  


void ShowDialog(context){
  showDialog<String>(
                 context: context,
                 builder: (BuildContext context) => StatefulBuilder(
                  builder: (context, setState){ 
                    return AlertDialog(
                      insetPadding: const EdgeInsets.all(0),
                      shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  contentPadding: const EdgeInsets.all(0),
                  content: Container(
                    height: MediaQuery.of(context).size.height* 0.75,
                    width: MediaQuery.of(context).size.width*0.95,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(245, 245, 245, 1),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width* 0.23,
                                                    top: MediaQuery.of(context).size.height* 0.02),
                            width: MediaQuery.of(context).size.width* 0.5,
                            height: MediaQuery.of(context).size.height* 0.04,
                            child: Text("Ваше замовлення", 
                              style: GoogleFonts.poiretOne(
                                    textStyle: const TextStyle(
                                    color: Color.fromRGBO(31, 31, 47, 1),
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800)))),
                          GestureDetector(
                            onTap:() {
                              Navigator.pop(context);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(252, 252, 252, 1),
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 5), 
                                  ),
                                ],
                              ),
                              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width* 0.09,
                                                      top: MediaQuery.of(context).size.height* 0.02),
                              width: MediaQuery.of(context).size.width* 0.1,
                              height: MediaQuery.of(context).size.width* 0.1,
                              child: const Icon(Icons.close_rounded, size: 30, color: Color.fromRGBO(31, 31, 47, 1),)
                        ))
                        ],),
                        Expanded( 
                            child: Container(
                              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.02),
                              width: MediaQuery.of(context).size.width* 0.9,
                              child: ListView.separated(
                                      clipBehavior: Clip.none,
                                      itemCount: OrderList.order.length,
                                      separatorBuilder: (BuildContext context, int index) => SizedBox(height: MediaQuery.of(context).size.height* 0.02),
                                      itemBuilder: (BuildContext context, int index){
                                          return SwipeActionCell(
                                            backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
                                            key: ObjectKey(OrderList.order[index]), 
                                            trailingActions: <SwipeAction>[
                                              SwipeAction(
                                                  onTap: (CompletionHandler handler) async {
                                                    await handler(true);
                                                    setState(() {
                                                      OrderList.order.removeAt(index);
                                                    });
                                                  },
                                              backgroundRadius: 0,
                                              performsFirstActionWithFullSwipe: true,
                                              widthSpace: MediaQuery.of(context).size.width* 0.2,
                                              icon: const Icon(Iconsax.trash, color: Colors.white, size: 30),
                                              color: Colors.red),
                                        ],
                                        child: Container(
                                            height: MediaQuery.of(context).size.height* 0.15,
                                            decoration: const BoxDecoration(
                                              color: Color.fromRGBO(255, 255, 255, 1),
                                              borderRadius: BorderRadius.all(Radius.circular(20)),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width* 0.05),
                                                  width: MediaQuery.of(context).size.width* 0.32,
                                                  height: MediaQuery.of(context).size.width* 0.32,
                                                  alignment: Alignment.center,
                                                  child: Image.asset(
                                                          width: MediaQuery.of(context).size.width* 0.32,
                                                          height: MediaQuery.of(context).size.width* 0.32,
                                                          OrderList.order[index].image,
                                                          fit: BoxFit.fill)),
                                                Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(OrderList.order[index].name,
                                                              style: GoogleFonts.poiretOne(
                                                                          textStyle: const TextStyle(
                                                                          color: Color.fromRGBO(31, 31, 47, 1),
                                                                          fontSize: 20,
                                                                          fontWeight: FontWeight.w800))),
                                                          Container(
                                                            width: MediaQuery.of(context).size.width* 0.54,
                                                            margin: EdgeInsets.only(right: MediaQuery.of(context).size.width* 0.03),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                RichText(
                                                                text: TextSpan(
                                                                children: <TextSpan>[
                                                                    const TextSpan(text: "₴ ",                                                                 
                                                                    style: TextStyle(
                                                                      color: Color.fromRGBO(254, 182, 102, 1),
                                                                      fontSize: 18,
                                                                      fontWeight: FontWeight.w700)),
                                                                    TextSpan(text: " ${OrderList.order[index].price*OrderList.order[index].count}",                                                                  
                                                                        style: GoogleFonts.nunito(
                                                                          textStyle: const TextStyle(
                                                                          color: Color.fromRGBO(31, 31, 47, 1),
                                                                          fontSize: 20,
                                                                          fontWeight: FontWeight.w600))),
                                                                  ],)),
                                                                Container(
                                                                  width: MediaQuery.of(context).size.width* 0.2,
                                                                  height: MediaQuery.of(context).size.height* 0.04,
                                                                  decoration: const BoxDecoration(
                                                                    color: Color.fromRGBO(254, 182, 102, 1),
                                                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                    children: [
                                                                    GestureDetector(
                                                                      onTap: (){
                                                                        setState(() {
                                                                          if(OrderList.order[index].count!=1){
                                                                            OrderList.order[index].count--;
                                                                          }
                                                                        });
                                                                      },
                                                                      child: const Text("-",
                                                                        style: TextStyle(
                                                                          color: Colors.white,
                                                                          fontSize: 20,
                                                                          fontWeight: FontWeight.normal))),
                                                                    Text(OrderList.order[index].count.toString(),
                                                                    style: GoogleFonts.poiretOne(
                                                                          textStyle: const TextStyle(
                                                                          color: Colors.white,
                                                                          fontSize: 18,
                                                                          fontWeight: FontWeight.w800))),
                                                                  GestureDetector(
                                                                    onTap: (){
                                                                        setState(() {
                                                                          OrderList.order[index].count++;
                                                                        });
                                                                      },
                                                                    child: const Text("+",
                                                                      style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontSize: 22,
                                                                        fontWeight: FontWeight.normal))
                                                                  ),
                                                                ]
                                                              ))
                                                          ],)),
                                                        ],),
                                            ]),
                                          ));
                                },
                              ))
                        ),
                        Container(
                          decoration: DottedDecoration(shape: Shape.line, linePosition: LinePosition.bottom),
                          alignment: Alignment.topCenter,
                          width: MediaQuery.of(context).size.width*0.87,
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                                child: Text("Сума:", 
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poiretOne(
                                      textStyle: const TextStyle(
                                      color: Color.fromRGBO(31, 31, 47, 1),
                                      fontSize: 26,
                                      fontWeight: FontWeight.w800)))),     
                              Container(
                                margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.02,
                                                        top: MediaQuery.of(context).size.height*0.03),
                                child: Text("${sumOfElements()}₴", 
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.nunito(
                                      textStyle: const TextStyle(
                                      color: Color.fromRGBO(31, 31, 47, 1),
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600))),                                ),
                        ],)),
                         GestureDetector(
                                          onTap: (() {
                                            //Navigator.push(context,  MaterialPageRoute(builder: (context)=> const LoginPage()));
                                          }),
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: MediaQuery.of(context).size.height*0.05,
                                            width: MediaQuery.of(context).size.width*0.3,
                                            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02,
                                                                    left: MediaQuery.of(context).size.width*0.6,
                                                                    bottom: MediaQuery.of(context).size.height*0.02),
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), 
                                                          color: const Color.fromRGBO(254, 182, 102, 1),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey.withOpacity(0.5),
                                                              spreadRadius: 1,
                                                              blurRadius: 5,
                                                              offset: const Offset(0, 6), 
                                                            ),
                                                          ],),
                                            child: Text("Замовити", 
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.poiretOne(
                                                                          textStyle: const TextStyle(
                                                                          color: Colors.white,
                                                                          fontSize: 22,
                                                                          fontWeight: FontWeight.w800)),  
                                                                      ))),
                        
                        ],)
                                                    )
                                          );}),
                                        );
}
  int sumOfElements(){
    int sum = 0; 
    OrderList.order.forEach((element){
      sum += element.price*element.count;
     });
  return sum;
} 
}
