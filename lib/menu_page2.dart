import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:awesome_page_transitions/awesome_page_transitions.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:restaraunt_app/authentication.dart';
import 'package:restaraunt_app/final_order_page.dart';
import 'dishes.dart';
import 'order.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutterfire_ui/database.dart';


  class MenuPage extends StatefulWidget {
    const MenuPage({Key? key}) : super(key: key);

    @override
    State<MenuPage> createState() => _MenuPageState();
  }

  class _MenuPageState extends State<MenuPage> {

    //List<Dish> dishesList = dishes;
    
    Color mainColor = const Color.fromRGBO(255, 105, 49, 1);
    Color additionalColor = const Color.fromRGBO(248, 248, 248, 1);
    Color textColor = const Color.fromRGBO(68, 68,68, 1);

    final TextEditingController searchController = TextEditingController();
    final List<String> categoriesList = ["Все", "Супи", "Основні страви","Боули", "Десерти"];
    final List<String> categoriesListImages = ["images/categories/all.png", "images/categories/soup.png", "images/categories/main.png" , "images/categories/bowl.png", "images/categories/dessert.png"];
    final List<Color> categoriesListColors = const [Color.fromRGBO(234,249,230, 1), Color.fromRGBO(230,237,250, 1), Color.fromRGBO(255,232,238,1),Color.fromRGBO(255, 255, 0, 0.2), Color.fromRGBO(0, 255, 255, 0.1)];




    



void showDialogWindow(dish, context){
  int count = 1;
  showModalBottomSheet<void>(
      useRootNavigator: true,
      isScrollControlled: true,
                                        context: context,
                                        isDismissible: true,
                                        enableDrag: true,
                                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30),
                                        )),
                                        builder: (context) {
                                          return StatefulBuilder(builder:
                                              (BuildContext context, StateSetter setModalState) {
                                            return BottomSheet(
                                                backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
                                                onClosing: () {},
                                                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(30)),
                                                builder: (context) {
                                                return Wrap(children: [GestureDetector( 
                                                    onTap: unfocus,
                                                    child: Container( 
                                                      decoration: const BoxDecoration(
                                                        color: Color.fromRGBO(248, 248, 248, 1),
                                                        borderRadius: BorderRadius.all(Radius.circular(30))),
                                                      width: MediaQuery.of(context).size.width,
                                                      child: Column(
                                                        children: [
                                                          Stack(children: [
                                                            Container(
                                                              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.04,
                                                                              bottom: MediaQuery.of(context).size.height*0.01,
                                                                              right: MediaQuery.of(context).size.width*0.04,
                                                                              left: MediaQuery.of(context).size.width*0.04),
                                                              decoration: const BoxDecoration(
                                                                color: Color.fromRGBO(230, 230, 230, 1),
                                                                borderRadius: BorderRadius.only(
                                                                  topLeft: Radius.circular(30),
                                                                  topRight: Radius.circular(30),
                                                                )),
                                                              width: MediaQuery.of(context).size.width,
                                                              child: ClipRRect(
                                                                borderRadius: const BorderRadius.only(
                                                                      topLeft: Radius.circular(30),
                                                                      topRight: Radius.circular(30),
                                                                    ),
                                                                child: Image.asset(dish.image, fit: BoxFit.contain))),
                                                            Container(
                                                              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.04,
                                                                              bottom: MediaQuery.of(context).size.height*0.01,
                                                                              right: MediaQuery.of(context).size.width*0.04,
                                                                              left: MediaQuery.of(context).size.width*0.04),
                                                              child:Row(
                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  GestureDetector(
                                                                    onTap: (() async {
                                                                                      setModalState(() => _visible = !_visible);
                                                                                      await Future.delayed(const Duration(milliseconds: 200));
                                                                                      setModalState(() => _visible = !_visible);
                                                                                      if(Dish.favoriteList.contains(dish.name)){
                                                                                        setModalState(() {
                                                                                          Dish.favoriteList.remove(dish.name);
                                                                                        });
                                                                                      }
                                                                                      else{
                                                                                        setModalState(() {
                                                                                          Dish.favoriteList.add(dish.name);
                                                                                        }); 
                                                                                      }
                                                                                    }),
                                                                    child: AnimatedOpacity(
                                                                          opacity: _visible ? 1.0 : 0.0,
                                                                          duration: const Duration(milliseconds: 250),
                                                                          child: returnIcon(dish.name)),
                                                                  )
                                                                  
                                                                ],
                                                            ))
                                                          ],),
                                                          Container(
                                                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03,
                                                                              bottom: MediaQuery.of(context).size.height*0.02,
                                                                              right: MediaQuery.of(context).size.width*0.04,
                                                                              left: MediaQuery.of(context).size.width*0.04),
                                                          width: MediaQuery.of(context).size.width,
                                                          child:
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(dish.name,
                                                                                      softWrap: true,
                                                                                      style: GoogleFonts.poiretOne(
                                                                                          textStyle: TextStyle(
                                                                                          color: textColor,
                                                                                          fontSize: 30,
                                                                                          decoration: TextDecoration.none,
                                                                                          fontWeight: FontWeight.w800)),
                                                                                    maxLines: 2,),
                                                              Container(
                                                                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                                                                child: Text("240 грам",
                                                                                      style: GoogleFonts.poiretOne(
                                                                                          textStyle: const TextStyle(
                                                                                          color: Color.fromRGBO(108, 108, 108, 1),
                                                                                          fontSize: 19,
                                                                                          decoration: TextDecoration.none,
                                                                                          fontWeight: FontWeight.w800)),)),
                                                                Container(
                                                                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),
                                                                  height: MediaQuery.of(context).size.height*0.0015,
                                                                  width: MediaQuery.of(context).size.width,
                                                                  color: const Color.fromRGBO(108, 108, 108, 1)
                                                                  ),
                                                                Container(
                                                                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),
                                                                  child: Text("Інгридієнти",
                                                                                      softWrap: false,
                                                                                      style: GoogleFonts.poiretOne(
                                                                                          textStyle: TextStyle(
                                                                                          color: textColor,
                                                                                          fontSize: 23,
                                                                                          decoration: TextDecoration.none,
                                                                                          fontWeight: FontWeight.w800)),
                                                                                    maxLines: 2,)),
                                                                Container(
                                                                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                                                                  child: Text(dish.ingridients,
                                                                                      softWrap: true,
                                                                                      style: GoogleFonts.poiretOne(
                                                                                          textStyle: const TextStyle(
                                                                                          color: Color.fromRGBO(108, 108, 108, 1),
                                                                                          fontSize: 20,
                                                                                          decoration: TextDecoration.none,
                                                                                          fontWeight: FontWeight.w800)),
                                                                                    maxLines: 2,)),
                                                                Container(
                                                                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Container(
                                                                      width: MediaQuery.of(context).size.width* 0.3,
                                                                      height: MediaQuery.of(context).size.height* 0.05,
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
                                                                                setModalState(() {
                                                                                  if(count!=1){
                                                                                    count--;
                                                                                  }
                                                                                });
                                                                              },
                                                                              child: const Text("-",
                                                                                    style: TextStyle(
                                                                                      color: Colors.white,
                                                                                      fontSize: 20,
                                                                                      decoration: TextDecoration.none,
                                                                                      fontWeight: FontWeight.normal))),
                                                                            Text(count.toString(),
                                                                                style: GoogleFonts.poiretOne(
                                                                                  textStyle: const TextStyle(
                                                                                    color: Colors.white,
                                                                                    fontSize: 18,
                                                                                    decoration: TextDecoration.none,
                                                                                    fontWeight: FontWeight.w800))),
                                                                            GestureDetector(
                                                                              onTap: (){
                                                                                setModalState(() {
                                                                                  count++;
                                                                                });
                                                                              },
                                                                              child: const Text("+",
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 22,
                                                                                  decoration: TextDecoration.none,
                                                                                  fontWeight: FontWeight.normal))
                                                                                                            ),
                                                                                                          ]
                                                                                                        )),
                                                                Container(
                                                                      width: MediaQuery.of(context).size.width* 0.55,
                                                                      height: MediaQuery.of(context).size.height* 0.05,
                                                                      decoration: const BoxDecoration(
                                                                          color: Color.fromRGBO(254, 182, 102, 1),
                                                                          borderRadius: BorderRadius.all(Radius.circular(8)),
                                                                        ),
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                        children: [
                                                                          Text("Додати",
                                                                                style: GoogleFonts.poiretOne(
                                                                                  textStyle: const TextStyle(
                                                                                    color: Colors.white,
                                                                                    fontSize: 18,
                                                                                    decoration: TextDecoration.none,
                                                                                    fontWeight: FontWeight.w800))),
                                                                          Text("₴${dish.price*count}",
                                                                                style: GoogleFonts.poiretOne(
                                                                                  textStyle: const TextStyle(
                                                                                    color: Colors.white,
                                                                                    fontSize: 18,
                                                                                    decoration: TextDecoration.none,
                                                                                    fontWeight: FontWeight.w800))),
                                                                        ])
                                                                )
                                                                ],
                                                              )) 
                                                          ],))
                                                        ],
                                                    )))]);
                                                  }
                                                  );
                                                });
                                              }
                                        );                     
}

