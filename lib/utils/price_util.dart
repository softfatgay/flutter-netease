class PriceUtil {
  static priceToStr(String price) {
    var basicPrice = price;
    if (basicPrice.contains('.')) {
      var indexOf = basicPrice.indexOf('.');
      var subInt = basicPrice.substring(0, indexOf);
      var subsDouble = basicPrice.substring(indexOf, basicPrice.length);
      return [subInt, '$subsDouble'];
    }
    return [basicPrice, ''];
  }
}
