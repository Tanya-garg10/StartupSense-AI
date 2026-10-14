/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class StartupSenseError
    implements
        _isc.SerializableException,
        _isc.SerializableModel,
        _isc.ProtocolSerialization {
  StartupSenseError._({
    required this.code,
    required this.message,
  });

  factory StartupSenseError({
    required String code,
    required String message,
  }) = _StartupSenseErrorImpl;

  factory StartupSenseError.fromJson(Map<String, dynamic> jsonSerialization) {
    return StartupSenseError(
      code: jsonSerialization['code'] as String,
      message: jsonSerialization['message'] as String,
    );
  }

  String code;

  String message;

  /// Returns a shallow copy of this [StartupSenseError]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  StartupSenseError copyWith({
    String? code,
    String? message,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StartupSenseError',
      'code': code,
      'message': message,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StartupSenseError',
      'code': code,
      'message': message,
    };
  }

  @override
  String toString() {
    return 'StartupSenseError(code: $code, message: $message)';
  }
}

class _StartupSenseErrorImpl extends StartupSenseError {
  _StartupSenseErrorImpl({
    required String code,
    required String message,
  }) : super._(
         code: code,
         message: message,
       );

  /// Returns a shallow copy of this [StartupSenseError]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  StartupSenseError copyWith({
    String? code,
    String? message,
  }) {
    return StartupSenseError(
      code: code ?? this.code,
      message: message ?? this.message,
    );
  }
}
