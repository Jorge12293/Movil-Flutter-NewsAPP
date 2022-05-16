import 'package:appcrudflutter/src/news_provider/pages/tab1_page.dart';
import 'package:appcrudflutter/src/news_provider/pages/tab2_page.dart';
import 'package:appcrudflutter/src/news_provider/services/new_service.dart';
import 'package:appcrudflutter/src/news_provider/services/wifi_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatefulWidget {
  TabsPage({Key? key}) : super(key: key);

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> with TickerProviderStateMixin {
  String status ='Waiting...';
  late AnimationController _controller;

  @override
  void initState() { 
    _controller = AnimationController(
      duration: Duration(milliseconds: 1),
      vsync: this
    );
    super.initState();
    checkRealTimeConnection();
  }

    @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
/*
  void checkConnectivity() async{
    var connectionResult = await _connectivity.checkConnectivity();
    if(connectionResult == ConnectivityResult.mobile){
      status = "MobileData";
    }else if(connectionResult== ConnectivityResult.wifi){
      status = "Wifi";
    }else {
      status = "Not Connect";
    }
    //setState(() { });
  }
  */
  final Connectivity _connectivity = Connectivity();
  void checkRealTimeConnection(){
    // bool listenInternet = false;
    _connectivity.onConnectivityChanged.listen((event) {
    final wifiService = Provider.of<WifiService>(context,listen: false);
     // listenInternet = true;
      if(event == ConnectivityResult.mobile){
        wifiService.wifiProvider="MobileData";
        wifiService.wifiProviderBool=true;
        status = "MobileData";
      }else if(event == ConnectivityResult.wifi){
         wifiService.wifiProvider= "Wifi";
         wifiService.wifiProviderBool=true;
        status = "Wifi";
      }else {
        wifiService.wifiProvider= "Not Connect";
        wifiService.wifiProviderBool=false;
        status = "Not Connect";
      }
   // setState(() { });
   });
   /*
   if(!listenInternet){
     checkConnectivity();
   }
   */
}



  @override
  Widget build(BuildContext context) {
    final wifiService = Provider.of<WifiService>(context);
    final newsService = Provider.of<NewsService>(context);
    return Scaffold(
      appBar:AppBar(
        title:Text(newsService.textProvider),
      ),
      body:_Paginas(),
      bottomNavigationBar:_Navegacion(),
    );
  }
}

class _Navegacion extends StatelessWidget {


  const _Navegacion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
 final navegacionModel = Provider.of<NavegacionModel>(context);

    return BottomNavigationBar(
      currentIndex: navegacionModel.paginaActual,
      onTap: (i){
        navegacionModel.paginaActual=i;
      },
      items:const [
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Para ti'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.public),
          label: 'Encabezados'
        )
      ]
    );
  }
}

class _Paginas extends StatefulWidget {
  const _Paginas({
    Key? key,
  }) : super(key: key);

  @override
  State<_Paginas> createState() => _PaginasState();
}

class _PaginasState extends State<_Paginas> {
  
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<NavegacionModel>(context);

    return PageView(
       //Tabs
      //physics:const BouncingScrollPhysics(),
      controller: navegacionModel.pageController,
      physics:const NeverScrollableScrollPhysics(),
      children: const [
        Tab1Page(),
        Tab2Page()
      ],
    );
  }
}

class NavegacionModel with ChangeNotifier{
  int _paginaActual=0;
  final PageController _pageController = PageController();

 int get paginaActual => _paginaActual;
 set paginaActual(int valor){
   _paginaActual=valor;
   _pageController.animateToPage(
     valor,
     duration: const Duration(milliseconds: 250),
     curve: Curves.easeOut
   );
   notifyListeners();
 }

 PageController get pageController=> _pageController;

}