Color colorForText(index){
    if(index == categoryIndex){
      return Colors.black;
    }
    else{
      return const Color.fromRGBO(145, 145, 145, 1);
    }
}

FontWeight fontWeight(index){
  if(index == categoryIndex){
      return FontWeight.w500;
    }
    else{
      return FontWeight.w400;
    }
}
Future<void> _changeOpacity() async {
    setState(() => _visible = !_visible);
    await Future.delayed(const Duration(milliseconds: 250));
    setState(() => _visible = !_visible);
  }
bool _visible = true;
final ScrollController _controller = ScrollController();

void _scrollTop() {
  _controller.animateTo(
    _controller.position.minScrollExtent,
    duration: const Duration(seconds: 1),
    curve: Curves.fastOutSlowIn,
  );
}

dynamic menuQuery = "";
int categoryIndex = 0;

void setUrl(){
  switch(categoryIndex){
    case 0: if (searchController.text.isNotEmpty){
    setState(() {
      menuQuery = FirebaseDatabase.instance.ref('Menu').orderByKey().startAt("${searchController.value.text[0].toUpperCase()}${searchController.value.text.substring(1)}");
    });
  }
  else{
    setState(() {
       menuQuery = FirebaseDatabase.instance.ref('Menu').orderByChild("categories");
    });
  }
  break;
  case 1: if (searchController.text.isNotEmpty){
    setState(() {
      menuQuery = FirebaseDatabase.instance.ref('Menu').orderByKey().startAt("${searchController.value.text[0].toUpperCase()}${searchController.value.text.substring(1)}");
    });
  }
  else{
    setState(() {
       menuQuery = FirebaseDatabase.instance.ref('Menu').orderByChild("categories").equalTo("0Супи");
    });
  }
  break;
  case 2: if (searchController.text.isNotEmpty){
    setState(() {
      menuQuery = FirebaseDatabase.instance.ref('Menu').orderByKey().startAt("${searchController.value.text[0].toUpperCase()}${searchController.value.text.substring(1)}");
    });
  }
  else{
    setState(() {
       menuQuery = FirebaseDatabase.instance.ref('Menu').orderByChild("categories").equalTo("1Основні страви");
    });
  }
  break;
  case 3: if (searchController.text.isNotEmpty){
    setState(() {
      menuQuery = FirebaseDatabase.instance.ref('Menu').orderByKey().startAt("${searchController.value.text[0].toUpperCase()}${searchController.value.text.substring(1)}");
    });
  }
  else{
    setState(() {
       menuQuery = FirebaseDatabase.instance.ref('Menu').orderByChild("categories").equalTo("2Боули");
    });
  }
  break;
  case 4: if (searchController.text.isNotEmpty){
    setState(() {
      menuQuery = FirebaseDatabase.instance.ref('Menu').orderByKey().startAt("${searchController.value.text[0].toUpperCase()}${searchController.value.text.substring(1)}");
    });
  }
  else{
    setState(() {
       menuQuery = FirebaseDatabase.instance.ref('Menu').orderByChild("categories").equalTo("3Десерти");
    });
  }
  break;
  }

  
  
}

