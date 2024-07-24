class PaymentConfiguration {
  final String provider;
  final String merchantIdentifier;
  final String displayName;
  final List<String> merchantCapabilities;
  final List<String> supportedNetworks;
  final String countryCode;
  final String currencyCode;
  final List<String> requiredBillingContactFields;
  final List<String> requiredShippingContactFields;
  final List<ShippingMethod> shippingMethods;

  PaymentConfiguration({
    required this.provider,
    required this.merchantIdentifier,
    required this.displayName,
    required this.merchantCapabilities,
    required this.supportedNetworks,
    required this.countryCode,
    required this.currencyCode,
    required this.requiredBillingContactFields,
    required this.requiredShippingContactFields,
    required this.shippingMethods,
  });

  factory PaymentConfiguration.fromJson(Map<String, dynamic> json) {
    return PaymentConfiguration(
      provider: json['provider'],
      merchantIdentifier: json['data']['merchantIdentifier'],
      displayName: json['data']['displayName'],
      merchantCapabilities: json['data']['merchantCapabilities'].cast<String>(),
      supportedNetworks: json['data']['supportedNetworks'].cast<String>(),
      countryCode: json['data']['countryCode'],
      currencyCode: json['data']['currencyCode'],
      requiredBillingContactFields: json['data']['requiredBillingContactFields'].cast<String>(),
      requiredShippingContactFields: json['data']['requiredShippingContactFields'].cast<String>(),
      shippingMethods: json['data']['shippingMethods']
         .map((jsonMethod) => ShippingMethod.fromJson(jsonMethod))
         .toList(),
    );
  }
}

class ShippingMethod {
  final String amount;
  final String detail;
  final String identifier;
  final String label;

  ShippingMethod({
    required this.amount,
    required this.detail,
    required this.identifier,
    required this.label,
  });

  factory ShippingMethod.fromJson(Map<String, dynamic> json) {
    return ShippingMethod(
      amount: json['amount'],
      detail: json['detail'],
      identifier: json['identifier'],
      label: json['label'],
    );
  }
}