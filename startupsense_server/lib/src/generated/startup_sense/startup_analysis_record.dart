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

abstract class StartupAnalysisRecord
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  StartupAnalysisRecord._({
    this.id,
    required this.authUserId,
    required this.startupName,
    required this.industry,
    required this.stage,
    required this.ideaJson,
    required this.reportJson,
    required this.analysisMode,
    required this.status,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory StartupAnalysisRecord({
    int? id,
    required _is.UuidValue authUserId,
    required String startupName,
    required String industry,
    required String stage,
    required String ideaJson,
    required String reportJson,
    required String analysisMode,
    required String status,
    DateTime? createdAt,
  }) = _StartupAnalysisRecordImpl;

  factory StartupAnalysisRecord.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return StartupAnalysisRecord(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      startupName: jsonSerialization['startupName'] as String,
      industry: jsonSerialization['industry'] as String,
      stage: jsonSerialization['stage'] as String,
      ideaJson: jsonSerialization['ideaJson'] as String,
      reportJson: jsonSerialization['reportJson'] as String,
      analysisMode: jsonSerialization['analysisMode'] as String,
      status: jsonSerialization['status'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = StartupAnalysisRecordTable();

  static const db = StartupAnalysisRecordRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  String startupName;

  String industry;

  String stage;

  String ideaJson;

  String reportJson;

  String analysisMode;

  String status;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [StartupAnalysisRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  StartupAnalysisRecord copyWith({
    int? id,
    _is.UuidValue? authUserId,
    String? startupName,
    String? industry,
    String? stage,
    String? ideaJson,
    String? reportJson,
    String? analysisMode,
    String? status,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StartupAnalysisRecord',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'startupName': startupName,
      'industry': industry,
      'stage': stage,
      'ideaJson': ideaJson,
      'reportJson': reportJson,
      'analysisMode': analysisMode,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static StartupAnalysisRecordInclude include() {
    return StartupAnalysisRecordInclude._();
  }

  static StartupAnalysisRecordIncludeList includeList({
    _is.WhereExpressionBuilder<StartupAnalysisRecordTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StartupAnalysisRecordTable>? orderBy,
    _is.OrderByListBuilder<StartupAnalysisRecordTable>? orderByList,
    StartupAnalysisRecordInclude? include,
  }) {
    return StartupAnalysisRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StartupAnalysisRecord.t),
      orderByList: orderByList?.call(StartupAnalysisRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StartupAnalysisRecordImpl extends StartupAnalysisRecord {
  _StartupAnalysisRecordImpl({
    int? id,
    required _is.UuidValue authUserId,
    required String startupName,
    required String industry,
    required String stage,
    required String ideaJson,
    required String reportJson,
    required String analysisMode,
    required String status,
    DateTime? createdAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         startupName: startupName,
         industry: industry,
         stage: stage,
         ideaJson: ideaJson,
         reportJson: reportJson,
         analysisMode: analysisMode,
         status: status,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [StartupAnalysisRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  StartupAnalysisRecord copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    String? startupName,
    String? industry,
    String? stage,
    String? ideaJson,
    String? reportJson,
    String? analysisMode,
    String? status,
    DateTime? createdAt,
  }) {
    return StartupAnalysisRecord(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      startupName: startupName ?? this.startupName,
      industry: industry ?? this.industry,
      stage: stage ?? this.stage,
      ideaJson: ideaJson ?? this.ideaJson,
      reportJson: reportJson ?? this.reportJson,
      analysisMode: analysisMode ?? this.analysisMode,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class StartupAnalysisRecordUpdateTable
    extends _is.UpdateTable<StartupAnalysisRecordTable> {
  StartupAnalysisRecordUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> startupName(String value) => _is.ColumnValue(
    table.startupName,
    value,
  );

  _is.ColumnValue<String, String> industry(String value) => _is.ColumnValue(
    table.industry,
    value,
  );

  _is.ColumnValue<String, String> stage(String value) => _is.ColumnValue(
    table.stage,
    value,
  );

  _is.ColumnValue<String, String> ideaJson(String value) => _is.ColumnValue(
    table.ideaJson,
    value,
  );

  _is.ColumnValue<String, String> reportJson(String value) => _is.ColumnValue(
    table.reportJson,
    value,
  );

  _is.ColumnValue<String, String> analysisMode(String value) => _is.ColumnValue(
    table.analysisMode,
    value,
  );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class StartupAnalysisRecordTable extends _is.Table<int?> {
  StartupAnalysisRecordTable({super.tableRelation})
    : super(tableName: 'startup_analysis') {
    updateTable = StartupAnalysisRecordUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    startupName = _is.ColumnString(
      'startupName',
      this,
    );
    industry = _is.ColumnString(
      'industry',
      this,
    );
    stage = _is.ColumnString(
      'stage',
      this,
    );
    ideaJson = _is.ColumnString(
      'ideaJson',
      this,
    );
    reportJson = _is.ColumnString(
      'reportJson',
      this,
    );
    analysisMode = _is.ColumnString(
      'analysisMode',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final StartupAnalysisRecordUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnString startupName;

  late final _is.ColumnString industry;

  late final _is.ColumnString stage;

  late final _is.ColumnString ideaJson;

  late final _is.ColumnString reportJson;

  late final _is.ColumnString analysisMode;

  late final _is.ColumnString status;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    startupName,
    industry,
    stage,
    ideaJson,
    reportJson,
    analysisMode,
    status,
    createdAt,
  ];
}

class StartupAnalysisRecordInclude extends _is.IncludeObject {
  StartupAnalysisRecordInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => StartupAnalysisRecord.t;
}

class StartupAnalysisRecordIncludeList extends _is.IncludeList {
  StartupAnalysisRecordIncludeList._({
    _is.WhereExpressionBuilder<StartupAnalysisRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StartupAnalysisRecord.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => StartupAnalysisRecord.t;
}

class StartupAnalysisRecordRepository {
  const StartupAnalysisRecordRepository._();

  /// Returns a list of [StartupAnalysisRecord]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<StartupAnalysisRecord>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StartupAnalysisRecordTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StartupAnalysisRecordTable>? orderBy,
    _is.OrderByListBuilder<StartupAnalysisRecordTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<StartupAnalysisRecord>(
      where: where?.call(StartupAnalysisRecord.t),
      orderBy: orderBy?.call(StartupAnalysisRecord.t),
      orderByList: orderByList?.call(StartupAnalysisRecord.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [StartupAnalysisRecord] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<StartupAnalysisRecord?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StartupAnalysisRecordTable>? where,
    int? offset,
    _is.OrderByBuilder<StartupAnalysisRecordTable>? orderBy,
    _is.OrderByListBuilder<StartupAnalysisRecordTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<StartupAnalysisRecord>(
      where: where?.call(StartupAnalysisRecord.t),
      orderBy: orderBy?.call(StartupAnalysisRecord.t),
      orderByList: orderByList?.call(StartupAnalysisRecord.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [StartupAnalysisRecord] by its [id] or null if no such row exists.
  Future<StartupAnalysisRecord?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<StartupAnalysisRecord>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [StartupAnalysisRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [StartupAnalysisRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StartupAnalysisRecord>> insert(
    _is.DatabaseSession session,
    List<StartupAnalysisRecord> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<StartupAnalysisRecord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [StartupAnalysisRecord] and returns the inserted row.
  ///
  /// The returned [StartupAnalysisRecord] will have its `id` field set.
  Future<StartupAnalysisRecord> insertRow(
    _is.DatabaseSession session,
    StartupAnalysisRecord row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<StartupAnalysisRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [StartupAnalysisRecord]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [StartupAnalysisRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StartupAnalysisRecord>> upsert(
    _is.DatabaseSession session,
    List<StartupAnalysisRecord> rows, {
    required _is.ColumnSelections<StartupAnalysisRecordTable> conflictColumns,
    _is.ColumnSelections<StartupAnalysisRecordTable>? updateColumns,
    _is.WhereExpressionBuilder<StartupAnalysisRecordTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<StartupAnalysisRecord>(
      rows,
      conflictColumns: conflictColumns(StartupAnalysisRecord.t),
      updateColumns: updateColumns?.call(StartupAnalysisRecord.t),
      updateWhere: updateWhere?.call(StartupAnalysisRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [StartupAnalysisRecord] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [StartupAnalysisRecord] will have its `id` field set.
  Future<StartupAnalysisRecord?> upsertRow(
    _is.DatabaseSession session,
    StartupAnalysisRecord row, {
    required _is.ColumnSelections<StartupAnalysisRecordTable> conflictColumns,
    _is.ColumnSelections<StartupAnalysisRecordTable>? updateColumns,
    _is.WhereExpressionBuilder<StartupAnalysisRecordTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<StartupAnalysisRecord>(
      row,
      conflictColumns: conflictColumns(StartupAnalysisRecord.t),
      updateColumns: updateColumns?.call(StartupAnalysisRecord.t),
      updateWhere: updateWhere?.call(StartupAnalysisRecord.t),
      transaction: transaction,
    );
  }

  /// Updates all [StartupAnalysisRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StartupAnalysisRecord>> update(
    _is.DatabaseSession session,
    List<StartupAnalysisRecord> rows, {
    _is.ColumnSelections<StartupAnalysisRecordTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<StartupAnalysisRecord>(
      rows,
      columns: columns?.call(StartupAnalysisRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [StartupAnalysisRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StartupAnalysisRecord> updateRow(
    _is.DatabaseSession session,
    StartupAnalysisRecord row, {
    _is.ColumnSelections<StartupAnalysisRecordTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<StartupAnalysisRecord>(
      row,
      columns: columns?.call(StartupAnalysisRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StartupAnalysisRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<StartupAnalysisRecord?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<StartupAnalysisRecordUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<StartupAnalysisRecord>(
      id,
      columnValues: columnValues(StartupAnalysisRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StartupAnalysisRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StartupAnalysisRecord>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<StartupAnalysisRecordUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<StartupAnalysisRecordTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StartupAnalysisRecordTable>? orderBy,
    _is.OrderByListBuilder<StartupAnalysisRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<StartupAnalysisRecord>(
      columnValues: columnValues(StartupAnalysisRecord.t.updateTable),
      where: where(StartupAnalysisRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StartupAnalysisRecord.t),
      orderByList: orderByList?.call(StartupAnalysisRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [StartupAnalysisRecord]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StartupAnalysisRecord>> delete(
    _is.DatabaseSession session,
    List<StartupAnalysisRecord> rows, {
    _is.OrderByBuilder<StartupAnalysisRecordTable>? orderBy,
    _is.OrderByListBuilder<StartupAnalysisRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<StartupAnalysisRecord>(
      rows,
      orderBy: orderBy?.call(StartupAnalysisRecord.t),
      orderByList: orderByList?.call(StartupAnalysisRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [StartupAnalysisRecord].
  Future<StartupAnalysisRecord> deleteRow(
    _is.DatabaseSession session,
    StartupAnalysisRecord row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StartupAnalysisRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StartupAnalysisRecord>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StartupAnalysisRecordTable> where,
    _is.OrderByBuilder<StartupAnalysisRecordTable>? orderBy,
    _is.OrderByListBuilder<StartupAnalysisRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<StartupAnalysisRecord>(
      where: where(StartupAnalysisRecord.t),
      orderBy: orderBy?.call(StartupAnalysisRecord.t),
      orderByList: orderByList?.call(StartupAnalysisRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StartupAnalysisRecordTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<StartupAnalysisRecord>(
      where: where?.call(StartupAnalysisRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [StartupAnalysisRecord] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StartupAnalysisRecordTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<StartupAnalysisRecord>(
      where: where(StartupAnalysisRecord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
