// import 'dart:ffi';
// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:han_nom_tu_dien/HanNom.dart';
// import 'package:han_nom_tu_dien/SQLHelper.dart';
// import 'package:han_nom_tu_dien/Style.dart';
// import 'Han.dart';
// import 'MyColors.dart';
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   late double _height;
//   late double _width;
//   String value = "";
//   final _fontSize = 20.0;
//   final _fontName = 'hannomb.ttf';
//   TextEditingController inputControler = TextEditingController();
//   final _viewportFraction = 0.3;
//   late PageController titlePageControler;
//   late PageController pageController;
//   double pageOffset = 0;
//   List<String> listTitle = ["Hannom", "Han viet", "Kinh"];
//   List<HanNom> hanNom = [];
//   double currentPage = 1;
//   double position = 1.0;
//
//
//   @override
//   void initState() {
//     pageController = PageController(initialPage: currentPage.toInt());
//     titlePageControler = PageController(initialPage: currentPage.toInt(), viewportFraction: _viewportFraction)
//       ..addListener(() {
//         setState(() {
//           pageOffset = titlePageControler.offset;
//           currentPage = titlePageControler.page!;
//         });
//       });
//     pageController.addListener(() {
//       titlePageControler.jumpTo(pageController.offset*0.3);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     _height = MediaQuery.of(context).size.height;
//     _width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               flex: 4,
//               child: Container(
//                 padding:const EdgeInsets.all(10),
//                 decoration: const BoxDecoration(
//                     color: MyColors.backgroundColor1,
//                     borderRadius:BorderRadius.vertical(bottom: Radius.circular(25))
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Container(
//                       padding:const EdgeInsets.symmetric(horizontal: 10),
//                       decoration:const BoxDecoration(
//                           color: MyColors.backgroundColor2,
//                           borderRadius: BorderRadius.all( Radius.circular(25))
//                       ),
//                       child: TextField(
//                         controller: inputControler,
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                           hintText: "Nhập văn bản",
//                           hintStyle: InputTextStyle(),
//                         ),
//                         cursorHeight: _fontSize,
//                         cursorColor: Colors.red,
//                         maxLines: 2,
//                         minLines: 1,
//                         style: InputTextStyle(),
//                       ),
//                     ),
//                     IconButton(
//                         onPressed: (){
//                           setState(() {
//                             value = inputControler.text.toString();
//                           });
//                         },
//                         icon: const Icon(
//                           Icons.search_rounded,
//                           color: Colors.white70,
//                         )
//                     ),
//                     PageTitle(titlePageControler: titlePageControler, listTitle: listTitle, page: currentPage, pageControler: pageController,),
//                   ],
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 6,
//               child: PageView.builder(
//                 controller: pageController,
//                 itemCount: listTitle.length,
//                 itemBuilder: (context, index) {
//                   return ListResult(value: value, index:  index,);
//                 }
//               )
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   TextStyle InputTextStyle() {
//     return TextStyle(
//       fontSize: _fontSize,
//       fontFamily: _fontName
//     );
//   }
// }
//
//
// class PageTitle extends StatelessWidget {
//
//   const PageTitle({
//     Key? key,
//     required this.titlePageControler,
//     required this.listTitle,
//     required this.page,
//     required this.pageControler
//   }) : super(key: key);
//
//   final PageController titlePageControler;
//   final List<String> listTitle;
//   final double page;
//   final PageController pageControler;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 50,
//       margin: const EdgeInsets.all(5),
//       child: PageView.builder(
//         physics: const NeverScrollableScrollPhysics(),
//         controller: titlePageControler,
//         itemCount: listTitle.length,
//         itemBuilder: (context, index){
//           return Center(
//             child: AnimatedOpacity(
//               duration:const Duration(milliseconds: 0),
//               opacity: (index - page).abs() >= 1 ? 0.3 : ((1-(index - page).abs()) < 0.3 ? 0.3 : (1-(index - page).abs())) ,
//               child: GestureDetector(
//                 child: Text(
//                   listTitle[index],
//                   style: MyStyles.titleTextStyle,
//                 ),
//                 onTap: (){
//                   pageControler.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.decelerate);
//                 },
//               ),
//             ),
//           );
//         },
//
//       ),
//     );
//   }
// }
//
// class ListResult extends StatefulWidget {
//   const ListResult({Key? key, required this.value, required this.index}) : super(key: key);
//   final String value;
//   final int index;
//   @override
//   State<ListResult> createState() => _ListResultState();
// }
//
// class _ListResultState extends State<ListResult> {
//
//   List<HanNom> gb = [];
//   late SQLHelper sqlHelper;
//
//   @override
//   void initState() {
//     super.initState();
//     sqlHelper = SQLHelper();
//   }
//
//   void run() async{
//
//    var h = await sqlHelper.search(key: widget.value, table: SQLHelper.nomTable);
//     setState(() {
//       gb = h;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     run();
//     if(gb.isEmpty) {
//       return Container(
//         color: Colors.white,
//           child:const Center(
//             child: CircularProgressIndicator(),
//           )
//       );
//     }
//     return Container(
//       color: Colors.white,
//       child: ListView.builder(
//         itemCount: gb.length,
//         itemBuilder: (BuildContext context, int index){
//           return Text(gb[index].unicode);
//         },
//       )
//     );
//   }
// }
//
//
//
//
//
//
