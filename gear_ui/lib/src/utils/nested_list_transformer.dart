class NestedListTransformer<T> {
  const NestedListTransformer({
    required this.original,
    this.nestedListLength = 1,
  }) : assert(
          nestedListLength >= 1,
          "nestedListLength cannot be less than 1.",
        );

  final List<T> original;

  /// Number of elements per nested list.
  final int nestedListLength;

  List<List<T>> get transformedList {
    if (nestedListLength == 1) {
      return [
        ...original.map((e) => [e])
      ];
    }

    List<T> nestedList = [];
    final List<List<T>> result = [];

    for (var element in original) {
      if (nestedList.isEmpty) {
        result.add(nestedList);
      }

      nestedList.add(element);

      // reset nested list if filled nested list.
      if (nestedList.length == nestedListLength) {
        nestedList = [];
      }
    }

    return result;
  }
}
