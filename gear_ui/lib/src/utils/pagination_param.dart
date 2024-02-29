class PaginationParam {
  final int page;
  final int size;

  PaginationParam({
    required this.page,
    required this.size,
  });

  int get offset {
    return (page - 1) * size;
  }

  int get nextSize {
    return offset + size;
  }
}
