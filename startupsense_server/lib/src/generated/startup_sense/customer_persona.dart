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
import 'package:serverpod/serverpod.dart' as _is;
import 'package:startupsense_server/src/generated/protocol.dart' as _ihr6jrqq;

abstract class CustomerPersona
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CustomerPersona._({
    required this.label,
    required this.description,
    required this.needs,
  });

  factory CustomerPersona({
    required String label,
    required String description,
    required List<String> needs,
  }) = _CustomerPersonaImpl;

  factory CustomerPersona.fromJson(Map<String, dynamic> jsonSerialization) {
    return CustomerPersona(
      label: jsonSerialization['label'] as String,
      description: jsonSerialization['description'] as String,
      needs: _ihr6jrqq.Protocol().deserialize<List<String>>(
        jsonSerialization['needs'],
      ),
    );
  }

  String label;

  String description;

  List<String> needs;

  /// Returns a shallow copy of this [CustomerPersona]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CustomerPersona copyWith({
    String? label,
    String? description,
    List<String>? needs,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CustomerPersona',
      'label': label,
      'description': description,
      'needs': needs.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CustomerPersona',
      'label': label,
      'description': description,
      'needs': needs.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _CustomerPersonaImpl extends CustomerPersona {
  _CustomerPersonaImpl({
    required String label,
    required String description,
    required List<String> needs,
  }) : super._(
         label: label,
         description: description,
         needs: needs,
       );

  /// Returns a shallow copy of this [CustomerPersona]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CustomerPersona copyWith({
    String? label,
    String? description,
    List<String>? needs,
  }) {
    return CustomerPersona(
      label: label ?? this.label,
      description: description ?? this.description,
      needs: needs ?? this.needs.map((e0) => e0).toList(),
    );
  }
}
