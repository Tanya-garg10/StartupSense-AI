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
import 'package:startupsense_client/src/protocol/protocol.dart' as _i2ee7cqs;
import '../startup_sense/analysis_report.dart' as _i4jraqq2;
import '../startup_sense/startup_idea_request.dart' as _i8l4eccy;

abstract class AnalysisResponse
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AnalysisResponse._({
    required this.id,
    required this.createdAt,
    required this.idea,
    required this.report,
    required this.mode,
  });

  factory AnalysisResponse({
    required int id,
    required DateTime createdAt,
    required _i8l4eccy.StartupIdeaRequest idea,
    required _i4jraqq2.AnalysisReport report,
    required String mode,
  }) = _AnalysisResponseImpl;

  factory AnalysisResponse.fromJson(Map<String, dynamic> jsonSerialization) {
    return AnalysisResponse(
      id: jsonSerialization['id'] as int,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      idea: _i2ee7cqs.Protocol().deserialize<_i8l4eccy.StartupIdeaRequest>(
        jsonSerialization['idea'],
      ),
      report: _i2ee7cqs.Protocol().deserialize<_i4jraqq2.AnalysisReport>(
        jsonSerialization['report'],
      ),
      mode: jsonSerialization['mode'] as String,
    );
  }

  int id;

  DateTime createdAt;

  _i8l4eccy.StartupIdeaRequest idea;

  _i4jraqq2.AnalysisReport report;

  String mode;

  /// Returns a shallow copy of this [AnalysisResponse]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AnalysisResponse copyWith({
    int? id,
    DateTime? createdAt,
    _i8l4eccy.StartupIdeaRequest? idea,
    _i4jraqq2.AnalysisReport? report,
    String? mode,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AnalysisResponse',
      'id': id,
      'createdAt': createdAt.toJson(),
      'idea': idea.toJson(),
      'report': report.toJson(),
      'mode': mode,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AnalysisResponse',
      'id': id,
      'createdAt': createdAt.toJson(),
      'idea': idea.toJsonForProtocol(),
      'report': report.toJsonForProtocol(),
      'mode': mode,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _AnalysisResponseImpl extends AnalysisResponse {
  _AnalysisResponseImpl({
    required int id,
    required DateTime createdAt,
    required _i8l4eccy.StartupIdeaRequest idea,
    required _i4jraqq2.AnalysisReport report,
    required String mode,
  }) : super._(
         id: id,
         createdAt: createdAt,
         idea: idea,
         report: report,
         mode: mode,
       );

  /// Returns a shallow copy of this [AnalysisResponse]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AnalysisResponse copyWith({
    int? id,
    DateTime? createdAt,
    _i8l4eccy.StartupIdeaRequest? idea,
    _i4jraqq2.AnalysisReport? report,
    String? mode,
  }) {
    return AnalysisResponse(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      idea: idea ?? this.idea.copyWith(),
      report: report ?? this.report.copyWith(),
      mode: mode ?? this.mode,
    );
  }
}
