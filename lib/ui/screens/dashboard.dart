
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/models/map_model.dart';
import '../../core/providers/auth_provider.dart';
import '../../core/providers/radio_provider.dart';
import '../../core/routing/routes.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/map_utils.dart';
import '../views/favorite_stations.dart';
import '../views/map_view.dart';
import '../views/radio_list_view.dart';
import '../widgets/custom_audio_player.dart';
import '../widgets/custom_button.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  Widget? radioView;

  var radioProvider;

  @override
  void initState() {
    super.initState();

    MapModel map = MapUtils.getMapInfo("world");

    radioView ??= MainMapView(
        map: map,
        onCountryTap: _onCountryTap,
      );
  }


  @override
  Widget build(BuildContext context) {
    final radioProvider = Provider.of<RadioProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 350,
                  height: MediaQuery.of(context).size.height * 0.925,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      right: BorderSide(
                        color: AppColors.mainBlueDark,
                        width: 3,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      Text(
                        'World Tunes',
                        style: TextStyle(
                          fontSize: 40,
                          color: AppColors.mainBlueDark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Select a country to listen to its radio stations',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.mainBlueDark,
                        ),
                      ),
                      const SizedBox(height: 40),
                      CustomButton(
                        width: 200,
                        height: 41,
                        onPressed: () {
                          setState(() {
                            radioView = MainMapView(
                              map: MapUtils.getMapInfo("world"),
                              onCountryTap: _onCountryTap,
                            );
                          });
                        },
                        primaryColor: AppColors.mainBlueDark,
                        hoverColor: AppColors.mainBlueDark.withOpacity(0.75),
                        text: const Text(
                          "Home",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      CustomButton(
                        width: 200,
                        height: 41,
                        onPressed: () {
                          setState(() {
                            radioView = FavoriteRadios();
                          });
                        },
                        primaryColor: AppColors.mainBlueDark,
                        hoverColor: AppColors.mainBlueDark.withOpacity(0.75),
                        text: const Text(
                          "Favorites",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Divider(
                        color: AppColors.mainBlueDark.withOpacity(0.5),
                        thickness: 1,
                      ),
                      const SizedBox(height: 24),
                      InkWell(
                        onTap: () async {
                          await authProvider.logout(context);
                          Future.microtask(() => context.go(Routes.login));
                        },
                        child: Text(
                          "Logout",
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColors.mainBlueDark,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        "Made with ❤️ by Sento",
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.mainBlueDark,
                        ),
                      ),
                    ]
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 350,
                  height: MediaQuery.of(context).size.height * 0.925,
                  child: radioView,
                ),
              ],
            ),
            BottomPlayBar(
              radioProvider: radioProvider,
            ),
          ],
        ),
      ),
    );
  }

  void _onCountryTap(String id) {

    MapModel map = MapUtils.getMapInfo(id);

    if(map.name != "") {
      setState(() {
        radioView = RadioListView(
          map: map,
          radioProvider: Provider.of<RadioProvider>(context, listen: false),
        );
      });
    }

  }
}
