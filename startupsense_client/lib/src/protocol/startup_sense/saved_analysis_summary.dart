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

abstract class SavedAnalysisSummary
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SavedAnalysisSummary._({
    required this.id,
    required this.startupName,
    required this.industry,
    required this.createdAt,
    required this.status,
    required this.isDemo,
  });

  factory SavedAnalysisSummary({
    required int id,
    required String startupName,
    required String industry,
    required DateTime createdAt,
    required String status,
    required bool isDemo,
  }) = _SavedAnalysisSummaryImpl;

  factory SavedAnalysisSummary.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return SavedAnalysisSummary(
      id: jsonSerialization['id'] as int,
      startupName: jsonSerialization['startupName'] as String,
      industry: jsonSerialization['industry'] as String,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      status: jsonSerialization['status'] as String,
      isDemo: _isc.BoolJsonExtension.fromJson(jsonSerialization['isDemo']),
    );
  }

  int id;

  String startupName;

  String industry;

  DateTime createdAt;

  String status;

  bool isDemo;

  /// Returns a shallow copy of this [SavedAnalysisSummary]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SavedAnalysisSummary copyWith({
    int? id,
    String? startupName,
    String? industry,
    DateTime? createdAt,
    String? status,
    bool? isDemo,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SavedAnalysisSummary',
      'id': id,
      'startupName': startupName,
      'industry': industry,
      'createdAt': createdAt.toJson(),
      'status': status,
      'isDemo': isDemo,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SavedAnalysisSummary',
      'id': id,
      'startupName': startupName,
      'industry': industry,
      'createdAt': createdAt.toJson(),
      'status': status,
      'isDemo': isDemo,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _SavedAnalysisSummaryImpl extends SavedAnalysisSummary {
  _SavedAnalysisSummaryImpl({
    required int id,
    required String startupName,
    required String industry,
    required DateTime createdAt,
    required String status,
    required bool isDemo,
  }) : super._(
         id: id,
         startupName: startupName,
         industry: industry,
         createdAt: createdAt,
         status: status,
         isDemo: isDemo,
       );

  /// Returns a shallow copy of this [SavedAnalysisSummary]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SavedAnalysisSummary copyWith({
    int? id,
    String? startupName,
    String? industry,
    DateTime? createdAt,
    String? status,
    bool? isDemo,
  }) {
    return SavedAnalysisSummary(
      id: id ?? this.id,
      startupName: startupName ?? this.startupName,
      industry: industry ?? this.industry,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      isDemo: isDemo ?? this.isDemo,
    );
  }
}
