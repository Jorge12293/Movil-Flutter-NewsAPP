


import 'package:appcrudflutter/src/news_provider/pages/tabs_page.dart';
import 'package:appcrudflutter/src/news_provider/services/new_service.dart';
import 'package:appcrudflutter/src/news_provider/services/wifi_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class MultipleProviders {

  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_)=>NavegacionModel()),
    ChangeNotifierProvider(create: (_)=>NewsService()),
    ChangeNotifierProvider(create: (_)=>WifiService()), 
  ];

}
