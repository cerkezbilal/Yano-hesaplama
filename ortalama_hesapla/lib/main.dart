import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dersAdi;
  int dersKredi = 1;
  double dersHarfDegeri = 4;
  List<Ders> tumDersler;
  var formKey = GlobalKey<FormState>();
  double ortalama = 0;
  static int sayac =0;
  TextEditingController textEditingController;//Ben Ekledim



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tumDersler = [];

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Ortalama Hesapla"),
      ),
      floatingActionButton: FloatingActionButton(




        onPressed: () {


          if (formKey.currentState.validate()) {
            formKey.currentState.save();



          }
        },
        child: Icon(Icons.add),
      ),
      body: OrientationBuilder(builder: (context,orientation){

        if(orientation==Orientation.portrait){
          return uygulamaGovdesi();
        }else{
          return uygulamaGovdesiLanscape();
        }



        }
        ),
    );
  }

  Widget uygulamaGovdesi( ) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //STATİC FORMU TUTAN CONTAİNER
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            //color: Colors.pink.shade200,
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: textEditingController,//Ben ekledim
                    decoration: InputDecoration(
                      labelText: "Ders Adı",
                      hintText: "Ders adını giriniz",
                      hintStyle: TextStyle(fontSize: 20),
                      labelStyle: TextStyle(fontSize: 20),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal, width: 2),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Colors.purple, width: 2)),
                    ),
                    validator: (girilenDeger) {
                      if (girilenDeger.length > 0) {
                        return null;
                      } else {
                        return "Ders adı boş olamaz";
                      }
                    },
                    onSaved: (kaydedilecekDeger) {
                      dersAdi = kaydedilecekDeger;
                      setState(() {
                        tumDersler.add(Ders(dersAdi, dersHarfDegeri,
                          dersKredi,rastgeleRenkOlustur()));
                        ortalama=0;
                        ortalamayiHesapla();
                        textEditingController = new TextEditingController
                          (text:"");//Ben Ekledim



                        
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            items: dersKrediItems(),
                            value: dersKredi,
                            onChanged: (secilenKredi) {
                              setState(() {
                                dersKredi = secilenKredi;
                              });
                            },
                          ),
                        ),
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green, width: 2),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<double>(
                            items: dersHarfDegerleriItems(),
                            value: dersHarfDegeri,
                            onChanged: (secilenHarf) {
                              setState(() {
                                dersHarfDegeri = secilenHarf;
                              });
                            },
                          ),
                        ),
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue, width: 2),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Container(

            height: 70,
            margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.teal.shade200,
              border: BorderDirectional(
                top: BorderSide(color: Colors.blue, width: 2),
                bottom: BorderSide(color: Colors.blue, width: 2),
              ),
            ),
            child: Center(child: RichText(
            textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(text: tumDersler.length==0?"Lütfen Ders "
                      "Ekleyiniz!! ":
                      "Ortalama: ",style: tumDersler.length==0?
                  TextStyle
                    (color: Colors
                      .black,fontWeight: FontWeight.bold,fontSize: 24): TextStyle
                    (color: Colors
                      .grey.shade700,fontSize: 24)),
                  TextSpan(text: tumDersler.length==0?"":"${ortalama
                      .toStringAsFixed(2)}",
    style:
    TextStyle(color:
                  Colors
                      .black,fontSize: 24,fontWeight: FontWeight.bold)),
                ]
              ),

            ),
            ),
          ),

          //DİNAMİK LİSTEYİ TUTAN CONTAİNER

          Expanded(
            child: Container(

              child: ListView.builder(
                itemBuilder: _listeElemanlariniOlustur,
                itemCount: tumDersler.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget uygulamaGovdesiLanscape(){
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  //color: Colors.pink.shade200,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: textEditingController,
                          decoration: InputDecoration(
                            labelText: "Ders Adı",
                            hintText: "Ders adını giriniz",
                            hintStyle: TextStyle(fontSize: 20),
                            labelStyle: TextStyle(fontSize: 20),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal, width: 2),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                BorderSide(color: Colors.purple, width: 2)),
                          ),
                          validator: (girilenDeger) {
                            if (girilenDeger.length > 0) {
                              return null;
                            } else {
                              return "Ders adı boş olamaz";
                            }
                          },
                          onSaved: (kaydedilecekDeger) {
                            dersAdi = kaydedilecekDeger;
                            setState(() {
                              tumDersler.add(Ders(dersAdi, dersHarfDegeri,
                                  dersKredi,rastgeleRenkOlustur()));
                              ortalama=0;
                              ortalamayiHesapla();
                              textEditingController = new TextEditingController
                                (text:"");//Ben Ekledim

                            });
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<int>(
                                  items: dersKrediItems(),
                                  value: dersKredi,
                                  onChanged: (secilenKredi) {
                                    setState(() {
                                      dersKredi = secilenKredi;
                                    });
                                  },
                                ),
                              ),
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.green, width: 2),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            Container(
                              padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<double>(
                                  items: dersHarfDegerleriItems(),
                                  value: dersHarfDegeri,
                                  onChanged: (secilenHarf) {
                                    setState(() {
                                      dersHarfDegeri = secilenHarf;
                                    });
                                  },
                                ),
                              ),
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blue, width: 2),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(

                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade200,
                      border: BorderDirectional(
                        top: BorderSide(color: Colors.blue, width: 2),
                        bottom: BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                    child: Center(child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          children: [
                            TextSpan(text: tumDersler.length==0?"Lütfen Ders "
                                "Ekleyiniz!! ":
                            "Ortalama: ",style: tumDersler.length==0?
                            TextStyle
                              (color: Colors
                                .black,fontWeight: FontWeight.bold,fontSize: 24): TextStyle
                              (color: Colors
                                .grey.shade700,fontSize: 24)),
                            TextSpan(text: tumDersler.length==0?"":"${ortalama
                                .toStringAsFixed(2)}",
                                style:
                                TextStyle(color:
                                Colors
                                    .black,fontSize: 24,fontWeight: FontWeight.bold)),
                          ]
                      ),

                    ),
                    ),
                  ),
                ),

              ],
            ),
            flex: 1,
          ),
          Expanded(

              child: Container(

                child: ListView.builder(
                  itemBuilder: _listeElemanlariniOlustur,
                  itemCount: tumDersler.length,
                ),
              ),

            flex: 1,
          ),
        ],
      ),

    );
  }

  List<DropdownMenuItem<int>> dersKrediItems() {
    List<DropdownMenuItem<int>> krediler = [];

    for (int i = 1; i <= 10; i++) {
      var aa = DropdownMenuItem<int>(
        value: i,
        child: Text(
          "$i Kredi",
          style: TextStyle(fontSize: 18),
        ),
      );
      krediler.add(aa);
    }

    return krediler;
  }

  List<DropdownMenuItem<double>> dersHarfDegerleriItems() {
    List<DropdownMenuItem<double>> harfler = [];

    harfler.add(
      DropdownMenuItem(
        child: Text(
          " AA",
          style: TextStyle(fontSize: 18),
        ),
        value: 4,
      ),
    );
    harfler.add(
      DropdownMenuItem(
        child: Text(
          " BA",
          style: TextStyle(fontSize: 20),
        ),
        value: 3.5,
      ),
    );
    harfler.add(
      DropdownMenuItem(
        child: Text(
          " BB",
          style: TextStyle(fontSize: 20),
        ),
        value: 3,
      ),
    );
    harfler.add(
      DropdownMenuItem(
        child: Text(
          " CB",
          style: TextStyle(fontSize: 20),
        ),
        value: 2.5,
      ),
    );
    harfler.add(
      DropdownMenuItem(
        child: Text(
          " CC",
          style: TextStyle(fontSize: 20),
        ),
        value: 2,
      ),
    );
    harfler.add(
      DropdownMenuItem(
        child: Text(
          " DC",
          style: TextStyle(fontSize: 20),
        ),
        value: 1.5,
      ),
    );
    harfler.add(
      DropdownMenuItem(
        child: Text(
          " DD",
          style: TextStyle(fontSize: 20),
        ),
        value: 1,
      ),
    );
    harfler.add(
      DropdownMenuItem(
        child: Text(
          " FF",
          style: TextStyle(fontSize: 20),
        ),
        value: 0,
      ),
    );
    return harfler;
  }

  Widget _listeElemanlariniOlustur(BuildContext context, int index) {

    sayac++;
    //debugPrint(sayac.toString());
    return Dismissible(
      key: Key(sayac.toString()),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction){
        setState(() {
          tumDersler.removeAt(index);
          ortalamayiHesapla();
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: tumDersler[index].renk,width: 3),
          borderRadius: BorderRadius.circular(10)

        ),
        margin: EdgeInsets.all(10),

        child: ListTile(
          trailing: Icon(Icons.arrow_right,color: tumDersler[index].renk,),
          leading: tumDersler[index].harfDegeri>=3 ? Icon(Icons.mood,size: 36,color:
        Colors
              .green,):Icon(Icons
              .mood_bad,size: 36,color: Colors.red,),
          title: Text(tumDersler[index].ad,style: TextStyle(fontSize: 24,
              fontWeight: FontWeight.bold),),
          subtitle: Text(tumDersler[index].krediDegeri.toString() +
              " kredi not "
                  "değeri: " +
              tumDersler[index].harfDegeri.toString(),style: TextStyle
            (fontSize: 18),),
        ),
      ),
    );
  }

  void ortalamayiHesapla() {

    double toplamNot=0;
    double toplamKredi=0;

    for(var oankiDers in tumDersler){

      var kredi = oankiDers.krediDegeri;
      var harfDegeri = oankiDers.harfDegeri;
      toplamNot = toplamNot+ (harfDegeri*kredi);
      toplamKredi +=kredi;


    }

    ortalama = toplamNot/toplamKredi;
  }

  static Color rastgeleRenkOlustur() {


    return Color.fromARGB(150+Random().nextInt(105), Random().nextInt(255),
        Random().nextInt(255), Random().nextInt(255));
  }
}

class Ders {
  String ad;
  double harfDegeri;
  int krediDegeri;
  Color renk;

  Ders(this.ad, this.harfDegeri, this.krediDegeri,this.renk);
}
