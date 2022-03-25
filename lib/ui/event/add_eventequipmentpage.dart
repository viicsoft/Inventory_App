import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viicsoft_inventory_app/component/colors.dart';
import 'package:viicsoft_inventory_app/models/category.dart';
import 'package:viicsoft_inventory_app/models/equipments.dart';
import 'package:viicsoft_inventory_app/models/events.dart';
import 'package:viicsoft_inventory_app/services/apis/category_api.dart';
import 'package:viicsoft_inventory_app/services/apis/equipment_api.dart';
import 'package:viicsoft_inventory_app/services/apis/event_api.dart';
import 'package:viicsoft_inventory_app/ui/store/equipment_detail_page.dart';

// ignore: must_be_immutable
class AddEventEquipmentPage extends StatefulWidget {
  String eventId;
 String eventName;
  AddEventEquipmentPage({Key? key, required this.eventId, required this.eventName}) : super(key: key);

  @override
  State<AddEventEquipmentPage> createState() => _AddEventEquipmentPageState();
}

class _AddEventEquipmentPageState extends State<AddEventEquipmentPage> {
  EquipmentCategory? selectedCategory;
  final CategoryAPI _categoryApi = CategoryAPI();
  final EquipmentAPI _equipmentAPI = EquipmentAPI();
  late Future<List<EquipmentElement>> _equipmentsList;
  late Future<List<EquipmentCategory>> _category;
  late Future equipmentFuture;
  int? selectedIndex;
  List selectedEquipment = [];

  @override
  void initState() {
    super.initState();
    _equipmentsList = _equipmentAPI.fetchAllEquipments();
    _category = _categoryApi.fetchAllCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.homePageBackground,
      body: FutureBuilder<List<EquipmentCategory>>(
          future: _category,
          builder: (context, snapshot) {
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
                           widget.eventName,
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
                    SizedBox(width: MediaQuery.of(context).size.width * 0.15),
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
                            child: Text('Select category to display equipment'),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: FutureBuilder<List<EquipmentElement>>(
                          future: _equipmentsList,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (selectedCategory == null) {
                                return SizedBox(child: Container());
                              } else {
                                final results = snapshot.data!;
                                var result = results
                                    .where((item) =>
                                        item.equipmentCategoryId ==
                                        selectedCategory!.id)
                                    .toList();
                                return ListView.builder(
                                  itemCount: result.length,
                                  itemBuilder: (_, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, left: 10),
                                      child: Container(
                                        height: 120,
                                        padding: const EdgeInsets.only(
                                            bottom: 5, right: 5),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          elevation: 3,
                                          shadowColor: AppColor.gradientSecond,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              top: 5,
                                              left: 5,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width: 75,
                                                          height: 90,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            image:
                                                                DecorationImage(
                                                              image: NetworkImage(
                                                                  result[index]
                                                                      .equipmentImage),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  result[index]
                                                                      .equipmentName,
                                                                  maxLines: 2,
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .homePageTitle,
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              5),
                                                                          color:
                                                                              colorscondition(result[index].equipmentCondition)),
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              5),
                                                                      height:
                                                                          18,
                                                                      child:
                                                                          Text(
                                                                        result[index]
                                                                            .equipmentCondition,
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            fontSize:
                                                                                8,
                                                                            color:
                                                                                AppColor.homePageContainerTextBig),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                        child:
                                                                            Container()),
                                                                    IconButton(
                                                                        onPressed:
                                                                            () async {
                                                                              var res = await EventAPI().addEventEquipment(widget.eventId, result[index].id);
                                                                          if (res.statusCode ==200 &&  selectedEquipment.contains(result[index].id)) {
                                                                            
                                                                            setState(() {
                                                                              selectedEquipment.remove(result[index].id);
                                                                            });   
                                                                          }else{
                                                                            //await EventAPI().deleteEventEquipment(id);
                                                                            setState(() {
                                                                              selectedEquipment.add(result[index].id);
                                                                            });
                                                                          }

                                                                          // if (selectedEquipment.contains(result[index].id)) {
                                                                          //   setState(() {
                                                                          //     selectedEquipment.remove(result[index].id);
                                                                          //   });   
                                                                          // }else{
                                                                          //   setState(() {
                                                                          //     selectedEquipment.add(result[index].id);
                                                                          //   });
                                                                          // }

                                                                        },
                                                                        icon: selectedEquipment.contains(result[index].id)
                                                                        //selectedIndex ==index
                                                                            ? const Icon(Icons.check_box_outlined,
                                                                                color: Colors.green)
                                                                            : const Icon(Icons.cancel_presentation, color: Colors.red)),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            child: Text(
                                                              result[index]
                                                                      .equipmentDescription!
                                                                      .isEmpty
                                                                  ? 'No description'
                                                                  : result[
                                                                          index]
                                                                      .equipmentDescription!,
                                                              maxLines: 2,
                                                              style: const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
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
                child: CircularProgressIndicator(color: AppColor.gradientFirst),
              );
            }
          }),
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
