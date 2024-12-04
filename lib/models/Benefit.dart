class Benefit {
  String companyId;
  String providerId;
  String category;
  String imageUrl;
  String benefitUrl;
  String name;
  String price;

  Benefit(
      {required this.companyId,
      required this.providerId,
      required this.category,
      required this.benefitUrl,
      required this.imageUrl,
      required this.name,
      required this.price});

  Benefit.fromSnapshot(Map<String, dynamic> snapshot)
      : companyId = snapshot['CompanyId'].toString(),
        providerId = snapshot['ProviderId'].toString(),
        category = snapshot['Category'].toString(),
        imageUrl = snapshot['ImageUrl'].toString(),
        name = snapshot['Name'].toString(),
        benefitUrl = snapshot['BenefitUrl'].toString(),
        price = snapshot['Price'].toString();
}
