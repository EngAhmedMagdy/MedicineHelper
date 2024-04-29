class medicine {
  String? barcode;
  //double? price;
  String? nameAr;
  String? descriptionAr;
  String? descriptionEn;

  medicine(
      {required this.barcode,
        this.nameAr,
        this.descriptionAr,
        this.descriptionEn});

  medicine.fromJson(Map<String, dynamic> json) {
    barcode = json['barcode'];
    //price = json['price'];
    nameAr = json['name_ar'];
    descriptionAr = json['description_ar'];
    descriptionEn = json['description_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['barcode'] = this.barcode;
    //data['price'] = this.price;
    data['name_ar'] = this.nameAr;
    data['description_ar'] = this.descriptionAr;
    data['description_en'] = this.descriptionEn;
    return data;
  }
}
