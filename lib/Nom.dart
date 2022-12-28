//
//
// import 'package:flutter/material.dart';
//
// import 'HanNom.dart';
// import 'SQLHelper.dart';
//
// class NomScreen extends StatefulWidget {
//
//    String values;
//    VoidCallback onDataChange;
//
//    NomScreen({Key? key,required this.values,required this.onDataChange}) : super(key: key);
//
//   @override
//   State<NomScreen> createState() => _NomScreenState(values: values, onDataChange: onDataChange);
// }
//
// class _NomScreenState extends State<NomScreen> {
//
//
//    String values;
//    VoidCallback onDataChange;
//   _NomScreenState({required this.values, required this.onDataChange});
//
//   List<HanNom> hanNom = [];
//
//   var SQL = SQLHelper();
//
//   void run() async {
//
//     List<HanNom> a = await SQL.search(key: values, table: "true");
//     setState(() {
//       hanNom = a;
//     });
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     onDataChange();
//     return Scaffold(
//       body: Center(
//           child:Column(
//             children: [
//               Text(values,),
//             ],
//           )
//       ),
//       backgroundColor: Colors.white,
//     );
//     // run();
//     // return  ListView.builder(
//     //   itemCount: hanNom.length,
//     //   itemBuilder: (BuildContext context, int index){
//     //     return itemListView(index);
//     //   },
//     // );
//   }
//
//   Widget itemListView(int index){
//     const String fontFamily = 'HannomB';
//     HanNom hn = hanNom[index];
//     return Container(
//       padding: EdgeInsets.all(10),
//       child: Row(
//         children: [
//           Text(
//             hn.unicode,
//             style:const TextStyle(
//                 fontSize: 70,
//                 fontWeight: FontWeight.bold,
//                 fontFamily: fontFamily
//             ),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 SQLHelper.safeText(hn.nomTxt),
//                 style:const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20
//                 ),
//               ),
//               Text(SQLHelper.safeText(hn.nomCtx)),
//             ],
//           )
//         ],
//       ),
//     );
//   }
//
// }
