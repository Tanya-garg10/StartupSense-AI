/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/protocol.dart' as _isp;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'package:startupsense_server/src/generated/startup_sense/saved_analysis_summary.dart'
    as _ieo2d5nb;
import 'greetings/greeting.dart' as _izw8z7ou;
import 'startup_sense/analysis_report.dart' as _im17xmtm;
import 'startup_sense/analysis_response.dart' as _il4xchxd;
import 'startup_sense/competitor_hypothesis.dart' as _idcln4z5;
import 'startup_sense/customer_persona.dart' as _i0v5brld;
import 'startup_sense/risk_item.dart' as _i5asphkq;
import 'startup_sense/roadmap_week.dart' as _ia5pwueh;
import 'startup_sense/saved_analysis_summary.dart' as _ir34hhvp;
import 'startup_sense/startup_analysis_record.dart' as _igmxhl8k;
import 'startup_sense/startup_idea_request.dart' as _ik46y0kf;
import 'startup_sense/startup_sense_error.dart' as _ihgxf4ra;
import 'startup_sense/validation_experiment.dart' as _i0iivi3j;
export 'greetings/greeting.dart';
export 'startup_sense/analysis_report.dart';
export 'startup_sense/analysis_response.dart';
export 'startup_sense/competitor_hypothesis.dart';
export 'startup_sense/customer_persona.dart';
export 'startup_sense/risk_item.dart';
export 'startup_sense/roadmap_week.dart';
export 'startup_sense/saved_analysis_summary.dart';
export 'startup_sense/startup_analysis_record.dart';
export 'startup_sense/startup_idea_request.dart';
export 'startup_sense/startup_sense_error.dart';
export 'startup_sense/validation_experiment.dart';

