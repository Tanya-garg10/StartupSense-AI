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
import '../startup_sense/competitor_hypothesis.dart' as _i5wqm5qy;
import '../startup_sense/customer_persona.dart' as _i72ghpkh;
import '../startup_sense/risk_item.dart' as _i1m37vcs;
import '../startup_sense/roadmap_week.dart' as _is6chyy5;
import '../startup_sense/validation_experiment.dart' as _iin9nfqn;

abstract class AnalysisReport
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AnalysisReport._({
    required this.executiveSummary,
    required this.problem,
    required this.solution,
    required this.fitAssessment,
    required this.targetCustomers,
    required this.marketOpportunity,
    required this.marketAssumptions,
    required this.competitorHypotheses,
    required this.strengths,
    required this.weaknesses,
    required this.opportunities,
    required this.threats,
    required this.businessModel,
    required this.revenueStreams,
    required this.risks,
    required this.experiments,
    required this.mvpRecommendations,
    required this.roadmap,
    required this.evidenceDisclaimer,
  });

  factory AnalysisReport({
    required String executiveSummary,
    required String problem,
    required String solution,
    required String fitAssessment,
    required List<_i72ghpkh.CustomerPersona> targetCustomers,
    required String marketOpportunity,
    required List<String> marketAssumptions,
    required List<_i5wqm5qy.CompetitorHypothesis> competitorHypotheses,
    required List<String> strengths,
    required List<String> weaknesses,
    required List<String> opportunities,
    required List<String> threats,
    required String businessModel,
    required List<String> revenueStreams,
    required List<_i1m37vcs.RiskItem> risks,
    required List<_iin9nfqn.ValidationExperiment> experiments,
    required List<String> mvpRecommendations,
    required List<_is6chyy5.RoadmapWeek> roadmap,
    required String evidenceDisclaimer,
  }) = _AnalysisReportImpl;

  factory AnalysisReport.fromJson(Map<String, dynamic> jsonSerialization) {
    return AnalysisReport(
      executiveSummary: jsonSerialization['executiveSummary'] as String,
      problem: jsonSerialization['problem'] as String,
      solution: jsonSerialization['solution'] as String,
      fitAssessment: jsonSerialization['fitAssessment'] as String,
      targetCustomers: _i2ee7cqs.Protocol()
          .deserialize<List<_i72ghpkh.CustomerPersona>>(
            jsonSerialization['targetCustomers'],
          ),
      marketOpportunity: jsonSerialization['marketOpportunity'] as String,
      marketAssumptions: _i2ee7cqs.Protocol().deserialize<List<String>>(
        jsonSerialization['marketAssumptions'],
      ),
      competitorHypotheses: _i2ee7cqs.Protocol()
          .deserialize<List<_i5wqm5qy.CompetitorHypothesis>>(
            jsonSerialization['competitorHypotheses'],
          ),
      strengths: _i2ee7cqs.Protocol().deserialize<List<String>>(
        jsonSerialization['strengths'],
      ),
      weaknesses: _i2ee7cqs.Protocol().deserialize<List<String>>(
        jsonSerialization['weaknesses'],
      ),
      opportunities: _i2ee7cqs.Protocol().deserialize<List<String>>(
        jsonSerialization['opportunities'],
      ),
      threats: _i2ee7cqs.Protocol().deserialize<List<String>>(
        jsonSerialization['threats'],
      ),
      businessModel: jsonSerialization['businessModel'] as String,
      revenueStreams: _i2ee7cqs.Protocol().deserialize<List<String>>(
        jsonSerialization['revenueStreams'],
      ),
      risks: _i2ee7cqs.Protocol().deserialize<List<_i1m37vcs.RiskItem>>(
        jsonSerialization['risks'],
      ),
      experiments: _i2ee7cqs.Protocol()
          .deserialize<List<_iin9nfqn.ValidationExperiment>>(
            jsonSerialization['experiments'],
          ),
      mvpRecommendations: _i2ee7cqs.Protocol().deserialize<List<String>>(
        jsonSerialization['mvpRecommendations'],
      ),
      roadmap: _i2ee7cqs.Protocol().deserialize<List<_is6chyy5.RoadmapWeek>>(
        jsonSerialization['roadmap'],
      ),
      evidenceDisclaimer: jsonSerialization['evidenceDisclaimer'] as String,
    );
  }

  String executiveSummary;

  String problem;

  String solution;

  String fitAssessment;

  List<_i72ghpkh.CustomerPersona> targetCustomers;

  String marketOpportunity;

  List<String> marketAssumptions;

  List<_i5wqm5qy.CompetitorHypothesis> competitorHypotheses;

  List<String> strengths;

  List<String> weaknesses;

  List<String> opportunities;

  List<String> threats;

  String businessModel;

  List<String> revenueStreams;

  List<_i1m37vcs.RiskItem> risks;

  List<_iin9nfqn.ValidationExperiment> experiments;

  List<String> mvpRecommendations;

  List<_is6chyy5.RoadmapWeek> roadmap;

  String evidenceDisclaimer;

  /// Returns a shallow copy of this [AnalysisReport]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AnalysisReport copyWith({
    String? executiveSummary,
    String? problem,
    String? solution,
    String? fitAssessment,
    List<_i72ghpkh.CustomerPersona>? targetCustomers,
    String? marketOpportunity,
    List<String>? marketAssumptions,
    List<_i5wqm5qy.CompetitorHypothesis>? competitorHypotheses,
    List<String>? strengths,
    List<String>? weaknesses,
    List<String>? opportunities,
    List<String>? threats,
    String? businessModel,
    List<String>? revenueStreams,
    List<_i1m37vcs.RiskItem>? risks,
    List<_iin9nfqn.ValidationExperiment>? experiments,
    List<String>? mvpRecommendations,
    List<_is6chyy5.RoadmapWeek>? roadmap,
    String? evidenceDisclaimer,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AnalysisReport',
      'executiveSummary': executiveSummary,
      'problem': problem,
      'solution': solution,
      'fitAssessment': fitAssessment,
      'targetCustomers': targetCustomers.toJson(valueToJson: (v) => v.toJson()),
      'marketOpportunity': marketOpportunity,
      'marketAssumptions': marketAssumptions.toJson(),
      'competitorHypotheses': competitorHypotheses.toJson(
        valueToJson: (v) => v.toJson(),
      ),
      'strengths': strengths.toJson(),
      'weaknesses': weaknesses.toJson(),
      'opportunities': opportunities.toJson(),
      'threats': threats.toJson(),
      'businessModel': businessModel,
      'revenueStreams': revenueStreams.toJson(),
      'risks': risks.toJson(valueToJson: (v) => v.toJson()),
      'experiments': experiments.toJson(valueToJson: (v) => v.toJson()),
      'mvpRecommendations': mvpRecommendations.toJson(),
      'roadmap': roadmap.toJson(valueToJson: (v) => v.toJson()),
      'evidenceDisclaimer': evidenceDisclaimer,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AnalysisReport',
      'executiveSummary': executiveSummary,
      'problem': problem,
      'solution': solution,
      'fitAssessment': fitAssessment,
      'targetCustomers': targetCustomers.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'marketOpportunity': marketOpportunity,
      'marketAssumptions': marketAssumptions.toJson(),
      'competitorHypotheses': competitorHypotheses.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'strengths': strengths.toJson(),
      'weaknesses': weaknesses.toJson(),
      'opportunities': opportunities.toJson(),
      'threats': threats.toJson(),
      'businessModel': businessModel,
      'revenueStreams': revenueStreams.toJson(),
      'risks': risks.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'experiments': experiments.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'mvpRecommendations': mvpRecommendations.toJson(),
      'roadmap': roadmap.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'evidenceDisclaimer': evidenceDisclaimer,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _AnalysisReportImpl extends AnalysisReport {
  _AnalysisReportImpl({
    required String executiveSummary,
    required String problem,
    required String solution,
    required String fitAssessment,
    required List<_i72ghpkh.CustomerPersona> targetCustomers,
    required String marketOpportunity,
    required List<String> marketAssumptions,
    required List<_i5wqm5qy.CompetitorHypothesis> competitorHypotheses,
    required List<String> strengths,
    required List<String> weaknesses,
    required List<String> opportunities,
    required List<String> threats,
    required String businessModel,
    required List<String> revenueStreams,
    required List<_i1m37vcs.RiskItem> risks,
    required List<_iin9nfqn.ValidationExperiment> experiments,
    required List<String> mvpRecommendations,
    required List<_is6chyy5.RoadmapWeek> roadmap,
    required String evidenceDisclaimer,
  }) : super._(
         executiveSummary: executiveSummary,
         problem: problem,
         solution: solution,
         fitAssessment: fitAssessment,
         targetCustomers: targetCustomers,
         marketOpportunity: marketOpportunity,
         marketAssumptions: marketAssumptions,
         competitorHypotheses: competitorHypotheses,
         strengths: strengths,
         weaknesses: weaknesses,
         opportunities: opportunities,
         threats: threats,
         businessModel: businessModel,
         revenueStreams: revenueStreams,
         risks: risks,
         experiments: experiments,
         mvpRecommendations: mvpRecommendations,
         roadmap: roadmap,
         evidenceDisclaimer: evidenceDisclaimer,
       );

  /// Returns a shallow copy of this [AnalysisReport]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AnalysisReport copyWith({
    String? executiveSummary,
    String? problem,
    String? solution,
    String? fitAssessment,
    List<_i72ghpkh.CustomerPersona>? targetCustomers,
    String? marketOpportunity,
    List<String>? marketAssumptions,
    List<_i5wqm5qy.CompetitorHypothesis>? competitorHypotheses,
    List<String>? strengths,
    List<String>? weaknesses,
    List<String>? opportunities,
    List<String>? threats,
    String? businessModel,
    List<String>? revenueStreams,
    List<_i1m37vcs.RiskItem>? risks,
    List<_iin9nfqn.ValidationExperiment>? experiments,
    List<String>? mvpRecommendations,
    List<_is6chyy5.RoadmapWeek>? roadmap,
    String? evidenceDisclaimer,
  }) {
    return AnalysisReport(
      executiveSummary: executiveSummary ?? this.executiveSummary,
      problem: problem ?? this.problem,
      solution: solution ?? this.solution,
      fitAssessment: fitAssessment ?? this.fitAssessment,
      targetCustomers:
          targetCustomers ??
          this.targetCustomers.map((e0) => e0.copyWith()).toList(),
      marketOpportunity: marketOpportunity ?? this.marketOpportunity,
      marketAssumptions:
          marketAssumptions ?? this.marketAssumptions.map((e0) => e0).toList(),
      competitorHypotheses:
          competitorHypotheses ??
          this.competitorHypotheses.map((e0) => e0.copyWith()).toList(),
      strengths: strengths ?? this.strengths.map((e0) => e0).toList(),
      weaknesses: weaknesses ?? this.weaknesses.map((e0) => e0).toList(),
      opportunities:
          opportunities ?? this.opportunities.map((e0) => e0).toList(),
      threats: threats ?? this.threats.map((e0) => e0).toList(),
      businessModel: businessModel ?? this.businessModel,
      revenueStreams:
          revenueStreams ?? this.revenueStreams.map((e0) => e0).toList(),
      risks: risks ?? this.risks.map((e0) => e0.copyWith()).toList(),
      experiments:
          experiments ?? this.experiments.map((e0) => e0.copyWith()).toList(),
      mvpRecommendations:
          mvpRecommendations ??
          this.mvpRecommendations.map((e0) => e0).toList(),
      roadmap: roadmap ?? this.roadmap.map((e0) => e0.copyWith()).toList(),
      evidenceDisclaimer: evidenceDisclaimer ?? this.evidenceDisclaimer,
    );
  }
}
