import 'package:flutter/material.dart';
import 'package:han_nom_tu_dien/ListChildren.dart';
import 'package:han_nom_tu_dien/Style.dart';
import 'ExpandedChildren.dart';
import 'HanNom.dart';
import 'MyColors.dart';
import 'SQLHelper.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final _viewportFraction = 0.3;
  late PageController titlePageControler;
  late PageController pageController;
  double pageOffset = 0;
  List<String> listTitle = ['Nôm','Hán Việt','Tam thiên tự','Từ Hán Việt','Tam tự kinh','Thiên tự văn','Bách gia tính','Luận ngữ'];
  double currentPage = 1;
  String value = '';

  @override
  void initState() {
    pageController = PageController(initialPage: currentPage.toInt());
    titlePageControler = PageController(initialPage: currentPage.toInt(), viewportFraction: _viewportFraction)
      ..addListener(() {
        setState(() {
          pageOffset = titlePageControler.offset;
          currentPage = titlePageControler.page!;
        });
      });
    // pageController.addListener(() {
    //   print(titlePageControler.offset.toString() + "  " + ((pageController.offset/3).toInt().toString()));
    //   titlePageControler.jumpTo(double.parse((pageController.offset*0.36).toInt().toString()));
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar:AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Container(
              padding:const EdgeInsets.symmetric(horizontal: 10),
              decoration:const BoxDecoration(
                  color: MyColors.backgroundColor1,
                  borderRadius: BorderRadius.all( Radius.circular(25))
              ),
              child: TextField(
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Nhập văn bản",
                    hintStyle: TextStyle(
                        fontSize: MyStyles.fontSize,
                        color: Colors.white70
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white70,
                    )
                ),
                cursorHeight: MyStyles.fontSize,
                cursorColor: Colors.red,
                maxLines: 1,
                style: const TextStyle(
                    fontSize: MyStyles.fontSize,
                    fontFamily: MyStyles.fontName,
                    color: Colors.white
                ),
                onSubmitted: (va)=>setState(() {
                  value = va.trim().toLowerCase();
                }),
              ),
            ),
            PageTitle(titlePageControler: titlePageControler, listTitle: listTitle, page: currentPage, pageControler: pageController,)
          ],
        ),
        toolbarHeight: 120,
        backgroundColor: Colors.black,
      ),
      body: PageView.builder(
          controller: pageController,
          itemCount: listTitle.length,
          itemBuilder: (context, index) {
            return ListResult(value: value, index:  index,);
          },
          onPageChanged:(index){
            titlePageControler.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.decelerate);
          } ,
      )
    );
  }
}

class PageTitle extends StatelessWidget {

  const PageTitle({
    Key? key,
    required this.titlePageControler,
    required this.listTitle,
    required this.page,
    required this.pageControler
  }) : super(key: key);

  final PageController titlePageControler;
  final List<String> listTitle;
  final double page;
  final PageController pageControler;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.all(5),
      child: PageView.builder(
        controller: titlePageControler,
        itemCount: listTitle.length,
        itemBuilder: (context, index){
          return Center(
            child: AnimatedOpacity(
              duration:const Duration(milliseconds: 0),
              opacity: (index - page).abs() >= 1 ? 0.3 : ((1-(index - page).abs()) < 0.3 ? 0.3 : (1-(index - page).abs())) ,
              child: GestureDetector(
                child: Text(
                  listTitle[index],
                  style: MyStyles.titleTextStyle,
                ),
                onTap: (){
                  pageControler.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.decelerate);
                },
              ),
            ),
          );
        },
        onPageChanged: (index){
          pageControler.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.decelerate);
        },
      ),
    );
  }
}

class ListResult extends StatefulWidget {
  const ListResult({Key? key, required this.value, required this.index}) : super(key: key);
  final String value;
  final int index;
  @override
  State<ListResult> createState() => _ListResultState();
}

class _ListResultState extends State<ListResult> {

  late Future<List<HanNom>> gb;
  late SQLHelper sqlHelper;
  String key= '';

  @override
  void initState() {
    super.initState();
    sqlHelper = SQLHelper();
    key = widget.value;
  }

  void run() async{
    gb = sqlHelper.search(key: widget.value, indexTable: widget.index );
  }

  @override
  Widget build(BuildContext context) {
    run();
    return Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder(
            future: gb,
            builder: (BuildContext context, AsyncSnapshot<List<HanNom>> snapshot) {
              if (widget.value.isEmpty){
                return const Center(
                  child: Text(
                    "Chưa nhập!!!",
                    style: MyStyles.titleTextStyle,
                  ),
                );
              }
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              List<HanNom> hn = snapshot.data ?? <HanNom>[] ;
              if (hn.isEmpty){
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: Text(
                      "Không tìm thấy kết quả cho từ khóa $key",
                      style:const TextStyle(
                        color: Colors.white,
                        fontSize: 30
                      ),

                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
              return ListView.builder(
                itemCount: hn.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: MyColors.backgroundColor1,
                    child: itemList(hn[index], widget.index),
                  );
                },
              );
            },
            
          ),
        )
    );
  }


  
  Widget itemList(HanNom hn, int index){
    Widget child = itemExpanded(hn, index);
    switch(index){
      case 0:
        return List_Item_Nom(data: hn, child: child);
      case 1: 
        return List_Item_HanViet(data: hn,child: child);
      case 2:
        return List_Item_TamThienTu(data: hn);
      case 3:
        return List_Item_HanVietWord(data: hn, child: child,);
      case 4:
        return List_Item_TamTuKinhvaThienTuVan(data: hn, child: child,);
      case 5:
        return List_Item_TamTuKinhvaThienTuVan(data: hn, child: child,);
      case 6:
        return List_Item_BachGiaTinh(data: hn);
      case 7: 
        return List_Item_Analect(data: hn, child: child,);
    }
    return Container();
  }

  Widget itemExpanded(HanNom data, int index){
    Widget select = Container();
    switch (index){
      case 0:
        select = Nom(data: data);
        break;
      case 1:
        select = HanViet(data: data);
        break;
      case 3:
        select = HanVietWord(data: data);
        break;
      case 4:
      case 5: //
      select = TamTuKinhvaThienTuVan(data: data);
        break;
      case 7:
        select = Analect(data: data);
        break;
    }
    return select;
  }
}
