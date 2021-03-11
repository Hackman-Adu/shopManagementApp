class MyServices {
  String serviceName;
  String serviceIcon;
  String description;
  MyServices({this.serviceName, this.description, this.serviceIcon});

  List<MyServices> getServices() {
    return [
      MyServices(
          serviceName: ServiceType.makeup,
          description: "Service description here",
          serviceIcon: 'assets/images/makeup.png'),
      MyServices(
          serviceName: ServiceType.braiding,
          description: "Service description here",
          serviceIcon: 'assets/images/braiding.png'),
      MyServices(
          serviceName: "Nails",
          description: "Service description here",
          serviceIcon: 'assets/images/nails.png'),
      MyServices(
          serviceName: ServiceType.manicure,
          description: "Service description here",
          serviceIcon: 'assets/images/manicure.png'),
      MyServices(
          serviceName: ServiceType.photoshoot,
          description: "Service description here",
          serviceIcon: 'assets/images/camera.png'),
      MyServices(
          serviceName: ServiceType.wigCup,
          description: "Service description here",
          serviceIcon: 'assets/images/wigCup.png'),
      MyServices(
          serviceName: ServiceType.manicure,
          description: "Service description here",
          serviceIcon: 'assets/images/manicure.png'),
      MyServices(
          serviceName: ServiceType.fixWig,
          description: "Service description here",
          serviceIcon: 'assets/images/wig.png'),
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
