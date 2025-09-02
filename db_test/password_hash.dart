import 'dart:convert';
import 'package:crypto/crypto.dart';



// This function is to encode user passwords so database admins cannot view them.
String hashPassword(String password) {
  final bytes = utf8.encode(password);
  final digest = sha256.convert(bytes);
  return digest.toString();
}