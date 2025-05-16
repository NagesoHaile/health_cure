import 'dart:convert';

class StartedTherapy {
  final String? protocolId;
  final DateTime? startDate;

  StartedTherapy({this.protocolId, this.startDate});

  factory StartedTherapy.fromMap(Map<String, dynamic> map) {
    return StartedTherapy(
      protocolId: map['protocol_id'],
      startDate: map['start_date'] != null
          ? DateTime.tryParse(map['start_date'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'protocol_id': protocolId,
      'start_date': startDate?.toIso8601String(),
    };
  }
}

class UserModel {
  final String? uid;
  final String? name;
  final String? email;
  final String? phone;
  final String? password;
  final DateTime? createdAt;
  final StartedTherapy? startedTherapy;

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.phone,
    this.password,
    this.createdAt,
    this.startedTherapy,
  });

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? phone,
    String? password,
    DateTime? createdAt,
    StartedTherapy? startedTherapy,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      createdAt: createdAt ?? this.createdAt,
      startedTherapy: startedTherapy ?? this.startedTherapy,
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      password: map['password'],
      createdAt: map['created_at'] != null
          ? (map['created_at'] is String
              ? DateTime.tryParse(map['created_at'])
              : DateTime.fromMillisecondsSinceEpoch(
                  map['created_at'].seconds * 1000))
          : null,
      startedTherapy: map['started_therapy'] != null
          ? StartedTherapy.fromMap(
              Map<String, dynamic>.from(map['started_therapy']))
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'created_at': createdAt?.toIso8601String(),
      'started_therapy': startedTherapy?.toMap(),
    };
  }

  String toJson() => jsonEncode(toMap());

  factory UserModel.fromJson(Map<String, dynamic> source) =>
      UserModel.fromMap(source);
}
