class MyServices {
  String serviceName;
  String description;
  MyServices({this.serviceName, this.description});

  List<MyServices> getServices() {
    return [
      MyServices(
        serviceName: ServiceType.makeup,
        description: "Service description here",
      ),
      MyServices(
        serviceName: ServiceType.braiding,
        description: "Service description here",
      ),
      MyServices(
        serviceName: "Nails",
        description: "Service description here",
      ),
      MyServices(
        serviceName: ServiceType.manicure,
        description: "Service description here",
      ),
      MyServices(
        serviceName: ServiceType.photoshoot,
        description: "Service description here",
      ),
      MyServices(
        serviceName: ServiceType.wigCup,
        description: "Service description here",
      ),
      MyServices(
        serviceName: ServiceType.manicure,
        description: "Service description here",
      ),
      MyServices(
        serviceName: ServiceType.fixWig,
        description: "Service description here",
      ),
    ];
  }
}

class ServiceType {
  static String makeup = "Makeup";
  static String braiding = "Braiding";
  static String nails = "Nails";
  static String manicure = "Manicure";
  static String photoshoot = "Photoshoots";
  static String wigCup = "Wig Caps";
  static String pedicure = "Pedicure";
  static String fixWig = "Fixing Wig";
}
