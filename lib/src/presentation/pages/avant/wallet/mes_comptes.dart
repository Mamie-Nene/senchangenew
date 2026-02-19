import 'package:flutter/material.dart';
import '/src/utils/consts/routes/app_routes_name.dart';
import '/src/presentation/widgets/main_button.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

SampleItem? selectedItem;

class MesComptesPage extends StatefulWidget {
  const MesComptesPage({super.key});

  @override
  State<MesComptesPage> createState() => _MesComptesPageState();
}

class _MesComptesPageState extends State<MesComptesPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(title: Text("Mes comptes mobile money"), backgroundColor: AppColors.bgColor,),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: (){Navigator.of(context).pushNamed(AppRoutesName.addMobileMoneyAccountPage);},
                child: MainButton(
                  backgroundColor: AppColors.orangeColor,
                  label: "Ajouter un compte",
                ),
              ),
              SizedBox(height: AppDimensions.h40(context)),
              Text(
                "Mes comptes",
                style: TextStyle(fontSize: AppDimensions().responsiveFont(context,18), fontWeight: FontWeight.bold),
              ),
              SizedBox(height: AppDimensions.h10(context)),
              Expanded(
                child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (BuildContext context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 15,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      color: Color(0xFFFF2F3F4),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        // child: Icon(Icons.account_balance_wallet,color: AppColors.textGrisColor,),
                                        child: Image.asset(AppImages.WAVE_ICON, width: 24, height: 24,),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Wave",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: AppDimensions().responsiveFont(context,16),
                                        ),
                                      ),
                                      SizedBox(height: AppDimensions.h5(context)),
                                      Text(
                                        "77 092 36 27",
                                        style: TextStyle(
                                         color: AppColors.grisClair,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              // IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz))
                              PopupMenuButton<SampleItem>(
                                color: Colors.white,
                                initialValue: selectedItem,
                                onSelected: (SampleItem item) {
                                  setState(() {
                                    selectedItem = item;
                                  });
                                },
                                itemBuilder:
                                    (BuildContext context) =>
                                        <PopupMenuEntry<SampleItem>>[
                                           const PopupMenuItem<SampleItem>(
                                            value: SampleItem.itemOne,
                                            child: Text('Voir les détails'),
                                          ),
                                          const PopupMenuItem<SampleItem>(
                                            value: SampleItem.itemTwo,
                                            child: Text('Supprimer'),
                                          ),
                                        ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}