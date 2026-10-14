import '../generated/protocol.dart';
import 'analysis_provider.dart';

class DemoAnalysisProvider implements AnalysisProvider {
  @override
  String get mode => 'demo';

  @override
  Future<AnalysisReport> analyze(StartupIdeaRequest idea) async {
    return AnalysisReport(
      executiveSummary:
          '${idea.startupName} is an early ${idea.industry} concept for '
          '${idea.targetCustomer} in ${idea.geography}. Treat these notes as '
          'hypotheses and validate the customer problem before committing '
          'the ${idea.estimatedBudget.toStringAsFixed(0)} starting budget.',
      problem:
          'The frequency, cost, and urgency of this problem for '
          '${idea.targetCustomer} have not been independently verified.',
      solution:
          '${idea.description} Start with one measurable outcome for the '
          'intended customer.',
      fitAssessment:
          'Problem-solution fit is unproven. Interview target customers '
          'about recent workarounds and observed spending.',
      targetCustomers: [
        CustomerPersona(
          label: 'Primary early adopter',
          description:
              '${idea.targetCustomer} in ${idea.geography} who experiences '
              'the stated problem.',
          needs: [
            'A clear improvement over the current workaround',
            'A low-effort way to try the solution',
          ],
        ),
        CustomerPersona(
          label: 'Adjacent buyer to investigate',
          description: 'A decision-maker or team supporting the primary user.',
          needs: [
            'Evidence of value before adoption',
            'Predictable cost and implementation effort',
          ],
        ),
      ],
      marketOpportunity:
          'The reachable opportunity depends on how many customers in '
          '${idea.geography} share this problem and are willing to pay. '
          'Estimate it from interviews and observed spending rather than an '
          'unsupported top-down market-size figure.',
      marketAssumptions: [
        'The problem occurs often enough to motivate a change.',
        'The target customer can access or influence a purchase.',
        'Customers in ${idea.geography} are reachable through a practical '
            'early sales channel.',
      ],
      competitorHypotheses: [
        CompetitorHypothesis(
          alternativeType: 'Manual process',
          whatTheyOffer:
              'People may solve this job with their own time, checklists, or '
              'informal processes.',
          differentiationOpportunity:
              'Test whether a faster or more reliable outcome is worth '
              'switching for.',
        ),
        CompetitorHypothesis(
          alternativeType: 'Existing general-purpose tools',
          whatTheyOffer:
              'Customers may adapt tools they already use instead of buying '
              'a dedicated product.',
          differentiationOpportunity:
              'Investigate whether a focused workflow addresses a meaningful '
              'gap in the current setup.',
        ),
      ],
      strengths: [
        'The concept identifies an audience to interview.',
        'The idea can be tested with a narrow experiment.',
      ],
      weaknesses: [
        'Demand and willingness to pay are not yet evidenced.',
        'Product scope and customer acquisition need validation.',
      ],
      opportunities: [
        'A concierge test can reveal the most valuable workflow.',
        'A focused segment can make early feedback more specific.',
      ],
      threats: [
        'Customers may consider their current workaround sufficient.',
        'Adoption or distribution costs may exceed the available budget.',
      ],
      businessModel:
          'Test a paid pilot or one-time service before investing in a '
          'subscription. Choose pricing only after learning how customers '
          'measure value.',
      revenueStreams: [
        'Paid pilot or setup fee, if interviews confirm a budget owner.',
        'Recurring subscription, only if customers receive ongoing value.',
      ],
      risks: [
        RiskItem(
          title: 'Problem urgency is overstated',
          description:
              'People may describe the problem but not prioritize solving it.',
          likelihood: 'Unknown',
          mitigation:
              'Ask about recent examples, current workarounds, and actual '
              'spending rather than hypothetical interest.',
        ),
        RiskItem(
          title: 'Unclear route to customers',
          description:
              'The target audience may be difficult or costly to reach.',
          likelihood: 'Unknown',
          mitigation:
              'Compare two direct outreach channels during initial research.',
        ),
      ],
      experiments: [
        ValidationExperiment(
          title: 'Problem interviews',
          hypothesis:
              'Target customers can recall a recent example of the problem.',
          method:
              'Interview people in the stated audience about the last time '
              'they encountered it.',
          successSignal:
              'Several interviewees describe a recent workaround without '
              'being prompted with the proposed solution.',
          estimatedDays: 5,
        ),
        ValidationExperiment(
          title: 'Concierge prototype',
          hypothesis:
              'A lightweight version of the outcome is valuable enough to try.',
          method:
              'Deliver one narrow outcome manually to a small group of '
              'interested interviewees.',
          successSignal:
              'Participants complete the workflow and request another use '
              'or discuss a paid pilot.',
          estimatedDays: 10,
        ),
      ],
      mvpRecommendations: [
        'Pick one user, one recurring job, and one measurable outcome.',
        'Prototype only the core workflow and use manual operations where '
            'practical.',
        'Define a success measure before building, such as repeat usage or a '
            'paid pilot.',
      ],
      roadmap: [
        RoadmapWeek(
          week: 1,
          theme: 'Verify the problem',
          tasks: [
            'Recruit and interview target customers.',
            'Document current alternatives and recent examples.',
            'Choose one segment based on what you learn.',
          ],
        ),
        RoadmapWeek(
          week: 2,
          theme: 'Test the value proposition',
          tasks: [
            'Write one outcome-focused proposition.',
            'Show a simple prototype or landing-page concept.',
            'Record objections and compare outreach channels.',
          ],
        ),
        RoadmapWeek(
          week: 3,
          theme: 'Run a concierge MVP',
          tasks: [
            'Deliver the narrowest useful outcome manually.',
            'Measure completion, repeat intent, and support effort.',
            'Ask qualified users about a paid pilot.',
          ],
        ),
        RoadmapWeek(
          week: 4,
          theme: 'Decide what to build next',
          tasks: [
            'Review evidence against the original hypotheses.',
            'Estimate the smallest automation that removes a proven pain.',
            'Continue, revise, or stop based on observed behavior.',
          ],
        ),
      ],
      evidenceDisclaimer: evidenceDisclaimer,
    );
  }
}
