import 'package:fluttertoast/fluttertoast.dart';
import 'package:insulin_dose_calculation/mealDosePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:insulin_dose_calculation/Controllers/insulinDosePageController.dart';

class insulinDosePage extends StatelessWidget {
  insulinDosePage({Key? key}) : super(key: key);

  List<String> insulintypes = [
    'Select Insulin Type',
    'Regular Insulin',
    'Rapid Acting Insulin'
  ];

  @override
  Widget build(BuildContext context) {
    final insulindosepagecontroller =
        Provider.of<insulinDosePageController>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: insulindosepagecontroller.form_key,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 90,
                ),
                Text(
                  'Insulin Dose Calculation',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                SizedBox(
                  height: 30,
                ),
                Consumer<insulinDosePageController>(
                  builder: (context, controller, child) {
                    return DropdownButton<String>(
                      iconEnabledColor: Colors.black,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                      value: controller.selectedinsulintype.isNotEmpty
                          ? controller.selectedinsulintype
                          : insulintypes.first,
                      items: insulintypes
                          .map((item) => DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              ))
                          .toList(),
                      onChanged: (String? newValue) {
                        controller.setselectedinsulintype(newValue!);
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                  controller: insulindosepagecontroller.bolusInsulin,
                  decoration: InputDecoration(
                    labelText: 'Enter Your Total Bolus Insulin Dose',
                    hintText: 'Short/Rapid Acting Insulin',
                    prefixIcon: Icon(Icons.medical_services),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                  controller: insulindosepagecontroller.basalInsulin,
                  decoration: InputDecoration(
                    labelText: 'Enter Your Total Basal Insulin Dose',
                    hintText: 'Long Acting Insulin',
                    prefixIcon: Icon(Icons.medical_services),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: 300,
                  height: 45,
                  child: ElevatedButton(
                      onPressed: () {
                        insulindosepagecontroller.calculateisf();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text('Calculate ISF(Insulin Sensitivity Factor)',
                          style: TextStyle(fontSize: 15))),
                ),
                SizedBox(
                  height: 10,
                ),
                Consumer<insulinDosePageController>(
                    builder: (context, value, child) {
                  return Text(
                    "${value.isf.toStringAsFixed(0)} mg/dl",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  );
                }),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 300,
                  height: 45,
                  child: ElevatedButton(
                      onPressed: () {
                        insulindosepagecontroller.calculateicr();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text('Calculate ICR(Insulin to Carb Ratio)',
                          style: TextStyle(fontSize: 15))),
                ),
                SizedBox(
                  height: 10,
                ),
                Consumer<insulinDosePageController>(
                    builder: (context, value, child) {
                  return Text(
                    "${value.icr.toStringAsFixed(0)} gram",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  );
                }),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 300,
                  height: 45,
                  child: ElevatedButton(
                      onPressed: () {
                        if (insulindosepagecontroller.isf.toString() != "0.0" &&
                            insulindosepagecontroller.icr.toString() != "0.0") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => mealDoseCalculationPage(),
                              ));
                          print("${insulindosepagecontroller.isf.toString()}");
                          print("${insulindosepagecontroller.icr.toString()}");
                        } else {
                          Fluttertoast.showToast(
                              msg: 'Please first calculate your ISF & ICR');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text('Meal & Correction Dose Calculation',
                          style: TextStyle(fontSize: 15))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
