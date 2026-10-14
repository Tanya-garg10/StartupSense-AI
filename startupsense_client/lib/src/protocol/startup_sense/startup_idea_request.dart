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

abstract class StartupIdeaRequest
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  StartupIdeaRequest._({
    required this.startupName,
    required this.description,
    required this.industry,
    required this.targetCustomer,
    required this.geography,
    required this.estimatedBudget,
    required this.stage,
  });

  factory StartupIdeaRequest({
    required String startupName,
    required String description,
    required String industry,
    required String targetCustomer,
    required String geography,
    required double estimatedBudget,
    required String stage,
  }) = _StartupIdeaRequestImpl;

  factory StartupIdeaRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return StartupIdeaRequest(
      startupName: jsonSerialization['startupName'] as String,
      description: jsonSerialization['description'] as String,
      industry: jsonSerialization['industry'] as String,
      targetCustomer: jsonSerialization['targetCustomer'] as String,
      geography: jsonSerialization['geography'] as String,
      estimatedBudget: (jsonSerialization['estimatedBudget'] as num).toDouble(),
      stage: jsonSerialization['stage'] as String,
    );
  }

  String startupName;

  String description;

  String industry;

  String targetCustomer;

  String geography;

  double estimatedBudget;

  String stage;

  /// Returns a shallow copy of this [StartupIdeaRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  StartupIdeaRequest copyWith({
    String? startupName,
    String? description,
    String? industry,
    String? targetCustomer,
    String? geography,
    double? estimatedBudget,
    String? stage,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StartupIdeaRequest',
      'startupName': startupName,
      'description': description,
      'industry': industry,
      'targetCustomer': targetCustomer,
      'geography': geography,
      'estimatedBudget': estimatedBudget,
      'stage': stage,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StartupIdeaRequest',
      'startupName': startupName,
      'description': description,
      'industry': industry,
      'targetCustomer': targetCustomer,
      'geography': geography,
      'estimatedBudget': estimatedBudget,
      'stage': stage,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _StartupIdeaRequestImpl extends StartupIdeaRequest {
  _StartupIdeaRequestImpl({
    required String startupName,
    required String description,
    required String industry,
    required String targetCustomer,
    required String geography,
    required double estimatedBudget,
    required String stage,
  }) : super._(
         startupName: startupName,
         description: description,
         industry: industry,
         targetCustomer: targetCustomer,
         geography: geography,
         estimatedBudget: estimatedBudget,
         stage: stage,
       );

  /// Returns a shallow copy of this [StartupIdeaRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  StartupIdeaRequest copyWith({
    String? startupName,
    String? description,
    String? industry,
    String? targetCustomer,
    String? geography,
    double? estimatedBudget,
    String? stage,
  }) {
    return StartupIdeaRequest(
      startupName: startupName ?? this.startupName,
      description: description ?? this.description,
      industry: industry ?? this.industry,
      targetCustomer: targetCustomer ?? this.targetCustomer,
      geography: geography ?? this.geography,
      estimatedBudget: estimatedBudget ?? this.estimatedBudget,
      stage: stage ?? this.stage,
    );
  }
}
