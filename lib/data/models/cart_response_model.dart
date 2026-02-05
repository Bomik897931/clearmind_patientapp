class CartResponse {
  final int orderId;
  final double totalAmount;
  final Patient patient;
  final List<OrderItem> orderItems;

  CartResponse({
    required this.orderId,
    required this.totalAmount,
    required this.patient,
    required this.orderItems,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      orderId: json['orderId'],
      totalAmount: (json['totalAmount'] as num).toDouble(),
      patient: Patient.fromJson(json['patient']),
      orderItems: (json['orderItems'] as List)
          .map((e) => OrderItem.fromJson(e))
          .toList(),
    );
  }
}

class Patient {
  final String fullName;
  final String phoneNumber;
  final String address;

  Patient({
    required this.fullName,
    required this.phoneNumber,
    required this.address,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
    );
  }
}

class OrderItem {
  final String drugName;
  final int quantity;
  final double unitPrice;
  final double discount;
  final double totalPrice;
  final String strength;
  final String numberOfDay;

  OrderItem({
    required this.drugName,
    required this.quantity,
    required this.unitPrice,
    required this.discount,
    required this.totalPrice,
    required this.strength,
    required this.numberOfDay,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      drugName: json['drugName'],
      quantity: json['quantity'],
      unitPrice: (json['unitPrice'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
      strength: json['strength'],
      numberOfDay: json['numberOfDay'],
    );
  }
}
