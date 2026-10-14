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

abstract class RoadmapWeek
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RoadmapWeek._({
    required this.week,
    required this.theme,
    required this.tasks,
  });

  factory RoadmapWeek({
    required int week,
    required String theme,
    required List<String> tasks,
  }) = _RoadmapWeekImpl;

  factory RoadmapWeek.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoadmapWeek(
      week: jsonSerialization['week'] as int,
      theme: jsonSerialization['theme'] as String,
      tasks: _i2ee7cqs.Protocol().deserialize<List<String>>(
        jsonSerialization['tasks'],
      ),
    );
  }

  int week;

  String theme;

  List<String> tasks;

  /// Returns a shallow copy of this [RoadmapWeek]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RoadmapWeek copyWith({
    int? week,
    String? theme,
    List<String>? tasks,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RoadmapWeek',
      'week': week,
      'theme': theme,
      'tasks': tasks.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RoadmapWeek',
      'week': week,
      'theme': theme,
      'tasks': tasks.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _RoadmapWeekImpl extends RoadmapWeek {
  _RoadmapWeekImpl({
    required int week,
    required String theme,
    required List<String> tasks,
  }) : super._(
         week: week,
         theme: theme,
         tasks: tasks,
       );

  /// Returns a shallow copy of this [RoadmapWeek]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RoadmapWeek copyWith({
    int? week,
    String? theme,
    List<String>? tasks,
  }) {
    return RoadmapWeek(
      week: week ?? this.week,
      theme: theme ?? this.theme,
      tasks: tasks ?? this.tasks.map((e0) => e0).toList(),
    );
  }
}
