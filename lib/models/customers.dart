class Customers {
  String fullName;
  String emailAddress;
  String telephone;
  String address;
  String image;
  String customerID;
  String telephone2;
  String gender;
  Customers(
      {this.fullName,
      this.telephone2 = '',
      this.gender,
      this.emailAddress,
      this.telephone,
      this.address,
      this.customerID,
      this.image});

  List<Customers> getCustomers() {
    return [
      Customers(
        customerID: "CUS001",
        fullName: "Belinda Appiah",
        gender: "Female",
        telephone2: "+233 248523003",
        emailAddress: "belindaappiah@gmail.com",
        telephone: "248520036",
        address: "ASB Junction, 2nd Street Malam",
        image: "",
      ),
      Customers(
        gender: "Female",
        telephone2: "248523003",
        customerID: "CUS002",
        fullName: "Jessica Lovial",
        emailAddress: "jessicalovia@gmail.com",
        telephone: "248456789",
        address: "ASB Junction, 3rd Street Malam",
        image: "assets/images/girl2.jpg",
      ),
      Customers(
        gender: "Female",
        telephone2: "248523003",
        customerID: "CUS003",
        fullName: "Gifty Akosua Gyebi",
        emailAddress: "giftygyebi@yahoo.com",
        telephone: "+233 245678989",
        address: "ABC Street,Safia",
        image: "assets/images/girl5.jpg",
      ),
      Customers(
        gender: "Female",
        telephone2: "248523003",
        customerID: "CUS004",
        fullName: "Lind Obeng Agyemang",
        emailAddress: "lindaagyemang@gmail.com",
        telephone: "+233 246789045",
        address: "ASB Junction, 2nd Street Malam",
        image: "",
      ),
      Customers(
        gender: "Female",
        telephone2: "248523003",
        customerID: "CUS005",
        fullName: "Vivian",
        emailAddress: "vivianoteng@yahoo.com",
        telephone: "247890989",
        address: "AZ Junction Street,PB 123",
        image: "",
      )
    ];
  }
}
