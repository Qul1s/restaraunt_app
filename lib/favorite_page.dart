import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'dishes.dart';
import 'order.dart';


  class FavoritePage extends StatefulWidget {
    const FavoritePage({Key? key}) : super(key: key);

    @override
    State<FavoritePage> createState() => _FavoritePageState();
  }

  class _FavoritePageState extends State<FavoritePage> {

    List<Dish> dishesList = dishes;
    int selectCategory = 0;


    
    Color mainColor = const Color.fromRGBO(255, 105, 49, 1);
    Color additionalColor = const Color.fromRGBO(248, 248, 248, 1);
    Color textColor = const Color.fromRGBO(68, 68,68, 1);

    final TextEditingController searchController = TextEditingController();
    final List<String> categoriesList = ["Все", "Супи", "Основні страви","Боули", "Десерти"];
    final List<String> categoriesListImages = ["images/categories/all.png", "images/categories/soup.png", "images/categories/main.png" , "images/categories/bowl.png", "images/categories/dessert.png"];
    final List<Color> categoriesListColors = const [Color.fromRGBO(234,249,230, 1), Color.fromRGBO(230,237,250, 1), Color.fromRGBO(255,232,238,1),Color.fromRGBO(255, 255, 0, 0.2), Color.fromRGBO(0, 255, 255, 0.1)];
    

    double returnHeight(List<DishOrder> order, context){
      if(order.isEmpty){
        return 0;
      }
      else{
        return MediaQuery.of(context).size.height* 0.05;
      }
    }

    double returnHeightTwo(List<DishOrder> order, context){
      if(order.isEmpty){
        return MediaQuery.of(context).size.height* 0.11;
      }
      else{
        return MediaQuery.of(context).size.height* 0.18;
      }
    }


    void sortList(category){
      createFavoriteList();
      List<Dish> tempList= [];
      if(category != "Все"){
        for (var element in dishesList) {
          if(element.categories == category){
            tempList.add(element);
          }
        }
        setState(() {
          dishesList = tempList;
        });
      }
    }

    



void showDialogWindow(String text, int price, String image, context){
  int count = 1;
  showModalBottomSheet<void>(
      useRootNavigator: true,
                                        context: context,
                                        isDismissible: true,
                                        enableDrag: false,
                                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                        )),
                                        builder: (context) {
                                          return StatefulBuilder(builder:
                                              (BuildContext context, StateSetter setModalState) {
                                            return BottomSheet(
                                                backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
                                                onClosing: () {},
                                                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(30)),
                                                builder: (context) {
                                                return SizedBox(
                                                   height: returnHeightTwo(OrderList.order, context),
                                                   child: Column(children: [
                                                Column( 
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                 Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.01,
                                                                                  left: MediaQuery.of(context).size.width* 0.05),
                                                        child: Text(text,
                                                        style: const TextStyle(color: Color.fromRGBO(68, 68,68, 1),
                                                          fontFamily: "Ruberoid",
                                                          fontSize: 22,
                                                          fontWeight: FontWeight.w300))),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                  Container(
                                                          width: MediaQuery.of(context).size.width* 0.18,
                                                          margin: EdgeInsets.only(left: MediaQuery.of(context).size.width* 0.05),
                                                          child: Text("${count*price}₴",
                                                            style: const TextStyle(color: Color.fromRGBO(68, 68,68, 1),
                                                            fontFamily: "Ruberoid",
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.w300))),
                                                 Container(                      
                                                    width: MediaQuery.of(context).size.width* 0.4,
                                                    alignment: Alignment.topCenter,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                 GestureDetector(
                                                          onTap: (){
                                                            if(count != 1){
                                                              setModalState(() {
                                                              count-=1;
                                                            });
                                                            }
                                                          } ,
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(100),
                                                          child: Container(
                                                            alignment: Alignment.center,
                                                            height: MediaQuery.of(context).size.height* 0.045,
                                                            width: MediaQuery.of(context).size.height* 0.045,
                                                            color: const Color.fromRGBO(250, 250, 250, 1),
                                                            child: const Icon(Icons.remove_outlined, 
                                                                          size: 24, 
                                                                          color: Color.fromRGBO(255, 105, 49, 1),)))),
                                                 Container( 
                                                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.0045),
                                                  child: Text("$count",
                                                        style: const TextStyle(color: Color.fromRGBO(68, 68,68, 1),
                                                          fontFamily: "Ruberoid",
                                                          fontSize: 26,
                                                          fontWeight: FontWeight.w300))),
                                                 GestureDetector(
                                                        onTap: (){
                                                          setModalState(() {
                                                            count+=1;
                                                          });
                                                        } ,
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(100),
                                                          child: Container(
                                                            alignment: Alignment.center,
                                                            height: MediaQuery.of(context).size.height* 0.045,
                                                            width: MediaQuery.of(context).size.height* 0.045,
                                                            color: const Color.fromRGBO(250, 250, 250, 1),
                                                            child: const Icon(Icons.add_outlined, 
                                                                          size: 24, 
                                                                          color: Color.fromRGBO(255, 105, 49, 1),)))), 
                                                                ],)),
                                                    GestureDetector(
                                                      onTap: (){
                                                        Navigator.of(context).pop();
                                                        setState(() {
                                                          
                                                        });
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.only(right: MediaQuery.of(context).size.width* 0.05),
                                                        alignment: Alignment.center,
                                                        height: MediaQuery.of(context).size.height*0.05,
                                                        width: MediaQuery.of(context).size.width*0.18,
                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), 
                                                            color: const Color.fromRGBO(255, 105, 49, 1)),
                                                            
                                                        child: const Icon(Icons.shopping_cart_outlined, 
                                                              size: 30, 
                                                              color: Color.fromRGBO(250, 250, 250, 1),)))
                                                  ])]),
                                                ]));
                                                  }
                                                  );
                                                });
                                              }
                                        );                       
}