Widget areaField(){
    double itemWidth = MediaQuery.of(context).size.width* 0.5;
    double itemHeight= MediaQuery.of(context).size.width* 0.76;
    if(menuQuery == null){
      return Expanded(
                  child:Container(
                                  width: MediaQuery.of(context).size.width* 0.95,
                                  alignment: Alignment.center,
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        AutoSizeText("На жаль, за даними параметрами нічого не знайдено",
                                            style: GoogleFonts.poiretOne(
                                              textStyle: TextStyle(
                                              color: textColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w800)),
                                            minFontSize: 12,
                                            stepGranularity: 2,
                                            textAlign: TextAlign.center),
                                        Lottie.asset('lottie/search.json',
                                          width: MediaQuery.of(context).size.width* 0.8,
                                          height: MediaQuery.of(context).size.height* 0.3
                                          ),
                                      ])));
    }
    else if(menuQuery == ""){
        return Expanded(
                  child:Container(
                                  width: MediaQuery.of(context).size.width* 0.95,
                                  alignment: Alignment.center,
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Lottie.asset('lottie/loading_food.json',
                                            width: MediaQuery.of(context).size.width* 0.8,
                                            height: MediaQuery.of(context).size.height* 0.3
                                            ),
                                        AutoSizeText("Загрузка..",
                                            style: GoogleFonts.poiretOne(
                                              textStyle: TextStyle(
                                              color: textColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w800)),
                                            minFontSize: 12,
                                            stepGranularity: 2,
                                            textAlign: TextAlign.center),
                                      ])));
    }
    else{
      return Expanded( child: Container( 
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.02),
                          alignment: Alignment.topCenter,
                          child: FirebaseDatabaseQueryBuilder(
                                  query: menuQuery,
                                  builder: (context, snapshot, _) { 
                                  return GridView.builder(
                            controller: _controller,
                            itemCount: snapshot.docs.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: (itemWidth/itemHeight),
                                crossAxisCount: 2,
                                crossAxisSpacing: MediaQuery.of(context).size.width* 0.05,
                                mainAxisSpacing: MediaQuery.of(context).size.height* 0.04,
                              ),
                            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.04,
                                                    right: MediaQuery.of(context).size.width*0.04),
                            shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index){
                                if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                                  snapshot.fetchMore();
                                  } 
                                final dish = jsonDecode(jsonEncode(snapshot.docs[index].value)) as Map<String, dynamic>;
                                String name = snapshot.docs[index].key.toString();
                                return GestureDetector(
                                  //onTap: () => showDialogWindow(dishes[index], context),
                                  child:Container(
                                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height* 0.02,
                                                          top: MediaQuery.of(context).size.height* 0.01,
                                                          left: MediaQuery.of(context).size.width*0.03,
                                                          right: MediaQuery.of(context).size.width*0.03),
                                  height: itemHeight,
                                  width: itemWidth,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), 
                                    color: const Color.fromRGBO(255, 255, 255, 1),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 5), 
                                      ),
                                    ],
                                  ),
                                    child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Stack(children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(8),
                                                topRight: Radius.circular(8),
                                              ),
                                          child: Image.asset(dish["image"], 
                                                            fit: BoxFit.contain)),
                                        GestureDetector(
                                          onTap: (() async {
                                            _changeOpacity();
                                            await Future.delayed(const Duration(milliseconds: 250));
                                            addToFavorite(name, dish["categories"], dish["image"], dish["name"],dish["price"]);
                                          }),
                                          child: AnimatedOpacity(
                                                  opacity: _visible ? 1.0 : 0.0,
                                                  duration: const Duration(milliseconds: 250),
                                                  child:Container(
                                            alignment: Alignment.topRight,
                                            child: returnIcon(name)
                                        )))                       
                                      ],),
                                      Container(
                                        height: MediaQuery.of(context).size.height* 0.045,
                                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.02,
                                                                left: MediaQuery.of(context).size.width*0.01),
                                        alignment: Alignment.topLeft,
                                        child: Text(name,
                                            softWrap: true,
                                            style: GoogleFonts.poiretOne(
                                                textStyle: TextStyle(
                                                color: textColor,
                                                height: 0.9,
                                                fontSize: 19,
                                                fontWeight: FontWeight.w800)),
                                          maxLines: 2,),
                                          ),
                                      Container(
                                        alignment: Alignment.topCenter,
                                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01),
                                        child: Row(mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text("₴ ",
                                              style: GoogleFonts.nunito(
                                                textStyle: const TextStyle(
                                                color: Color.fromRGBO(254, 182, 102, 1),
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold))),
                                            Text(dish["price"].toString(),
                                              style: GoogleFonts.nunito(
                                              textStyle: TextStyle(
                                              color: textColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold))),
                                           GestureDetector(
                                            onTap: () {
                                              OrderList.order.add(DishOrder(name: name, price: dish["price"], count: 1, image: dish["image"]));
                                              ShowDialog(context);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(100),
                                                boxShadow: [
                                                              BoxShadow(
                                                                color: Colors.grey.withOpacity(0.5),
                                                                spreadRadius: 0.5,
                                                                blurRadius: 5,
                                                                offset: const Offset(0, 0), 
                                                              ),
                                                            ],
                                                            ),
                                              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.15),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(100),
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  height: MediaQuery.of(context).size.height* 0.034,
                                                  color: const Color.fromRGBO(254, 182, 102, 1),
                                                  width: MediaQuery.of(context).size.height* 0.034,
                                                  child: const Icon(Icons.add_rounded, 
                                                                size: 24, 
                                                                color: Colors.white,))))),  
                                          ],))
                                  ],),
                                  ));
                              });})));
    }
  }

    Icon returnIcon(name){
      if(Dish.favoriteList.contains(name)){
          return const Icon(Icons.favorite_outlined, size: 27, color: Color.fromRGBO(254, 182, 102, 1),);
      }
      else{
        return const Icon(Icons.favorite_outline_rounded, size: 27, color: Color.fromRGBO(254, 182, 102, 1),);
      }   
    }
    dynamic currentFocus;
    unfocus() {
    currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    }

    @override
    void initState() {
        setUrl();
        super.initState(); 
      }

  @override
  void didChangeDependencies() {      
    preCache();
    super.didChangeDependencies();  
}

