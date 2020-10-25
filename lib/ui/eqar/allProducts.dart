import 'package:flutter/material.dart';
import 'package:real_estate/apis/eqar/productApi.dart';
import 'package:real_estate/color/constColor.dart';

class AllProducts extends StatefulWidget {
  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  ProductApi productApi = new ProductApi();
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    productApi.getAllAnnounceData().then((val) {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("عقارات",
              style: TextStyle(
                color: Colors.white,
              )),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: color,
        ),
        body: Container(
          child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       buildPlaceContainer("منطقة الرياض", false),
              //       buildPlaceContainer("منطقة الرياض", true),
              //       buildPlaceContainer("منطقة الرياض", false),
              //       buildPlaceContainer("منطقة الرياض", false),
              //     ],
              //   ),
              // ),
              Container(
                height: MediaQuery.of(context).size.height - 122.0,
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: productApi.productList.length,
                  itemBuilder: (context, index) {
                    return offerUI(
                        "assets/builder.jpg",
                        productApi.productList[index].title??"عمارة للإيجار",
                        productApi.productList[index].price??"20000.000 ريال",
                        "811م ,تجاري , 5محل",
                        productApi.productList[index].desc??"طريق الامير فيصل بن بندر ,حي النرجس الرياض");
                  },
                ),
              ),
            ],
          ),
        ));
  }

  Widget offerUI(
      String img, String name, String price, String space, String desc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 100.0,
          width: 150.0,
          child: Image(
            image: AssetImage(img),
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        SizedBox(
          width: 150.0,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: RichText(
                    textDirection: TextDirection.rtl,
                    text: TextSpan(children: [
                      TextSpan(
                          text: name + "\n",
                          style: TextStyle(color: Colors.black)),
                      TextSpan(
                          text: price + "\n",
                          style: TextStyle(color: Colors.blue)),
                      TextSpan(
                          text: space + "\n",
                          style: TextStyle(color: Colors.black)),
                      TextSpan(
                          text: desc, style: TextStyle(color: Colors.grey)),
                    ])),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget buildPlaceContainer(String title, bool isSelected) {
    return InkWell(
      onTap: () {
        // setState(() {
        //   selectedDesign = true;
        //   selectedPlaning = false;
        //   selectedSupervision = false;
        //   selectedbuilding = false;
        //   selectedpurchase = false;

        // });
      },
      child: Container(
        width: 80.0,
        decoration: BoxDecoration(
            color: (isSelected) ? color : Colors.transparent,
            border: Border.all(color: color)),
        child: Center(
            child: Text(title,
                style: TextStyle(color: (isSelected) ? Colors.white : color))),
      ),
    );
  }
}