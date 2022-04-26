import 'package:appcrudflutter/src/news_provider/models/news_models.dart';
import 'package:appcrudflutter/src/news_provider/theme/theme.dart';
import 'package:flutter/material.dart';

class ListaNoticias extends StatelessWidget {
  final List<Article> noticias;
   ListaNoticias({required this.noticias});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: noticias.length,
      itemBuilder: (context,index){
        return _Noticia(
          noticia: noticias[index], 
          index: index
        );
      }
    );
  }
}

class _Noticia extends StatelessWidget {
  final Article noticia;
  final int index;
  const _Noticia({required this.noticia,required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TarjetaTobAR(noticia: noticia,index: index),
        _TarjetTitulo(noticia: noticia),
        _TarjetaImagen(noticia: noticia),
        _TarjetaBody(noticia: noticia),
        _TarjetaBotones(),
        const SizedBox(height: 10),
        const Divider()
      ],
    );
  }
}

class _TarjetaBotones extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:<Widget> [
        RawMaterialButton(
          onPressed: (){},
          fillColor: miTema.accentColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Icon(Icons.star_border),
        ),
        SizedBox(width: 10),
        RawMaterialButton(
          onPressed: (){},
          fillColor: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Icon(Icons.more),
        ) 
      ],
    );
  }
}


class _TarjetaTobAR extends StatelessWidget {
  final Article noticia;
  final int index;
  const _TarjetaTobAR({
    required this.noticia,
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text('${index+1}',style: TextStyle(color: miTema.accentColor)),
          SizedBox(width: 10),
          Text('${noticia.source.name}',style: TextStyle(color:Colors.white)),
        ],
      ),
    );
  }
}

class _TarjetTitulo extends StatelessWidget {
  final Article noticia;
  const _TarjetTitulo({Key? key, required this.noticia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(noticia.title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
    );
  }
}

class _TarjetaImagen extends StatelessWidget {
  final Article noticia;
  const _TarjetaImagen({Key? key, required this.noticia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50),bottomRight: Radius.circular(50)),
        child: Container(
          child: (noticia.urlToImage != null)
          ?FadeInImage(
              placeholder:const AssetImage('assets/img/giphy.gif') ,
              image: NetworkImage(noticia.urlToImage,scale: 1.0),
            fit:BoxFit.cover ,
           ) 
          :Image(image: AssetImage('assets/img/no-image.png')) 
        ),
      ),
    );
  }
}

class _TarjetaBody extends StatelessWidget {
  final Article noticia;
  const _TarjetaBody({Key? key, required this.noticia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(noticia.description),
    );
  }
}