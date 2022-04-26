

import 'package:appcrudflutter/src/news_provider/models/category.dart';
import 'package:appcrudflutter/src/news_provider/models/news_models.dart';
import 'package:appcrudflutter/src/news_provider/services/new_service.dart';
import 'package:appcrudflutter/src/news_provider/services/wifi_service.dart';
import 'package:appcrudflutter/src/news_provider/widgets/lista_noticias.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  const Tab2Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    final wifiService = Provider.of<WifiService>(context);
    
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
             Container(
              height: 40,
              color: wifiService.wifiProviderBool
                    ?Colors.green
                    :Colors.red,
              child:  Center(child: Text(wifiService.wifiProvider))
            ),
             wifiService.wifiProviderBool 
             ?const _listaCategorias()
             :Container(),
            wifiService.wifiProviderBool
            ? Expanded(
                child: ListaNoticias(noticias: newsService.getArticlesSelected as List<Article>)
              )
            : const Center(
              child: Text('No hay Internet'),
            )
          ],
        ),
      )
    );
  }
}

class _listaCategorias extends StatelessWidget {
  const _listaCategorias({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final categories = Provider.of<NewsService>(context).categories;

    return SizedBox(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context,index){
         return Padding(
             padding: const EdgeInsets.all(8.0),
             child: Column(
               children: [
                 _categoryButton(category:categories[index]),
                 SizedBox(height: 5),
                 Text(categories[index].name.toUpperCase()),
               ],
             )
          );
        }
      ),
    );
  }
}

class _categoryButton extends StatelessWidget {
  final Category category;

  const _categoryButton({
    Key? key,
    required this.category,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final newServe = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: (){
        final newsService = Provider.of<NewsService>(context,listen: false);
        newsService.selectedCategory=category.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white
        ),
        child: Icon(
          category.icon,
          color:(newServe.selectedCategory == category.name)
          ? Colors.black54
          :Colors.blue,
        ),
      ),
    );
  }
}