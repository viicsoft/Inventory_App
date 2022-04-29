import 'package:flutter/material.dart';
import 'package:viicsoft_inventory_app/component/colors.dart';
import 'package:viicsoft_inventory_app/models/equipments.dart';
import 'package:viicsoft_inventory_app/ui/store/update_equipment.dart';

class EquipmentDetailPage extends StatefulWidget {
  final EquipmentElement equipmentElement;
  const EquipmentDetailPage({
    Key? key,
    required this.equipmentElement,
  }) : super(key: key);

  @override
  State<EquipmentDetailPage> createState() => _EquipmentDetailPageState();
}

class _EquipmentDetailPageState extends State<EquipmentDetailPage> {
  //XFile? _itemimage;
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 50, left: 10, right: 30),
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    size: 30,
                    color: AppColor.gradientSecond,
                  ),
                ),
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    widget.equipmentElement.equipmentName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                    ),
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 10, left: 10),
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: screenSize * 0.21,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                              image: NetworkImage(
                                  widget.equipmentElement.equipmentImage),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(height: screenSize * 0.08),
                        Row(
                          children: [
                            Text(
                              'Item name:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColor.homePageTitle,
                              ),
                            ),
                            Expanded(child: Container()),
                            Text(
                              widget.equipmentElement.equipmentName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: screenSize * 0.04),
                        Row(
                          children: [
                            Text(
                              'Condition:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColor.homePageTitle,
                              ),
                            ),
                            Expanded(child: Container()),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: colorscondition(
                                    widget.equipmentElement.equipmentCondition),
                              ),
                              padding: const EdgeInsets.all(5),
                              height: 25,
                              width: 60,
                              child: Center(
                                child: Text(
                                  widget.equipmentElement.equipmentCondition,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: AppColor.homePageContainerTextBig),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenSize * 0.04),
                        Row(
                          children: [
                            Text(
                              'Size:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColor.homePageTitle,
                              ),
                            ),
                            Expanded(child: Container()),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey[200],
                              ),
                              padding: const EdgeInsets.all(5),
                              height: 25,
                              width: MediaQuery.of(context).size.width / 3.5,
                              child: Center(
                                child: Text(
                                  widget.equipmentElement.equipmentSize,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenSize * 0.04),
                        Row(
                          children: [
                            Text(
                              'Barcode:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColor.homePageTitle,
                              ),
                            ),
                            Expanded(child: Container()),
                            Text(
                              widget.equipmentElement.equipmentBarcode!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: screenSize * 0.04),
                        Text(
                          'Description:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColor.homePageTitle,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          readOnly: true,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          initialValue:
                              widget.equipmentElement.equipmentDescription,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 25.0, horizontal: 10.0),
                            border: OutlineInputBorder(),
                            //labelText: 'Description',
                          ),
                        ),
                        SizedBox(height: screenSize * 0.1),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: AppColor.gradientFirst),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => UpdateEquipmentPage(
                                              barcode: widget.equipmentElement
                                                  .equipmentBarcode!,
                                              categoryId: widget
                                                  .equipmentElement
                                                  .equipmentCategoryId,
                                              condition: widget.equipmentElement
                                                  .equipmentCondition,
                                              description: widget
                                                  .equipmentElement
                                                  .equipmentDescription!,
                                              equipmentName: widget
                                                  .equipmentElement
                                                  .equipmentName,
                                              image: widget.equipmentElement
                                                  .equipmentImage,
                                              size: widget.equipmentElement
                                                  .equipmentSize,
                                              id: widget.equipmentElement.id,
                                            )));
                              },
                              child: const Text(
                                'Edit',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
