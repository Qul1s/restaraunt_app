
class DishOrder{
  String name;
  int price;
  int count;
  String image;


  DishOrder({
    required this.name,
    required this.price,
    required this.count,
    required this.image
  });
}

class OrderList{
   static List<DishOrder> order = [];
}

class ReadyOrder{
  int number;
  int price;
  List<DishOrder> dishOrder;
  String date;
  String time;
  String address;
  String status;
  int statufOfProcessing;

  ReadyOrder({
    required this.number,
    required this.dishOrder,
    required this.price,
    required this.date,
    required this.time,
    required this.address,
    required this.status,
    required this.statufOfProcessing
  });
}

class ReadyOrderList{
  static List<ReadyOrder> readyOrder = [ReadyOrder(
    number: 52352,
    dishOrder: [DishOrder(name: "Курячий суп з лапшою", price: 110, count: 2, image: "images/Soup/2.png"),
                DishOrder(name: "Курячі крильця", price: 230, count: 2, image: "images/Main_dishes/5.png")],
    price: 860,
    date: "28.10.2008",
    time: "18:20",
    address: "проспект Любомира Гузара, 11",
    status: "Виконаний",
    statufOfProcessing: 5),

    ReadyOrder(
    number: 52353,
    dishOrder: [DishOrder(name: "Курячий суп з лапшою", price: 110, count: 2, image: "images/Soup/2.png"),
                DishOrder(name: "Курячі крильця", price: 230, count: 2, image: "images/Main_dishes/5.png")],
    price: 430,
    date: "07.11.2008",
    time: "10:35",
    address: "проспект Любомира Гузара, 11",
    status: "Відхилений",
    statufOfProcessing: 0),
    
    ReadyOrder(
    number: 52354,
    dishOrder: [DishOrder(name: "Курячий суп з лапшою", price: 110, count: 2, image: "images/Soup/2.png"),
                DishOrder(name: "Курячі крильця", price: 230, count: 2, image: "images/Main_dishes/5.png"),
                DishOrder(name: "Курячі крильця", price: 230, count: 2, image: "images/Main_dishes/5.png"),
                DishOrder(name: "Курячі крильця", price: 230, count: 2, image: "images/Main_dishes/5.png")],
    price: 380,
    date: "12.13.2013",
    time: "20:00",
    address: "проспект Любомира Гузара, 11",
    status: "В процесі",
    statufOfProcessing: 4)];
}

