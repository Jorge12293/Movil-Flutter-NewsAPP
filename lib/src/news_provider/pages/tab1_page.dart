import 'package:appcrudflutter/src/news_provider/services/new_service.dart';
import 'package:appcrudflutter/src/news_provider/services/wifi_service.dart';
import 'package:appcrudflutter/src/news_provider/widgets/lista_noticias.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Tab1Page extends StatefulWidget {
  const Tab1Page({Key? key}) : super(key: key);

  @override
  State<Tab1Page> createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    final wifiService = Provider.of<WifiService>(context);
    
    return SafeArea(
      child: Scaffold(
        body: (newsService.headLines.isEmpty)
        ? const Center(child: CircularProgressIndicator())
        :Column(
          children: [
            Container(
              height: 40,
              color: wifiService.wifiProviderBool
                    ?Colors.green
                    :Colors.red,
              child: Center(child: Text(wifiService.wifiProvider))
            ),
            wifiService.wifiProviderBool
            ? Expanded(child: ListaNoticias( noticias: newsService.headLines))
            :const Center(
              child: Text('No hay Internet'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}