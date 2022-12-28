class HanNom{
  late String unicode;
  late String? nomTxt;
  late String? nomStr;
  late String? nomDef;
  late String? nomCtx;
  late String? nomSrc;
  late String? strType;
  late String? engDef;
  late String? hHan;
  late String? hNom;
  late String? hDef;
  late String? hPinyin;
  late String? hTraditionalVariant;
  late String? hSimplifiedVariant;
  late String? hDefinition;
  late String? comment;

  HanNom({
    required this.unicode,
    this.nomTxt,
    this.nomStr,
    this.nomDef,
    this.nomCtx,
    this.nomSrc,
    this.strType,
    this.engDef,
    this.hHan,
    this.hNom,
    this.hDef,
    this.hPinyin,
    this.hTraditionalVariant,
    this.hSimplifiedVariant,
    this.hDefinition,
    this.comment
  });

  Map<String, dynamic> toMap(){
    return{
      'unicode' : unicode,
      'nomTxt' : nomTxt,
      'nomStr' : nomStr,
      'nomDef' : nomDef,
      'nomCtx' : nomCtx,
      'nomSrc' : nomSrc,
      'strType' : strType,
      'engDef' : engDef,
      'hHan' : hHan,
      'hNom' : hNom,
      'hDef' : hDef,
      'hPinyin' : hPinyin,
      'hTraditionalVariant' : hTraditionalVariant,
    };
  }

}