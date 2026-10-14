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

abstract class CompetitorHypothesis
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CompetitorHypothesis._({
    required this.alternativeType,
    required this.whatTheyOffer,
    required this.differentiationOpportunity,
  });

  factory CompetitorHypothesis({
    required String alternativeType,
    required String whatTheyOffer,
    required String differentiationOpportunity,
  }) = _CompetitorHypothesisImpl;

  factory CompetitorHypothesis.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CompetitorHypothesis(
      alternativeType: jsonSerialization['alternativeType'] as String,
      whatTheyOffer: jsonSerialization['whatTheyOffer'] as String,
      differentiationOpportunity:
          jsonSerialization['differentiationOpportunity'] as String,
    );
  }

  String alternativeType;

  String whatTheyOffer;

  String differentiationOpportunity;

  /// Returns a shallow copy of this [CompetitorHypothesis]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CompetitorHypothesis copyWith({
    String? alternativeType,
    String? whatTheyOffer,
    String? differentiationOpportunity,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CompetitorHypothesis',
      'alternativeType': alternativeType,
      'whatTheyOffer': whatTheyOffer,
      'differentiationOpportunity': differentiationOpportunity,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CompetitorHypothesis',
      'alternativeType': alternativeType,
      'whatTheyOffer': whatTheyOffer,
      'differentiationOpportunity': differentiationOpportunity,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _CompetitorHypothesisImpl extends CompetitorHypothesis {
  _CompetitorHypothesisImpl({
    required String alternativeType,
    required String whatTheyOffer,
    required String differentiationOpportunity,
  }) : super._(
         alternativeType: alternativeType,
         whatTheyOffer: whatTheyOffer,
         differentiationOpportunity: differentiationOpportunity,
       );

  /// Returns a shallow copy of this [CompetitorHypothesis]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CompetitorHypothesis copyWith({
    String? alternativeType,
    String? whatTheyOffer,
    String? differentiationOpportunity,
  }) {
    return CompetitorHypothesis(
      alternativeType: alternativeType ?? this.alternativeType,
      whatTheyOffer: whatTheyOffer ?? this.whatTheyOffer,
      differentiationOpportunity:
          differentiationOpportunity ?? this.differentiationOpportunity,
    );
  }
}
