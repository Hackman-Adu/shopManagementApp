import 'package:beautyShop/models/services.dart';

class Customers {
  String fullName;
  String emailAddress;
  String telephone;
  String address;
  String serviceType;
  String image;
  String customerID;
  Customers(
      {this.fullName,
      this.emailAddress,
      this.telephone,
      this.address,
      this.serviceType,
      this.customerID,
      this.image});

  List<Customers> getCustomers() {
    return [
      Customers(
          customerID: "CUS001",
          fullName: "Belinda Appiah",
          emailAddress: "belindaappiah@gmail.com",
          telephone: "+233 248520036",
          address: "ASB Junction, 2nd Street Malam",
          image: "assets/images/girl3.jpg",
          serviceType: ServiceType.braiding),
      Customers(
          customerID: "CUS002",
          fullName: "Jessica Lovial",
          emailAddress: "jessicalovia@gmail.com",
          telephone: "+233 248456789",
          address: "ASB Junction, 3rd Street Malam",
          image: "assets/images/girl2.jpg",
          serviceType: ServiceType.makeup),
      Customers(
          customerID: "CUS003",
          fullName: "Gifty Akosua Gyebi",
          emailAddress: "giftygyebi@yahoo.com",
          telephone: "+233 245678989",
          address: "ABC Street,Safia",
          image: "assets/images/girl5.jpg",
          serviceType: ServiceType.makeup),
      Customers(
          customerID: "CUS004",
          fullName: "Lind Obeng Agyemang",
          emailAddress: "lindaagyemang@gmail.com",
          telephone: "+233 246789045",
          address: "ASB Junction, 2nd Street Malam",
          image: "assets/images/girl7.jpg",
          serviceType: ServiceType.makeup),
      Customers(
          customerID: "CUS005",
          fullName: "Vivian Oteng",
          emailAddress: "vivianoteng@yahoo.com",
          telephone: "+233 247890989",
          address: "AZ Junction Street,PB 123",
          image: "assets/images/girl9.jpg",
          serviceType: ServiceType.makeup)
    ];
  }
}
