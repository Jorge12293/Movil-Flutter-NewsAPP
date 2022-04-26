

import 'package:appcrudflutter/src/news_provider/models/category.dart';
import 'package:appcrudflutter/src/news_provider/models/news_models.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



final _URL_NEWS = 'https://newsapi.org/v2';
final _APIKEY ='613b9f3335ba4e6d88cc7393e5d4ace5';

class NewsService with ChangeNotifier{

  String _textProvider = '';
  
  String get textProvider => _textProvider;
  set textProvider(String value){
    _textProvider=value;
    notifyListeners();
  }



  NewsService(){
    this.getTopHeadLines();

    categories.forEach((item) {
     categoriesArticle[item.name] = [];
    });


  }

  Map<String,List<Article>> categoriesArticle={};
  bool loadData=false;

  List<Article> headLines = [];
  String _selectedCategory ='business';

  String get selectedCategory => _selectedCategory;

  set selectedCategory(String value){
    _selectedCategory=value;
    getArticlesByCategory(value);
    notifyListeners();
  }

  List<Article>? get getArticlesSelected => categoriesArticle[selectedCategory];

  getArticlesByCategory(String category)async{

    if(categoriesArticle[category]!.isNotEmpty){
      return categoriesArticle[category];
    }

    final url ='$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=us&category=$category';
    print(url);
    var urlParse =Uri.parse(url);
   
    final resp = await http.get(urlParse);
    final newsResponse= newsResponseFromJson(resp.body);
    categoriesArticle[category]!.addAll(newsResponse.articles);
    notifyListeners();
  }


  List<Category> categories =[
    Category(icon:FontAwesomeIcons.building,name: 'business'),
    Category(icon:FontAwesomeIcons.tv,name: 'entertainment'),
    Category(icon:FontAwesomeIcons.addressCard,name: 'general'),
    Category(icon:FontAwesomeIcons.headSideVirus,name: 'health'),
    Category(icon:FontAwesomeIcons.vials,name: 'science'),
    Category(icon:FontAwesomeIcons.volleyball,name: 'sports'),
    Category(icon:FontAwesomeIcons.memory,name: 'technology')
  ]; 



  getTopHeadLines() async{
    final url ='$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=us';
    print('Cargando Headlines Inicia');
    var urlParse =Uri.parse(url);
    loadData=true;
    medirTiempo();
    final resp = await http.get(urlParse);
    final newsResponse= newsResponseFromJson(resp.body);
    headLines.addAll(newsResponse.articles);
    notifyListeners();
    print(newsResponse.toJson());
    print('Cargando Headlines finaliza');
    loadData=false;
  }

void medirTiempo() async{
   int cont=0;
  //while (loadData) {
  while (cont<20) {
    int limit=10;
    cont++;
    await Future.delayed(const Duration(seconds: 2), (){});
    
    _textProvider = 'paso ${cont} segundo';

    print('paso ${cont} segundo');
    notifyListeners();
    if(cont==limit){
      _textProvider = 'paso ${cont} segundo baja cobertura de internet';
      await Future.delayed(const Duration(seconds: 4), (){});
      print('Paso 10 segundos');
      limit=limit+10;
    }
  } 
 }


}