import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:han_nom_tu_dien/HanNom.dart';
import 'package:han_nom_tu_dien/SQLHelper.dart';
import 'package:han_nom_tu_dien/Style.dart';
import 'package:html/parser.dart';

class Nom extends StatelessWidget {
  final HanNom data;
  const Nom({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Html(
      data: data.nomDef == null ? "* Không có thông tin" : SQLHelper.safeText(data.nomDef),
      style: {
        "body": Style(
          color: Colors.white,
          fontFamily: MyStyles.fontName,
          fontSize: const FontSize(20)
        ),
        "span" : Style(
          fontFamily: MyStyles.fontName,
          color: Colors.white
        ),
      },
      customRender: {
        "a" : (context, child){
          String rawText = SQLHelper.safeText(data.nomDef);
          var document = parse(rawText);
          var element = document.getElementsByTagName("a");
          List<String> text = element.map((ele){
            String x = ele.attributes.values.last;
            return  x.substring(14,x.length-2);
          }).toList();
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: text.map((e) => Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child:SelectableHtml(
                data: e,
                style: {
                  "body" : Style(
                    color: Colors.white
                  ),
                  "i" : Style(
                    color: Colors.redAccent
                  )
                },
              )
            )).toList()
          );
        }
      },
    );
  }
}

class HanViet extends StatelessWidget {
  final HanNom data;
  const HanViet({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Phồn thể: ${data.hTraditionalVariant ?? "?"}',
          style: MyStyles.nonLatinTextStyle(),
        ),
        Text(
            'Giản thể: ${data.hSimplifiedVariant  ?? "?"}',
          style: MyStyles.nonLatinTextStyle(),
        ),
        Text(
            '${data.hDefinition?.replaceAll("/", "\n\n- ")}',
          style: MyStyles.nonLatinTextStyle(),
        )
      ],
    );
  }
}

class HanVietWord extends StatelessWidget {
  final HanNom data;
  const HanVietWord({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SelectableText(
        "${data.hDefinition?.replaceAll("/", '\n -')}",
        style: MyStyles.nonLatinTextStyle(size: 16),
      ),
    );
  }
}

class TamTuKinhvaThienTuVan extends StatelessWidget {
  final HanNom data;
  const TamTuKinhvaThienTuVan({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        SQLHelper.safeText(data.hDef),
        style: MyStyles.nonLatinTextStyle(size: 18),
      ),
    );
  }
}

class Analect extends StatelessWidget {
  final HanNom data;
  const Analect({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '- ${data.hDef ?? '?'}',
          style: MyStyles.nonLatinTextStyle(size: 18),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          color: Colors.white,
          child: Html(
            data: data.comment,
          ),
        ),
      ],
    );
  }
}