bool isLoaded = false;

void preCache(){
    precacheImage(const AssetImage("images/login_background.jpg"), context);     
    precacheImage(const AssetImage("images/apple-black-logo.png"), context); 
    precacheImage(const AssetImage("images/Dessert/1.png"), context);  
    precacheImage(const AssetImage("images/Dessert/2.png"), context);  
    precacheImage(const AssetImage("images/Dessert/3.png"), context);  
    precacheImage(const AssetImage("images/Dessert/4.png"), context);  
    precacheImage(const AssetImage("images/Main_dishes/1.png"), context);  
    precacheImage(const AssetImage("images/Main_dishes/2.png"), context);  
    precacheImage(const AssetImage("images/Main_dishes/3.png"), context);  
    precacheImage(const AssetImage("images/Main_dishes/4.png"), context);  
    precacheImage(const AssetImage("images/Main_dishes/5.png"), context);  
    precacheImage(const AssetImage("images/Main_dishes/6.png"), context);  
    precacheImage(const AssetImage("images/Salad/1.png"), context);  
    precacheImage(const AssetImage("images/Salad/2.png"), context);  
    precacheImage(const AssetImage("images/Salad/3.png"), context);  
    precacheImage(const AssetImage("images/Soup/1.png"), context);  
    precacheImage(const AssetImage("images/categories/all.png"), context);  
    precacheImage(const AssetImage("images/categories/bowl.png"), context);  
    precacheImage(const AssetImage("images/categories/dessert.png"), context);  
    precacheImage(const AssetImage("images/categories/soup.png"), context);  
    precacheImage(const AssetImage("images/restaraunt-logo.png"), context);  
    precacheImage(const AssetImage("images/courier.png"), context);  
    setState(() {
      isLoaded = true;
    });
}


    @override
    Widget build(BuildContext context) {
      if(isLoaded){
      return GestureDetector( 
          onTap: unfocus,
          child: Scaffold(
                  backgroundColor: additionalColor,
                  body: Column(children: [
                  Stack(alignment: Alignment.bottomCenter,
                    children: [
                    Container(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.05),
                      height: MediaQuery.of(context).size.height*0.927,
                      width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.02),
                          height: MediaQuery.of(context).size.height*0.05,
                          width: MediaQuery.of(context).size.width*0.9,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), 
                            color: const Color.fromRGBO(241, 241, 241, 1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),
                                child: const Icon(Iconsax.search_normal, 
                                        color: Color.fromRGBO(100, 100, 100, 1),
                                        size: 25,)),
                            Expanded(
                              child:
                                Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03,
                                                        right: MediaQuery.of(context).size.width*0.05),
                                child: TextField(
                                      onChanged:(text) {
                                         setUrl();
                                      },
                                      controller: searchController,
                                      obscureText: false,
                                      textAlign: TextAlign.left,
                                      cursorColor: const Color.fromRGBO(169, 169, 169, 1),
                                      textAlignVertical: TextAlignVertical.bottom,
                                      decoration: InputDecoration(
                                        focusedBorder: const UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Color.fromRGBO(241, 241, 241, 1), width: 0)),
                                        enabledBorder:  const UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Color.fromRGBO(241, 241, 241, 1), width: 0)),
                                        border: const UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color:  Color.fromRGBO(241, 241, 241, 1), width: 0)),
                                        labelText: 'Пошук',
                                        floatingLabelBehavior: FloatingLabelBehavior.never,
                                        labelStyle: GoogleFonts.montserrat(
                                              textStyle: const TextStyle(
                                              color: Color.fromRGBO(169, 169, 169, 1),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400))
                                      ),
                                      style: GoogleFonts.montserrat(
                                              textStyle: const TextStyle(
                                              color: Color.fromRGBO(80, 80, 80, 1),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400))
                                    ))),
                            ],
                          ),
                        ),
                        Container( 
                          height: MediaQuery.of(context).size.height*0.085,
                          width: MediaQuery.of(context).size.width*0.9,
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.02),
                          child: ListView.builder(
                            itemCount: categoriesList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index){
                              return GestureDetector(
                                onTap:() {
                                  _scrollTop();
                                  setState(() {
                                    categoryIndex = index;
                                  });
                                  setUrl();
                                },
                                child: Container(
                                   decoration: BoxDecoration(
                                      color: categoriesListColors[index],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  alignment: Alignment.bottomRight,
                                  height: MediaQuery.of(context).size.height*0.09,
                                  width: MediaQuery.of(context).size.width*0.32,
                                  margin: EdgeInsets.only(right: MediaQuery.of(context).size.height* 0.01),
                                  child: Stack(
                                    children: [
                                       Container(
                                        alignment: Alignment.bottomRight,
                                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.15),
                                        height: MediaQuery.of(context).size.height*0.12,
                                        width: MediaQuery.of(context).size.width*0.3,
                                        decoration: BoxDecoration( 
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(15),
                                          child:  Image.asset(categoriesListImages[index],
                                              fit: BoxFit.fill,)),
                                              ),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.01,
                                                left: MediaQuery.of(context).size.width*0.02),
                                        height: MediaQuery.of(context).size.height*0.1,
                                        width: MediaQuery.of(context).size.width*0.32,
                                        child: Text(categoriesList[index], 
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.montserrat(
                                              textStyle: TextStyle(
                                              color: colorForText(index),
                                              fontSize: 15,
                                              fontWeight: fontWeight(index))))),
                                     
                                              ],
                                  )
                                  
                                  )
                              );
                            })
                        ),
                        areaField()     
                    ]
                  )),
                          ]),
                          ])));}
       else{
        return Expanded(
                            child:Container(
                                            width: MediaQuery.of(context).size.width* 0.95,
                                            alignment: Alignment.center,
                                            child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Lottie.asset('lottie/loading_food.json',
                                                      width: MediaQuery.of(context).size.width* 0.8,
                                                      height: MediaQuery.of(context).size.height* 0.3
                                                      ),
                                                  AutoSizeText("Загрузка..",
                                                      style: GoogleFonts.poiretOne(
                                                        textStyle: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.w800)),
                                                      minFontSize: 12,
                                                      stepGranularity: 2,
                                                      textAlign: TextAlign.center),
                                                ])));
     }
    }


// ignore: non_constant_identifier_names
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
                                            Navigator.push( context,
                                              AwesomePageRoute(
                                                transitionDuration: const Duration(milliseconds: 600),
                                                exitPage: widget,
                                                enterPage: const FinalOrderPage(),
                                                transition: StackTransition(),
                                              ));
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
    for (var element in OrderList.order) {
      sum += element.price*element.count;
     }
  return sum;
} 
}