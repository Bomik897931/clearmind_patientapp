class CartResponse {
  final int orderId;
  final int prescriptionId;
  final String orderDate;
  final String status;
  final String? assignedTo;
  final String paymentStatus;
  final double totalAmount;
  final String deliveryDate;
  final Patient patient;
  final List<OrderItem> orderItems;

  CartResponse({
    required this.orderId,
    required this.prescriptionId,
    required this.orderDate,
    required this.status,
    this.assignedTo,
    required this.paymentStatus,
    required this.totalAmount,
    required this.deliveryDate,
    required this.patient,
    required this.orderItems,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      orderId: json['orderId'] ?? 0,
      prescriptionId: json['prescriptionId'] ?? 0,
      orderDate: json['orderDate'] ?? '',
      status: json['status'] ?? '',
      assignedTo: json['assignedTo'],
      paymentStatus: json['paymentStatus'] ?? '',
      totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0.0,
      deliveryDate: json['deliveryDate'] ?? '',
      patient: Patient.fromJson(json['patient']),
      orderItems: (json['orderItems'] as List? ?? [])
          .map((e) => OrderItem.fromJson(e))
          .toList(),
    );
  }
}


class Patient {
  final int patientId;
  final String fullName;
  final String doctorName;
  final int age;
  final String email;
  final String gender;
  final String phoneNumber;
  final String address;

  Patient({
    required this.patientId,
    required this.fullName,
    required this.doctorName,
    required this.age,
    required this.email,
    required this.gender,
    required this.phoneNumber,
    required this.address,
  });

  factory Patient.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Patient(
        patientId: 0,
        fullName: '',
        doctorName: '',
        age: 0,
        email: '',
        gender: '',
        phoneNumber: '',
        address: '',
      );
    }

    return Patient(
      patientId: json['patientId'] ?? 0,
      fullName: json['fullName'] ?? '',
      doctorName: json['doctorName'] ?? '',
      age: json['age'] ?? 0,
      email: json['email'] ?? '',
      gender: json['gender'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      address: json['address'] ?? '',
    );
  }
}


class OrderItem {
  final int drugId;
  final String drugName;
  final int quantity;
  final double unitPrice;
  final double discount;
  final double totalPrice;
  final String strength;
  final String numberOfDay;
  final String instructions;
  final String category;
  final String brand;
  final String timeOfDay;

  OrderItem({
    required this.drugId,
    required this.drugName,
    required this.quantity,
    required this.unitPrice,
    required this.discount,
    required this.totalPrice,
    required this.strength,
    required this.numberOfDay,
    required this.instructions,
    required this.category,
    required this.brand,
    required this.timeOfDay,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      drugId: json['drugId'] ?? 0,
      drugName: json['drugName'] ?? '',
      quantity: json['quantity'] ?? 0,
      unitPrice: (json['unitPrice'] as num?)?.toDouble() ?? 0.0,
      discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
      totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0.0,
      strength: json['strength'] ?? '',
      numberOfDay: json['numberOfDay'] ?? '',
      instructions: json['instructions'] ?? '',
      category: json['category'] ?? '',
      brand: json['brand'] ?? '',
      timeOfDay: json['timeOfDay']?.toString() ?? '',
    );
  }
}
