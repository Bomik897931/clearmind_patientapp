class OrderModel {
  final int orderId;
  final int prescriptionId;
  final DateTime orderDate;
  final String status;
  final String? assignedTo;
  final String paymentStatus;
  final double totalAmount;
  final DateTime? deliveryDate;
  final PatientOrderInfo? patient;
  final List<OrderItem> orderItems;

  OrderModel({
    required this.orderId,
    required this.prescriptionId,
    required this.orderDate,
    required this.status,
    this.assignedTo,
    required this.paymentStatus,
    required this.totalAmount,
    this.deliveryDate,
    this.patient,
    required this.orderItems,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['orderId'],
      prescriptionId: json['prescriptionId'],
      orderDate: DateTime.tryParse(json['orderDate'] ?? '') ?? DateTime.now(),
      status: json['status'],
      assignedTo: json['assignedTo'],
      paymentStatus: json['paymentStatus'],
      totalAmount: (json['totalAmount'] as num).toDouble(),
      deliveryDate: DateTime.tryParse(json['deliveryDate'] ?? ''),
      patient: json['patient'] != null
          ? PatientOrderInfo.fromJson(json['patient'])
          : null,
      orderItems: (json['orderItems'] as List? ?? [])
          .map((e) => OrderItem.fromJson(e))
          .toList(),
    );
  }
}
class PatientOrderInfo {
  final int patientId;
  final String fullName;
  final String doctorName;
  final int age;
  final String email;
  final String gender;
  final String phoneNumber;
  final String address;

  PatientOrderInfo({
    required this.patientId,
    required this.fullName,
    required this.doctorName,
    required this.age,
    required this.email,
    required this.gender,
    required this.phoneNumber,
    required this.address,
  });

  factory PatientOrderInfo.fromJson(Map<String, dynamic> json) {
    return PatientOrderInfo(
      patientId: json['patientId'],
      fullName: json['fullName'] ?? '',
      doctorName: json['doctorName'] ?? '',
      age: json['age'] ?? 0,
      email: json['email'] ?? '',
      gender: json['gender'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      address: json['address']?.toString() ?? '',
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
      drugId: json['drugId'],
      drugName: json['drugName'] ?? 'N/A',
      quantity: json['quantity'],
      unitPrice: (json['unitPrice'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
      strength: json['strength'] ?? '',
      numberOfDay: json['numberOfDay']?.toString() ?? '',
      instructions: json['instructions'] ?? '',
      category: json['category'] ?? '',
      brand: json['brand'] ?? '',
      timeOfDay: json['timeOfDay'] ?? '',
    );
  }
}
