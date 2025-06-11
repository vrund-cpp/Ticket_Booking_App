// lib/utils/jwt_utils.dart

import 'dart:convert';

class JwtUtils {
  /// Parses a JWT and returns its payload as a Map.
  /// Throws an exception if the token is invalid.
  static Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid JWT: incorrect number of segments');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('Invalid JWT payload');
    }
    return payloadMap;
  }

  /// Base64Url-decodes the given string, adding padding if necessary.
  static String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');
    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }
    return utf8.decode(base64Url.decode(output));
  }
}
