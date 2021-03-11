class MyServices {
  String serviceName;
  String serviceIcon;
  MyServices({this.serviceName, this.serviceIcon});

  List<MyServices> getServices() {
    return [
      MyServices(
          serviceName: ServiceType.makeup,
          serviceIcon: 'assets/images/makeup.png'),
      MyServices(
          serviceName: ServiceType.braiding,
          serviceIcon: 'assets/images/braiding.png'),
      MyServices(serviceName: "Nails", serviceIcon: 'assets/images/nails.png'),
      MyServices(
          serviceName: ServiceType.manicure,
          serviceIcon: 'assets/images/manicure.png'),
      MyServices(
          serviceName: ServiceType.photoshoot,
          serviceIcon: 'assets/images/camera.png'),
      MyServices(
          serviceName: ServiceType.wigCup,
          serviceIcon: 'assets/images/wigCup.png'),
      MyServices(
          serviceName: ServiceType.manicure,
          serviceIcon: 'assets/images/manicure.png'),
      MyServices(
          serviceName: ServiceType.fixWig,
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
