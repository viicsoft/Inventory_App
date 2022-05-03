import 'package:flutter/material.dart';
import 'package:viicsoft_inventory_app/component/colors.dart';
import 'package:viicsoft_inventory_app/models/category.dart';
import 'package:viicsoft_inventory_app/models/equipments.dart';
import 'package:viicsoft_inventory_app/services/apis/category_api.dart';
import 'package:viicsoft_inventory_app/services/apis/equipment_api.dart';

// ignore: must_be_immutable
class FairEquipmentPage extends StatefulWidget {
  const FairEquipmentPage({Key? key}) : super(key: key);

  @override
  State<FairEquipmentPage> createState() => _FairEquipmentPageState();
}

class _FairEquipmentPageState extends State<FairEquipmentPage> {
  EquipmentCategory? selectedCategory;
  final CategoryAPI _categoryApi = CategoryAPI();
  late Future<List<EquipmentCategory>> _category;
  late Future equipmentFuture;
  List selectedEquipment = [];

  @override
  void initState() {
    super.initState();
    _category = _categoryApi.fetchAllCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.homePageBackground,
      body: FutureBuilder<List<EquipmentCategory>>(
          future: _category,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                final category = snapshot.data;
                if (category != null) {
                  return Container(
                    padding: const EdgeInsets.only(top: 60),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios_new,
                                size: 25,
                              ),
                            ),
                            Expanded(child: Container()),
                            Text(
                              'Fair Equipments',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: AppColor.homePageTitle,
                              ),
                            ),
                            const SizedBox(width: 50),
                            Expanded(child: Container()),
                          ],
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.15),
                        Container(
                          color: Colors.grey[200],
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 25),
                          height: MediaQuery.of(context).size.width * 0.3,
                          child: Column(
                            children: [
                              DropdownButton<EquipmentCategory>(
                                isExpanded: true,
                                value: selectedCategory ?? category[0],
                                elevation: 16,
                                style: TextStyle(color: Colors.grey[600]),
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedCategory = newValue!;
                                  });
                                },
                                items: category.map((EquipmentCategory value) {
                                  return DropdownMenuItem<EquipmentCategory>(
                                    value: value,
                                    child: Text(
                                      value.name,
                                      style: TextStyle(
                                          color: AppColor.gradientFirst,
                                          fontSize: 22),
                                    ),
                                  );
                                }).toList(),
                              ),
                              const Center(
                                child: Text(
                                    'Select category to display equipment'),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: FutureBuilder<List<EquipmentElement>>(
                              future: EquipmentAPI().fetchAllEquipments(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  if (selectedCategory == null) {
                                    final results = snapshot.data!;
                                    var result = results
                                        .where((item) =>
                                            item.equipmentCondition == 'FAIR')
                                        .toList();
                                    return SizedBox(
                                      child: ListView.builder(
                                        itemCount: result.length,
                                        itemBuilder: (_, int index) {
                                          return equipmentCard(
                                              result, index, context);
                                        },
                                      ),
                                    );
                                  } else {
                                    final results = snapshot.data!;
                                    var newResult = results
                                        .where((item) =>
                                            item.equipmentCondition == 'FAIR')
                                        .toList();
                                    var result = newResult
                                        .where((item) => selectedCategory!.id
                                            .contains(item.equipmentCategoryId))
                                        .toList();
                                    return ListView.builder(
                                      itemCount: result.length,
                                      itemBuilder: (_, int index) {
                                        return equipmentCard(
                                            result, index, context);
                                      },
                                    );
                                  }
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(
                                        color: AppColor.gradientFirst),
                                  );
                                }
                              }),
                        )
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                        color: AppColor.gradientFirst),
                  );
                }
              }
            }
            return Center(
              child: CircularProgressIndicator(color: AppColor.gradientFirst),
            );
          }),
    );
  }

  Padding equipmentCard(
      List<EquipmentElement> result, int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5, left: 5),
      child: Container(
        height: 85,
        padding: const EdgeInsets.only(bottom: 2, right: 3),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 3,
          shadowColor: AppColor.gradientSecond,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 3,
              left: 3,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 60,
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(result[index].equipmentImage),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  result[index].equipmentName,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: AppColor.homePageTitle,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                Expanded(child: Container()),
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: colorscondition(
                                          result[index].equipmentCondition)),
                                  padding: const EdgeInsets.all(5),
                                  height: 17,
                                  child: Text(
                                    result[index].equipmentCondition,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 8,
                                        color:
                                            AppColor.homePageContainerTextBig),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              result[index].equipmentDescription!,
                              maxLines: 2,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color colorscondition(String conditionresult) {
    if (conditionresult == 'NEW') {
      return Colors.green;
    } else if (conditionresult == 'OLD') {
      return Colors.lime[900]!;
    } else if (conditionresult == 'FAIR') {
      return Colors.greenAccent;
    } else {
      return Colors.red;
    }
  }
}
