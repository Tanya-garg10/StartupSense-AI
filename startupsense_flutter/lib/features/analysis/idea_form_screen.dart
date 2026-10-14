import 'package:flutter/material.dart';
import 'package:startupsense_client/startupsense_client.dart';

import '../../data/startup_sense_repository.dart';
import '../../theme.dart';
import '../../widgets/sense_widgets.dart';

class IdeaFormScreen extends StatefulWidget {
  const IdeaFormScreen({required this.onAnalyzed, super.key});

  final ValueChanged<AnalysisResponse> onAnalyzed;

  @override
  State<IdeaFormScreen> createState() => _IdeaFormScreenState();
}

class _IdeaFormScreenState extends State<IdeaFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _industryController = TextEditingController();
  final _customerController = TextEditingController();
  final _geographyController = TextEditingController();
  final _budgetController = TextEditingController();
  final _repository = StartupSenseRepository();
  String _stage = 'Idea';
  bool _isSubmitting = false;
  String? _errorMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _industryController.dispose();
    _customerController.dispose();
    _geographyController.dispose();
    _budgetController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_isSubmitting || !_formKey.currentState!.validate()) return;
    final budget = double.tryParse(_budgetController.text.trim());
    if (budget == null || !budget.isFinite || budget < 0) {
      setState(() => _errorMessage = 'Enter a valid starting budget.');
      return;
    }
    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });
    try {
      final response = await _repository.analyzeIdea(
        StartupIdeaRequest(
          startupName: _nameController.text.trim(),
          description: _descriptionController.text.trim(),
          industry: _industryController.text.trim(),
          targetCustomer: _customerController.text.trim(),
          geography: _geographyController.text.trim(),
          estimatedBudget: budget,
          stage: _stage,
        ),
      );
      if (mounted) widget.onAnalyzed(response);
    } on StartupSenseError catch (error) {
      if (mounted) setState(() => _errorMessage = error.message);
    } on Exception {
      if (mounted) {
        setState(() {
          _errorMessage =
              'We could not reach StartupSense. Check your connection and '
              'try again.';
        });
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  String? _required(String? value, {int minimumLength = 2}) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'This field is required.';
    if (text.length < minimumLength) {
      return 'Add a little more detail (at least $minimumLength characters).';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 26, 24, 42),
      children: [
        const ContentWidth(
          child: _FormIntro(),
        ),
        const SizedBox(height: 24),
        ContentWidth(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'The essentials',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'A few specifics lead to a more useful first-pass report.',
                      style: TextStyle(color: StartupSenseColors.muted),
                    ),
                    const SizedBox(height: 22),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final twoColumns = constraints.maxWidth > 660;
                        return Column(
                          children: [
                            _responsivePair(
                              twoColumns: twoColumns,
                              first: SenseTextField(
                                key: const Key('startup_name_field'),
                                controller: _nameController,
                                label: 'Startup name',
                                hint: 'e.g. Fieldnote',
                                validator: _required,
                                textCapitalization: TextCapitalization.words,
                              ),
                              second: SenseTextField(
                                key: const Key('industry_field'),
                                controller: _industryController,
                                label: 'Industry',
                                hint: 'e.g. Climate software',
                                validator: _required,
                                textCapitalization: TextCapitalization.words,
                              ),
                            ),
                            const SizedBox(height: 18),
                            SenseTextField(
                              key: const Key('description_field'),
                              controller: _descriptionController,
                              label: 'Describe the idea',
                              hint:
                                  'What problem are you solving, for whom, '
                                  'and how does your solution help?',
                              validator: (value) =>
                                  _required(value, minimumLength: 30),
                              minLines: 4,
                              maxLines: 6,
                            ),
                            const SizedBox(height: 18),
                            _responsivePair(
                              twoColumns: twoColumns,
                              first: SenseTextField(
                                key: const Key('customer_field'),
                                controller: _customerController,
                                label: 'Target customer',
                                hint: 'e.g. Independent urban growers',
                                validator: (value) =>
                                    _required(value, minimumLength: 3),
                              ),
                              second: SenseTextField(
                                key: const Key('geography_field'),
                                controller: _geographyController,
                                label: 'Geography / target market',
                                hint: 'e.g. Bengaluru, India',
                                validator: _required,
                              ),
                            ),
                            const SizedBox(height: 18),
                            _responsivePair(
                              twoColumns: twoColumns,
                              first: DropdownButtonFormField<String>(
                                key: const Key('stage_field'),
                                initialValue: _stage,
                                decoration: const InputDecoration(
                                  labelText: 'Current stage',
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: 'Idea',
                                    child: Text('Idea'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Research',
                                    child: Text('Research'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'MVP',
                                    child: Text('MVP'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Launched',
                                    child: Text('Launched'),
                                  ),
                                ],
                                onChanged: _isSubmitting
                                    ? null
                                    : (value) {
                                        if (value != null) {
                                          setState(() => _stage = value);
                                        }
                                      },
                              ),
                              second: SenseTextField(
                                key: const Key('budget_field'),
                                controller: _budgetController,
                                label: 'Estimated starting budget',
                                hint: 'e.g. 25000 (local currency)',
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                validator: (value) {
                                  final amount = double.tryParse(
                                    value?.trim() ?? '',
                                  );
                                  if (amount == null ||
                                      !amount.isFinite ||
                                      amount < 0 ||
                                      amount > 100000000) {
                                    return 'Enter an amount from 0 to 100,000,000.';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    if (_errorMessage != null) ...[
                      const SizedBox(height: 20),
                      ErrorNotice(message: _errorMessage!),
                    ],
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        key: const Key('analyze_idea_button'),
                        onPressed: _isSubmitting ? null : _submit,
                        icon: _isSubmitting
                            ? const SizedBox.square(
                                dimension: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(Icons.auto_awesome),
                        label: Text(
                          _isSubmitting
                              ? 'Preparing your analysis...'
                              : 'Analyze my idea',
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Analysis is decision support. Market and competitor '
                      'notes are preliminary hypotheses, not verified research.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: StartupSenseColors.muted,
                        fontSize: 12,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _responsivePair({
    required bool twoColumns,
    required Widget first,
    required Widget second,
  }) {
    if (!twoColumns) {
      return Column(
        children: [first, const SizedBox(height: 18), second],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: first),
        const SizedBox(width: 18),
        Expanded(child: second),
      ],
    );
  }
}

class _FormIntro extends StatelessWidget {
  const _FormIntro();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const EyebrowLabel('IDEA VALIDATION'),
        const SizedBox(height: 10),
        Text(
          'Start with the idea.',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 8),
        const Text(
          'Tell us what you are exploring. We’ll turn it into questions, '
          'experiments, and a practical first-month plan.',
          style: TextStyle(color: StartupSenseColors.muted, height: 1.6),
        ),
      ],
    );
  }
}
