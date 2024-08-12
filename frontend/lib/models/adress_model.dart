class AdressModel {
  final String street;
  final String city;
  final String zipcode;
  final String state;
  final String? extra;

  AdressModel({
    required this.street,
    required this.city,
    required this.zipcode,
    required this.state,
    required this.extra,
  });

  factory AdressModel.fromJson(Map<String, dynamic> data) {
    return AdressModel(
      street: data['street'],
      city: data['city'],
      zipcode: data['zipcode'],
      state: data['state'],
      extra: data['extra'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'street': street,
      'city': city,
      'zipcode': zipcode,
      'state': state,
      'extra': extra,
    };
  }
}
