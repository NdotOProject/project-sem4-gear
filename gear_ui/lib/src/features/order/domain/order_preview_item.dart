class OrderPreviewItem {
  int productId;
  int colorId;
  int sizeId;
  int quantity;

  OrderPreviewItem({
    required this.productId,
    required this.colorId,
    required this.sizeId,
    required this.quantity,
  });

  @override
  String toString() {
    return 'OrderPreviewItem{productId: $productId, colorId: $colorId, sizeId: $sizeId, quantity: $quantity}';
  }
}
