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

abstract class RiskItem
    implements _is.SerializableModel, _is.ProtocolSerialization {
  RiskItem._({
    required this.title,
    required this.description,
    required this.likelihood,
    required this.mitigation,
  });

  factory RiskItem({
    required String title,
    required String description,
    required String likelihood,
    required String mitigation,
  }) = _RiskItemImpl;

  factory RiskItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return RiskItem(
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      likelihood: jsonSerialization['likelihood'] as String,
      mitigation: jsonSerialization['mitigation'] as String,
    );
  }

  String title;

  String description;

  String likelihood;

  String mitigation;

  /// Returns a shallow copy of this [RiskItem]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RiskItem copyWith({
    String? title,
    String? description,
    String? likelihood,
    String? mitigation,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RiskItem',
      'title': title,
      'description': description,
      'likelihood': likelihood,
      'mitigation': mitigation,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RiskItem',
      'title': title,
      'description': description,
      'likelihood': likelihood,
      'mitigation': mitigation,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _RiskItemImpl extends RiskItem {
  _RiskItemImpl({
    required String title,
    required String description,
    required String likelihood,
    required String mitigation,
  }) : super._(
         title: title,
         description: description,
         likelihood: likelihood,
         mitigation: mitigation,
       );

  /// Returns a shallow copy of this [RiskItem]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RiskItem copyWith({
    String? title,
    String? description,
    String? likelihood,
    String? mitigation,
  }) {
    return RiskItem(
      title: title ?? this.title,
      description: description ?? this.description,
      likelihood: likelihood ?? this.likelihood,
      mitigation: mitigation ?? this.mitigation,
    );
  }
}
