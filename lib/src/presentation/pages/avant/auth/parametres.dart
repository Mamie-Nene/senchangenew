
import 'package:flutter/material.dart';
import 'package:senchange/src/presentation/widgets/app_app_bars.dart';

import '/src/data/remote/security/security_api.dart';
import '/src/methods/logout_methods.dart';
import '/src/methods/storage_management.dart';

import '/src/utils/api/api_url.dart';
import '/src/utils/consts/routes/app_routes_name.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';
import '/src/presentation/widgets/custom_elavated_button.dart';


class Parametres extends StatefulWidget {
  const Parametres({super.key});

  @override
  State<Parametres> createState() => _ParametresState();
}

class _ParametresState extends State<Parametres> {

  bool isAuthTwoFactorActive = true;
  bool isPushActive = true;
  bool isPasswordRotationActive = true;
  final Uri whatsappWebUrl = Uri.parse(ApiUrl().downloadAppUrl);

  String firstname = "__";
  String lastname = "__";
  String email = "__";
  

  getUserInfos() async {
    var prenom = await StorageManagement.getStorage("prenom");
    var nom = await StorageManagement.getStorage("nom");
    var emailOrUserName = await StorageManagement.getStorage("email");

    if (prenom != null) {
      setState(() {
        firstname = prenom;
      });
    }
    if (nom != null) {
      setState(() {
        lastname = nom;
      });
    }
   if (emailOrUserName != null) {
      setState(() {
        email = emailOrUserName;
      });
    }
  }

  @override
  void initState() {
    getUserInfos();
    super.initState();

  }

 deleteCompteBottomSheet(BuildContext context){
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true, // Permet de contrôler la hauteur
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.5, // 50% de l'écran
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return  Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(AppText.DELETE_COMPTE_TEXT,
                    softWrap: true,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: AppDimensions.h20(context)),
                  CustomElevatedButton(
                    label: "Oui",
                    color: AppColors.rougeColor,
                    action: () {
                      SecurityApi().desactivateAccount(context);
                    },
                    textColor: Colors.white,
                  ),
                  SizedBox(height: AppDimensions.h15(context)),
                  CustomElevatedButton(
                    label: "Non",
                    color: AppColors.textGrisSecondColor,
                    action: () {
                      Navigator.pop(context);
                    },
                    textColor: AppColors.textGrisColor,
                  ),
                ],
              ),
            ),
        );
      },
    );
 }

  @override
  Widget build(BuildContext context) {
    List<String> appRoutes= [AppRoutesName.securityPage,AppRoutesName.supportPage,AppRoutesName.sharePage,AppRoutesName.followUsPage,AppRoutesName.infoJuridiquePage];
    List<String> titles= ["Sécurité","Aide & Support","Partager","Nous suivre","Infos juridiques"];
    List<IconData> icons= [Icons.security,Icons.help_center,Icons.share,Icons.group,Icons.info_sharp];

    return Scaffold(
      backgroundColor: AppColors.bgColor,

      bottomNavigationBar: Text(AppText.APP_VERSION,
        textAlign: TextAlign.center,
        style: TextStyle(color: AppColors.grisClair, fontSize: AppDimensions().responsiveFont(context,16)),
      ),

      appBar: AppAppBars(title: "Paramètres",action:() {Navigator.of(context).pushNamed(AppRoutesName.accueilPage);} ,),

      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Text("$firstname $lastname",
                  style:  TextStyle(fontSize: AppDimensions().responsiveFont(context,18), fontWeight: FontWeight.bold),
                ),
                Text(email),
                SizedBox(height: AppDimensions.h15(context)),
                GestureDetector(
                  onTap: () {Navigator.of(context).pushNamed(AppRoutesName.updateProfilPage);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.orangeColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Modifier mon profil',
                        style: TextStyle(fontSize: AppDimensions().responsiveFont(context,16)),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: AppDimensions.h25(context)),
                Container(
                  height: AppDimensions.h300(context),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView.builder(
                    itemCount: titles.length,
                    itemBuilder: (context,int index){
                      return showParametre(context,appRoutes[index],titles[index],icons[index]);
                      },
                  )
                ),

                SizedBox(height: AppDimensions.h20(context)),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // dialog de confirmation
                          deconnexionBottomSheet(context,() {LogoutMethods.logout(context);},);

                        },
                        child: ListTile(
                          title: Text(
                            "Me déconnecter",
                            style: TextStyle(
                              fontSize: AppDimensions().responsiveFont(context,16),
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          leading: Icon(Icons.logout, color: Colors.red),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.red,
                          ),
                        ),
                      ),

                      ListTile(
                        title: Text(
                          "Supprimer mon compte",
                          style: TextStyle(
                            fontSize: AppDimensions().responsiveFont(context,16),
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        leading: Icon(Icons.delete, color: Colors.red),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.red,
                        ),
                        onTap: () {
                          // modal de confirmation
                          deleteCompteBottomSheet(context);
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: AppDimensions.h15(context)),

              ],
            ),
          ),
        ),
      ),
    );
  }

  deconnexionBottomSheet(BuildContext context,VoidCallback logoutAction){
    return   showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true, // Permet de contrôler la hauteur
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.3, // 50% de l'écran
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(AppText.DECONNEXION_ALERT_TEXT,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: AppDimensions().responsiveFont(context,18),
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: AppDimensions.h20(context)),

                CustomElevatedButton(
                  label: "Oui",
                  color: AppColors.rougeColor,
                  action: logoutAction,
                  textColor: Colors.white,
                ),

                SizedBox(height: AppDimensions.h15(context)),

                CustomElevatedButton(
                  label: "Non",
                  color: AppColors.textGrisSecondColor,
                  action: () {
                    Navigator.pop(context);
                  },
                  textColor: AppColors.textGrisColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  showParametre(BuildContext context, String appRoute, String title, IconData icon){
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(appRoute);
      },
      child: ListTile(
        title:  Text(
          title,
          style: TextStyle(
            fontSize: AppDimensions().responsiveFont(context,16),
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Icon(icon, color: AppColors.orangeColor),
        trailing: Icon(Icons.arrow_forward_ios, color: AppColors.orangeColor,),
      ),
    );

  }
}