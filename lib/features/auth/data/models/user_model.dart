import 'package:flutter/material.dart' show CircleAvatar, Icons, Icon;
import 'package:tcw/core/apis/apis_url.dart';
import 'package:tcw/core/shared/shared_widget/custom_image.dart';

UserModel? userData;

class UserModel {
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phone: json['phone'],
      emailVerifiedAt: json['email_verified_at'],
      address: json['address'],
      type: json['type'],
      status: json['status'],
      identityType: json['identity_type'],
      identityNumber: json['identity_number'],
      identityProof: json['identity_proof'],
      image: json['image'],
      deviceToken: json['device_token'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      webFcmToken: json['web_fcm_token'],
      token: json['token'],
    );
  }

  UserModel({
    required this.id,
    required this.name,
    this.firstName,
    this.lastName,
    required this.email,
    this.phone,
    this.emailVerifiedAt,
    this.address,
    this.type,
    this.status,
    this.identityType,
    this.identityNumber,
    this.identityProof,
    this.image,
    this.deviceToken,
    this.createdAt,
    this.updatedAt,
    this.webFcmToken,
    this.token,
  });
  final int id;
  final String name;
  final String? firstName;
  final String? lastName;
  final String email;
  final String? phone;
  final String? emailVerifiedAt;
  final String? address;
  final String? type;
  final String? status;
  final String? identityType;
  final String? identityNumber;
  final String? identityProof;
  final String? image;
  final String? deviceToken;
  final String? createdAt;
  final String? updatedAt;
  final String? webFcmToken;
  String? token;
  String get validImage => image?.startsWith('http') ?? false ? image! : '${ApiUrl.baseImageUrl}/storage/app/public/$image';
  CircleAvatar get imageWidget => CircleAvatar(
        backgroundImage: image != null ? CustomImage.provider(validImage) : null,
        child: image == null ? const Icon(Icons.person, size: 30) : null,
      );
  String get getFirstName => name.split(' ').first;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone': phone,
        'email_verified_at': emailVerifiedAt,
        'address': address,
        'type': type,
        'status': status,
        'identity_type': identityType,
        'identity_number': identityNumber,
        'identity_proof': identityProof,
        'image': image,
        'device_token': deviceToken,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'web_fcm_token': webFcmToken,
        'token': token,
      };

  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? phone,
    String? imagePath,
    String? password,
    String? confirmPassword,
    String? email,
    String? address,
    String? type,
    String? status,
    String? identityType,
    String? identityNumber,
    String? identityProof,
    String? deviceToken,
    String? createdAt,
    String? updatedAt,
    String? webFcmToken,
    String? token,
    int? id,
    String? name,
    String? emailVerifiedAt,
    String? image,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      address: address ?? this.address,
      type: type ?? this.type,
      status: status ?? this.status,
      identityType: identityType ?? this.identityType,
      identityNumber: identityNumber ?? this.identityNumber,
      identityProof: identityProof ?? this.identityProof,
      deviceToken: deviceToken ?? this.deviceToken,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      webFcmToken: webFcmToken ?? this.webFcmToken,
      token: token ?? this.token,
      image: image ?? this.image,
    );
  }
}
