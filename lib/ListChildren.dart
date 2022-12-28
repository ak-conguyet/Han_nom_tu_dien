import 'package:flutter/material.dart';
import 'package:han_nom_tu_dien/HanNom.dart';
import 'package:han_nom_tu_dien/SQLHelper.dart';
import 'MyColors.dart';
import 'Style.dart';

class List_Item_Nom extends StatelessWidget {
  final HanNom data;
  final Widget child;
  const List_Item_Nom({Key? key, required this.data, required this.child, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: MyColors.backgroundColor1,
      child: ExpansionTile(
        title: Text(
          '(${SQLHelper.safeText(data.nomTxt)})',
          style: MyStyles.nonLatinTextStyle(size: 28),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        tilePadding: const EdgeInsets.all(5),
        subtitle: Text(
          '${data.nomCtx!=null ? "- " : ""} ${data.nomCtx ?? ""}',
          style: MyStyles.nonLatinTextStyle(size: 20),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        leading: Text(
          data.unicode,
          style: MyStyles.nonLatinTextStyle(size: 40),
        ),
        collapsedIconColor: Colors.white,
        iconColor: Colors.white,
        children: [
          child
        ],
      ),
    );
  }
}

class List_Item_HanViet extends StatelessWidget {
  final HanNom data;
  final Widget child;
  const List_Item_HanViet({Key? key, required this.data, required this.child, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: MyColors.backgroundColor1,
      child: ExpansionTile(
        title: Text(
          '(${SQLHelper.safeText(data.hHan)})',
          style: MyStyles.nonLatinTextStyle(size: 28),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        tilePadding: const EdgeInsets.all(5),
        subtitle: Text(
          '- pinyin: ${SQLHelper.safeText(data.hPinyin)}',
          style: MyStyles.nonLatinTextStyle(size: 20),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        leading: Text(
          data.unicode,
          style: MyStyles.nonLatinTextStyle(size: 40),
        ),
        collapsedIconColor: Colors.white,
        iconColor: Colors.white,
        children: [
          child
        ],
      ),
    );
  }
}

class List_Item_TamThienTu extends StatelessWidget {
  final HanNom data;
  const List_Item_TamThienTu({Key? key, required this.data,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.all(5),
      child: Row(
        children: [
          Text(
            data.unicode,
            style: MyStyles.nonLatinTextStyle(size: 40),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '(${data.hHan})',
                  style: MyStyles.nonLatinTextStyle(size: 28),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '- ${data.hNom}',
                  style: MyStyles.nonLatinTextStyle(size: 20),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class List_Item_HanVietWord extends StatelessWidget {
  final HanNom data;
  final Widget child;
  const List_Item_HanVietWord({Key? key, required this.data, required this.child, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: MyColors.backgroundColor1,
      child: ExpansionTile(
        title: Text(
          SQLHelper.safeText(data.unicode),
          style: MyStyles.nonLatinTextStyle(size: 28),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        tilePadding: const EdgeInsets.all(5),
        subtitle: Text(
          '(${SQLHelper.safeText(data.hHan)})',
          style: MyStyles.nonLatinTextStyle(size: 20),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        collapsedIconColor: Colors.white,
        iconColor: Colors.white,
        children: [
          child
        ],
      ),
    );
  }
}

class List_Item_TamTuKinhvaThienTuVan extends StatelessWidget {
  final HanNom data;
  final Widget child;
  const List_Item_TamTuKinhvaThienTuVan({Key? key, required this.data, required this.child, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: MyColors.backgroundColor1,
      child: ExpansionTile(
        title: Text(
          SQLHelper.safeText(data.unicode),
          style: MyStyles.nonLatinTextStyle(size: 28),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        tilePadding: const EdgeInsets.all(5),
        subtitle: Text(
          '(${SQLHelper.safeText(data.hHan)})',
          style: MyStyles.nonLatinTextStyle(size: 20),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        collapsedIconColor: Colors.white,
        iconColor: Colors.white,
        children: [
          child
        ],
      ),
    );
  }
}

class List_Item_BachGiaTinh extends StatelessWidget {
  final HanNom data;
  const List_Item_BachGiaTinh({Key? key, required this.data,}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Text(
          '${SQLHelper.safeText(data.unicode)}',
          style: MyStyles.nonLatinTextStyle(size: 28),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          '${SQLHelper.safeText(data.hHan)}',
          style: MyStyles.nonLatinTextStyle(size: 20),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class List_Item_Analect extends StatelessWidget {
  final HanNom data;
  final Widget child;
  const List_Item_Analect({Key? key, required this.data, required this.child, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: MyColors.backgroundColor1,
      child: ExpansionTile(
        title: Text(
          SQLHelper.safeText(data.unicode),
          style: MyStyles.nonLatinTextStyle(size: 18),
          maxLines: 10,
          overflow: TextOverflow.ellipsis,
        ),
        tilePadding: const EdgeInsets.all(5),
        subtitle: Text(
          '(${SQLHelper.safeText(data.hHan)})',
          style: MyStyles.nonLatinTextStyle(size: 20),
          maxLines: 10,
          overflow: TextOverflow.ellipsis,
        ),
        collapsedIconColor: Colors.white,
        iconColor: Colors.white,
        children: [
          child
        ],
      ),
    );
  }
}