Color colorForText(index){
    if(index == selectCategory){
      return Colors.black;
    }
    else{
      return const Color.fromRGBO(145, 145, 145, 1);
    }
}

FontWeight fontWeight(index){
  if(index == selectCategory){
      return FontWeight.w500;
    }
    else{
      return FontWeight.w400;
    }
}

final ScrollController _controller = ScrollController();

void createFavoriteList(){
      List<Dish> tempList= [];
      setState(() {
          dishesList = dishes;
        });
        for (var element in dishesList) {
          for (var favoriteElement in Dish.favoriteList) {
            if(element.name == favoriteElement){
              tempList.add(element);
            }
          }
          }

          setState(() {
            dishesList = tempList;
        });
        }



Widget areaField(){
    double itemWidth = MediaQuery.of(context).size.width* 0.5;
    double itemHeight= MediaQuery.of(context).size.width* 0.76;
    if(dishesList.isEmpty){
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
    else{
      return Expanded( child: Container( 
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.02),
                          alignment: Alignment.topCenter,
                          child: GridView.builder(
                            controller: _controller,
                            itemCount: dishesList.length,
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
                                return Container(
                                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height* 0.02,
                                                          top: MediaQuery.of(context).size.height* 0.01,
                                                          left: MediaQuery.of(context).size.width*0.03,
                                                          right: MediaQuery.of(context).size.width*0.03),
                                  height: itemHeight,
                                  width: itemWidth,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), 
                                    color: const Color.fromRGBO(255, 255, 255, 1),
                                  ),
                                    child: Column(mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Stack(children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(8),
                                                topRight: Radius.circular(8),
                                              ),
                                          child: Image.asset(dishesList[index].image, 
                                                            fit: BoxFit.contain)),                       
                                      ],),
                                      Container(
                                        height: MediaQuery.of(context).size.height* 0.045,
                                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.02,
                                                                left: MediaQuery.of(context).size.width*0.01),
                                        alignment: Alignment.topLeft,
                                        child: Text(dishesList[index].name,
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
                                            Text(dishesList[index].price.toString(),
                                              style: GoogleFonts.nunito(
                                              textStyle: TextStyle(
                                              color: textColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold))),
                                           GestureDetector(
                                            onTap: () {
                                              OrderList.order.add(DishOrder(name: dishesList[index].name, price: dishesList[index].price, count: 1, image: dishesList[index].image));
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
                                  );
                              })));
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
        super.initState();
        createFavoriteList();
      }

    @override
    Widget build(BuildContext context) {
      return GestureDetector( 
          onTap: unfocus,
          child: Scaffold(
                  backgroundColor: additionalColor,
                  body: Column(children: [
                  Stack(alignment: Alignment.bottomCenter,
                    children: [
                    Container(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.05,
                                                bottom: returnHeight(OrderList.order, context)),
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
                                          List<Dish> searchList = [];
                                          if(searchController.value.text.isNotEmpty){
                                              for(int i=0; i<dishesList.length; i++){
                                                if(dishesList[i].name.toLowerCase().contains(searchController.value.text.toLowerCase())){
                                                  setState(() {
                                                    searchList.add(dishesList[i]);
                                                  });
                                                }
                                            }
                                            setState(() {
                                               dishesList = searchList;
                                            });
                                          }
                                          else{
                                            setState(() {
                                               createFavoriteList();
                                            });
                                          }
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
                                  setState(() {
                                    selectCategory = index;
                                  });
                                  sortList(categoriesList[index]);
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
                          ])));
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
                                                                      color: Color.fromRGBO(255, 105, 49, 1),
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
                                                                    color: Color.fromRGBO(255, 105, 49, 1),
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
                                                          color: const Color.fromRGBO(255, 105, 49, 1),
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