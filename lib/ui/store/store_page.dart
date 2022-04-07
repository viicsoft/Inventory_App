import 'package:flutter/material.dart';
import 'package:viicsoft_inventory_app/component/colors.dart';
import 'package:viicsoft_inventory_app/models/category.dart';
import 'package:viicsoft_inventory_app/services/apis/category_api.dart';
import 'package:viicsoft_inventory_app/ui/store/equipment_page.dart';

class StorePage extends StatefulWidget {
  const StorePage({
    Key? key,
  }) : super(key: key);

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  Future refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //var provider = Provider.of<InventoryData>(context);
    return WillPopScope(
      onWillPop: () async =>  false,
      child: Scaffold(
        backgroundColor: AppColor.homePageBackground,
        body: RefreshIndicator(
          onRefresh: refresh,
          child: Container(
            padding: const EdgeInsets.only(top: 70, left: 10, right: 10),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColor.gradientFirst,
                        AppColor.gradientSecond.withOpacity(0.8)
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    ),
                  ),
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'Inventory Category',
                    style: TextStyle(
                      fontSize: 25,
                      color: AppColor.homePageContainerTextBig,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: FutureBuilder<List<EquipmentCategory>>(
                        future: CategoryAPI().fetchAllCategory(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: CircularProgressIndicator(
                                  color: AppColor.gradientFirst),
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.done) {
                            final results = snapshot.data!;
                            return GridView.builder(
                              itemCount: results.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    MediaQuery.of(context).orientation ==
                                            Orientation.landscape
                                        ? 3
                                        : 2,
                                crossAxisSpacing: 40,
                                mainAxisSpacing: 50,
                                childAspectRatio: (1.5 / 1.0),
                              ),
                              itemBuilder: (
                                context,
                                index,
                              ) {
                                return InkWell(
                                  hoverColor: Colors.black,
                                  onLongPress: () async{
                                   await _confirmDialog(context, results[index].id,
                                        results[index].name);
                                        setState(() {});
                                  },
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EquipmentPage(
                                            equipmentCategory: results[index],
                                            categoryId: results[index].id),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        boxShadow: const <BoxShadow>[
                                          BoxShadow(
                                            color: Colors.black,
                                            blurRadius: 2.0,
                                          )
                                        ],
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColor.gradientFirst,
                                            AppColor.homePageTitle,
                                          ],
                                          begin: Alignment.bottomLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                6,
                                            padding:
                                                const EdgeInsets.only(bottom: 5),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      results[index].image),
                                                  fit: BoxFit.fill),
                                            ),
                                          ),
                                          Expanded(child: Container()),
                                          SizedBox(
                                            child: Center(
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                  ),
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Center(
                                                    child: Text(
                                                      results[index].name,
                                                      //'camera',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                        color: AppColor
                                                            .homePageContainerTextBig,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(child: Container()),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                  color: AppColor.gradientFirst),
                            );
                          }
                        }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _confirmDialog(
      BuildContext context, String userId, String categoryName) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Warning!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure want delete Category $categoryName ?'),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: AppColor.gradientFirst),
              child: const Text('Yes'),
              onPressed: () async {
                var res = await CategoryAPI().deleteCategory(userId);
                if (res.statusCode == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.green,
                      content:
                          Text("$categoryName Category successfully deleted")));
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(" Operation failed ! Something went wrong"),
                    ),
                  );
                }
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: AppColor.gradientFirst),
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
