enum ProductSizes {
  xs(
    name: "Extra Small",
    value: "xs",
  ),
  s(
    name: "Small",
    value: "s",
  ),
  m(
    name: "Medium",
    value: "m",
  ),
  l(
    name: "Large",
    value: "l",
  ),
  xl(
    name: "Extra Large",
    value: "xl",
  ),
  xxl(
    name: "Double Extra Large",
    value: "2xl",
  ),
  ;

  final String name;
  final String value;

  const ProductSizes({
    required this.name,
    required this.value,
  });
}
