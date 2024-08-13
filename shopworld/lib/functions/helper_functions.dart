String getPercentualValue(String value) {
  String discount = (double.parse(value) * 100).toString();
  String discountFormatted = discount.endsWith('.0')
      ? discount.substring(0, discount.length - 2)
      : discount;

  return '$discountFormatted% off';
}
