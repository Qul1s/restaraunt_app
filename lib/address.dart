class Address{

  String street;
  String building;
  String entrance = "";
  String floor = "";
  String apartment = "";

  Address({
    required this.street,
    required this.building,
    this.entrance = '',
    this.floor = " ",
    this.apartment = " "
  });

}

List<Address> addressList = [Address(street: "пр. Любомира Гузара", building: "12", entrance: "2", floor: "12", apartment: "142")];

