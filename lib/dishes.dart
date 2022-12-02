class Dish{

    String name;
    String ingridients;
    int price;
    String image;
    String categories;

    Dish({
      required this.name,
      required this.ingridients,
      required this.price,
      required this.image,
      required this.categories
    });

    static List<String> favoriteList = ["Курячі крильця"];
}


List<Dish> dishes = [
  Dish(name: "Курячий суп з лапшою", ingridients: "Курка, лапша, сир, цибуля,  зелень", price: 110, image: "images/Soup/2.png", categories: "Супи"),
  Dish(name: "Гарбузовий суп", ingridients: "Гарбуз, вершки, гриби", price: 130, image: "images/Soup/1.png", categories: "Супи"),
 
  Dish(name: "Паста з овочами", ingridients: "Паста, перець, томати, пармезан", price: 180, image: "images/Main_dishes/1.png", categories: "Основні страви"),
  Dish(name: "Лапша з креветками", ingridients: "Спагетти, креветки, мідії, перець", price: 250, image: "images/Main_dishes/2.png", categories: "Основні страви"),
  Dish(name: "Рис з куркою", ingridients: "Рис, курка, салат Айсберг", price: 220, image: "images/Main_dishes/3.png", categories: "Основні страви"),
  Dish(name: "Курка з овочами", ingridients: "Курка, авокадо, цибуля, мікс салату, томати, соус", price: 230, image: "images/Main_dishes/4.png", categories: "Основні страви"),
  Dish(name: "Курячі крильця", ingridients: "Курка, листя салату", price: 230, image: "images/Main_dishes/5.png", categories: "Основні страви"),
  Dish(name: "Картопля з овочами", ingridients: "Картопля, томати, перець, цибуля", price: 180, image: "images/Main_dishes/6.png", categories: "Основні страви"),

  Dish(name: "Боул з куркою", ingridients: "Курка, кіноа, кукурудза, томати", price: 210, image: "images/Salad/1.png", categories: "Боули"),
  Dish(name: "Боул з овочами", ingridients: "Нут, гарбуз, салат Айсберг, авокадо, перець, редька", price: 180, image: "images/Salad/2.png", categories: "Боули"),
  Dish(name: "Боул з рибою", ingridients: "Рис, лосось, огірок, квасоля, норі, вакаме", price: 280, image: "images/Salad/3.png", categories: "Боули"),
  
  Dish(name: "Сирники", ingridients: "Класичні сирники з мигдалем", price: 180, image: "images/Dessert/1.png", categories: "Десерти"),
  Dish(name: "Десерт 'Смаколики'", ingridients: "6 видів найсмачніших смаколиків", price: 150, image: "images/Dessert/2.png", categories: "Десерти"),
  Dish(name: "Вишневий пиріг", ingridients: "Пиріг з соковитою вишневою начинкою", price: 160, image: "images/Dessert/3.png", categories: "Десерти"),
  Dish(name: "Наполеон з чорносливом", ingridients: "Торт з чорнсливом, прикрашений полуницею", price: 190, image: "images/Dessert/4.png", categories: "Десерти"),

  ];




