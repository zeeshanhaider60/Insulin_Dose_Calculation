import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:insulin_dose_calculation/Controllers/insulinDosePageController.dart';
import 'package:insulin_dose_calculation/Controllers/mealDoseCalulationPageController.dart';

class mealDoseCalculationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mealdosecalculationpagecontroller =
        Provider.of<mealDoseCalculationPageController>(context, listen: false);
    final insulindosepagecontroller =
        Provider.of<insulinDosePageController>(context, listen: false);

    mealdosecalculationpagecontroller.isf = insulindosepagecontroller.isf;
    mealdosecalculationpagecontroller.icr = insulindosepagecontroller.icr;

    return Scaffold(
      appBar: AppBar(
        title: Text("Meal Dose Calculation"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: mealdosecalculationpagecontroller.form_key,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Meal & Correction Dose Calculation',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
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
                  controller: mealdosecalculationpagecontroller
                      .currentbloodsugarcontroller,
                  decoration: InputDecoration(
                    labelText: 'Enter Your Current Blood Sugar',
                    hintText: 'Current blood sugar level',
                    prefixIcon: Icon(Icons.bloodtype),
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
                  controller: mealdosecalculationpagecontroller
                      .targetbloodsugarcontroller,
                  decoration: InputDecoration(
                    labelText: 'Enter Your Target Blood Sugar',
                    hintText: 'Target blood sugar',
                    prefixIcon: Icon(Icons.bloodtype),
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
                  controller:
                      mealdosecalculationpagecontroller.noofcarbscontroller,
                  decoration: InputDecoration(
                    labelText: 'Enter No. of Carbs of Your Meal',
                    hintText: 'No. of carbs of your meal',
                    prefixIcon: Icon(Icons.food_bank),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 45,
                  width: 250,
                  child: ElevatedButton(
                      onPressed: () {
                        mealdosecalculationpagecontroller
                            .correctiondosecalculation();
                        mealdosecalculationpagecontroller.mealdosecalculation();
                        mealdosecalculationpagecontroller
                            .mealcorrectiondosecalculation();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text('Calculate Dose',
                          style: TextStyle(fontSize: 17))),
                ),
                SizedBox(
                  height: 15,
                ),
                Card(
                    elevation: 10.0,
                    shadowColor: Colors.blue.withOpacity(0.9),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Consumer<mealDoseCalculationPageController>(
                            builder: (context, value, child) {
                              return Text(
                                "Meal Dose: ${value.mealdose.toStringAsFixed(1)} units",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              );
                            },
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Consumer<mealDoseCalculationPageController>(
                              builder: (context, value, child) {
                            return Text(
                              "Correction Dose: ${value.correctiondose.toStringAsFixed(1)} units",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            );
                          }),
                          SizedBox(
                            height: 8,
                          ),
                          Consumer<mealDoseCalculationPageController>(
                              builder: (context, value, child) {
                            return Text(
                              "Total Dose: ${value.mealcorrectiondose.toStringAsFixed(1)} units",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            );
                          }),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