class Protocol extends _is.DatabaseSerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static List<_isp.TableDefinition> get targetTableDefinitions => [
    _isp.TableDefinition(
      name: 'startup_analysis',
      dartName: 'StartupAnalysisRecord',
      schema: 'public',
      module: 'startupsense',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'authUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'startupName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'industry',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'stage',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'ideaJson',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'reportJson',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'analysisMode',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'startup_analysis_user_created_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._iais.Protocol.targetTableDefinitions,
    ..._iacs.Protocol.targetTableDefinitions,
    ..._isp.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _is.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _izw8z7ou.Greeting) {
      return _izw8z7ou.Greeting.fromJson(data) as T;
    }
    if (t == _im17xmtm.AnalysisReport) {
      return _im17xmtm.AnalysisReport.fromJson(data) as T;
    }
    if (t == _il4xchxd.AnalysisResponse) {
      return _il4xchxd.AnalysisResponse.fromJson(data) as T;
    }
    if (t == _idcln4z5.CompetitorHypothesis) {
      return _idcln4z5.CompetitorHypothesis.fromJson(data) as T;
    }
    if (t == _i0v5brld.CustomerPersona) {
      return _i0v5brld.CustomerPersona.fromJson(data) as T;
    }
    if (t == _i5asphkq.RiskItem) {
      return _i5asphkq.RiskItem.fromJson(data) as T;
    }
    if (t == _ia5pwueh.RoadmapWeek) {
      return _ia5pwueh.RoadmapWeek.fromJson(data) as T;
    }
    if (t == _ir34hhvp.SavedAnalysisSummary) {
      return _ir34hhvp.SavedAnalysisSummary.fromJson(data) as T;
    }
    if (t == _igmxhl8k.StartupAnalysisRecord) {
      return _igmxhl8k.StartupAnalysisRecord.fromJson(data) as T;
    }
    if (t == _ik46y0kf.StartupIdeaRequest) {
      return _ik46y0kf.StartupIdeaRequest.fromJson(data) as T;
    }
    if (t == _ihgxf4ra.StartupSenseError) {
      return _ihgxf4ra.StartupSenseError.fromJson(data) as T;
    }
    if (t == _i0iivi3j.ValidationExperiment) {
      return _i0iivi3j.ValidationExperiment.fromJson(data) as T;
    }
    if (t == _is.getType<_izw8z7ou.Greeting?>()) {
      return (data != null ? _izw8z7ou.Greeting.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_im17xmtm.AnalysisReport?>()) {
      return (data != null ? _im17xmtm.AnalysisReport.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_il4xchxd.AnalysisResponse?>()) {
      return (data != null ? _il4xchxd.AnalysisResponse.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_idcln4z5.CompetitorHypothesis?>()) {
      return (data != null
              ? _idcln4z5.CompetitorHypothesis.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i0v5brld.CustomerPersona?>()) {
      return (data != null ? _i0v5brld.CustomerPersona.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i5asphkq.RiskItem?>()) {
      return (data != null ? _i5asphkq.RiskItem.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ia5pwueh.RoadmapWeek?>()) {
      return (data != null ? _ia5pwueh.RoadmapWeek.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ir34hhvp.SavedAnalysisSummary?>()) {
      return (data != null
              ? _ir34hhvp.SavedAnalysisSummary.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_igmxhl8k.StartupAnalysisRecord?>()) {
      return (data != null
              ? _igmxhl8k.StartupAnalysisRecord.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ik46y0kf.StartupIdeaRequest?>()) {
      return (data != null ? _ik46y0kf.StartupIdeaRequest.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ihgxf4ra.StartupSenseError?>()) {
      return (data != null ? _ihgxf4ra.StartupSenseError.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i0iivi3j.ValidationExperiment?>()) {
      return (data != null
              ? _i0iivi3j.ValidationExperiment.fromJson(data)
              : null)
          as T;
    }
    if (t == List<_i0v5brld.CustomerPersona>) {
      return (data as List)
              .map((e) => deserialize<_i0v5brld.CustomerPersona>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_idcln4z5.CompetitorHypothesis>) {
      return (data as List)
              .map((e) => deserialize<_idcln4z5.CompetitorHypothesis>(e))
              .toList()
          as T;
    }
    if (t == List<_i5asphkq.RiskItem>) {
      return (data as List)
              .map((e) => deserialize<_i5asphkq.RiskItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i0iivi3j.ValidationExperiment>) {
      return (data as List)
              .map((e) => deserialize<_i0iivi3j.ValidationExperiment>(e))
              .toList()
          as T;
    }
    if (t == List<_ia5pwueh.RoadmapWeek>) {
      return (data as List)
              .map((e) => deserialize<_ia5pwueh.RoadmapWeek>(e))
              .toList()
          as T;
    }
    if (t == List<_ieo2d5nb.SavedAnalysisSummary>) {
      return (data as List)
              .map((e) => deserialize<_ieo2d5nb.SavedAnalysisSummary>(e))
              .toList()
          as T;
    }
    try {
      return _iais.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacs.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _isp.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _izw8z7ou.Greeting => 'Greeting',
      _im17xmtm.AnalysisReport => 'AnalysisReport',
      _il4xchxd.AnalysisResponse => 'AnalysisResponse',
      _idcln4z5.CompetitorHypothesis => 'CompetitorHypothesis',
      _i0v5brld.CustomerPersona => 'CustomerPersona',
      _i5asphkq.RiskItem => 'RiskItem',
      _ia5pwueh.RoadmapWeek => 'RoadmapWeek',
      _ir34hhvp.SavedAnalysisSummary => 'SavedAnalysisSummary',
      _igmxhl8k.StartupAnalysisRecord => 'StartupAnalysisRecord',
      _ik46y0kf.StartupIdeaRequest => 'StartupIdeaRequest',
      _ihgxf4ra.StartupSenseError => 'StartupSenseError',
      _i0iivi3j.ValidationExperiment => 'ValidationExperiment',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst(
        'startupsense.',
        '',
      );
    }

    switch (data) {
      case _izw8z7ou.Greeting():
        return 'Greeting';
      case _im17xmtm.AnalysisReport():
        return 'AnalysisReport';
      case _il4xchxd.AnalysisResponse():
        return 'AnalysisResponse';
      case _idcln4z5.CompetitorHypothesis():
        return 'CompetitorHypothesis';
      case _i0v5brld.CustomerPersona():
        return 'CustomerPersona';
      case _i5asphkq.RiskItem():
        return 'RiskItem';
      case _ia5pwueh.RoadmapWeek():
        return 'RoadmapWeek';
      case _ir34hhvp.SavedAnalysisSummary():
        return 'SavedAnalysisSummary';
      case _igmxhl8k.StartupAnalysisRecord():
        return 'StartupAnalysisRecord';
      case _ik46y0kf.StartupIdeaRequest():
        return 'StartupIdeaRequest';
      case _ihgxf4ra.StartupSenseError():
        return 'StartupSenseError';
      case _i0iivi3j.ValidationExperiment():
        return 'ValidationExperiment';
    }
    className = _iais.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacs.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    className = _isp.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_izw8z7ou.Greeting>(data['data']);
    }
    if (dataClassName == 'AnalysisReport') {
      return deserialize<_im17xmtm.AnalysisReport>(data['data']);
    }
    if (dataClassName == 'AnalysisResponse') {
      return deserialize<_il4xchxd.AnalysisResponse>(data['data']);
    }
    if (dataClassName == 'CompetitorHypothesis') {
      return deserialize<_idcln4z5.CompetitorHypothesis>(data['data']);
    }
    if (dataClassName == 'CustomerPersona') {
      return deserialize<_i0v5brld.CustomerPersona>(data['data']);
    }
    if (dataClassName == 'RiskItem') {
      return deserialize<_i5asphkq.RiskItem>(data['data']);
    }
    if (dataClassName == 'RoadmapWeek') {
      return deserialize<_ia5pwueh.RoadmapWeek>(data['data']);
    }
    if (dataClassName == 'SavedAnalysisSummary') {
      return deserialize<_ir34hhvp.SavedAnalysisSummary>(data['data']);
    }
    if (dataClassName == 'StartupAnalysisRecord') {
      return deserialize<_igmxhl8k.StartupAnalysisRecord>(data['data']);
    }
    if (dataClassName == 'StartupIdeaRequest') {
      return deserialize<_ik46y0kf.StartupIdeaRequest>(data['data']);
    }
    if (dataClassName == 'StartupSenseError') {
      return deserialize<_ihgxf4ra.StartupSenseError>(data['data']);
    }
    if (dataClassName == 'ValidationExperiment') {
      return deserialize<_i0iivi3j.ValidationExperiment>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iais.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacs.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _isp.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iais.Protocol().registerHostProtocol('startupsense', this);
    _iacs.Protocol().registerHostProtocol('startupsense', this);
  }

  @override
  _is.Table? getTableForType(Type t) {
    {
      var table = _iais.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _iacs.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _isp.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _igmxhl8k.StartupAnalysisRecord:
        return _igmxhl8k.StartupAnalysisRecord.t;
    }
    return null;
  }

  @override
  List<_isp.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'startupsense';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iais.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacs.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
