import 'package:beautyShop/models/images.dart';
import "package:flutter/material.dart";

class ChooseImage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChooseImageState();
  }
}

class ChooseImageState extends State<ChooseImage> {
  List<CustomersImages> images = CustomersImages().getImages();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Image"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 7),
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: this.images.length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisSpacing: 7,
                    crossAxisSpacing: 4,
                    maxCrossAxisExtent: 300),
                itemBuilder: (context, index) {
                  var image = this.images[index].imageUrl;
                  return InkWell(
                      onTap: () {
                        Navigator.of(context).pop(image.toString());
                      },
                      child: GridTile(
                          child: Container(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              image,
                              fit: BoxFit.cover,
                            )),
                      )));
                })
          ],
        ),
      ),
    );
  }
}
