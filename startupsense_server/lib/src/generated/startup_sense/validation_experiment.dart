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

abstract class ValidationExperiment
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ValidationExperiment._({
    required this.title,
    required this.hypothesis,
    required this.method,
    required this.successSignal,
    required this.estimatedDays,
  });

  factory ValidationExperiment({
    required String title,
    required String hypothesis,
    required String method,
    required String successSignal,
    required int estimatedDays,
  }) = _ValidationExperimentImpl;

  factory ValidationExperiment.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ValidationExperiment(
      title: jsonSerialization['title'] as String,
      hypothesis: jsonSerialization['hypothesis'] as String,
      method: jsonSerialization['method'] as String,
      successSignal: jsonSerialization['successSignal'] as String,
      estimatedDays: jsonSerialization['estimatedDays'] as int,
    );
  }

  String title;

  String hypothesis;

  String method;

  String successSignal;

  int estimatedDays;

  /// Returns a shallow copy of this [ValidationExperiment]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ValidationExperiment copyWith({
    String? title,
    String? hypothesis,
    String? method,
    String? successSignal,
    int? estimatedDays,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ValidationExperiment',
      'title': title,
      'hypothesis': hypothesis,
      'method': method,
      'successSignal': successSignal,
      'estimatedDays': estimatedDays,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ValidationExperiment',
      'title': title,
      'hypothesis': hypothesis,
      'method': method,
      'successSignal': successSignal,
      'estimatedDays': estimatedDays,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _ValidationExperimentImpl extends ValidationExperiment {
  _ValidationExperimentImpl({
    required String title,
    required String hypothesis,
    required String method,
    required String successSignal,
    required int estimatedDays,
  }) : super._(
         title: title,
         hypothesis: hypothesis,
         method: method,
         successSignal: successSignal,
         estimatedDays: estimatedDays,
       );

  /// Returns a shallow copy of this [ValidationExperiment]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ValidationExperiment copyWith({
    String? title,
    String? hypothesis,
    String? method,
    String? successSignal,
    int? estimatedDays,
  }) {
    return ValidationExperiment(
      title: title ?? this.title,
      hypothesis: hypothesis ?? this.hypothesis,
      method: method ?? this.method,
      successSignal: successSignal ?? this.successSignal,
      estimatedDays: estimatedDays ?? this.estimatedDays,
    );
  }
}
