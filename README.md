# StartupSense AI

StartupSense AI helps students and early-stage founders turn an idea into
customer questions, validation experiments, an MVP starting point, and a
30-day execution roadmap. Reports are decision-support tools, not guarantees
of startup success.

## Project structure

This repository is an existing Dart workspace with three packages:

- `startupsense_flutter/` — responsive Flutter app, sign-in, idea form,
  dashboard, saved reports, report viewer, and PDF/print export.
- `startupsense_server/` — Serverpod 4 backend, email identity provider,
  authenticated RPC endpoint, analysis service and provider adapters,
  database configuration, and migrations.
- `startupsense_client/` — generated Serverpod RPC client and serializable
  protocol models. Do not edit generated files directly.

Startup models and report models are declared as `.spy.yaml` files under
`startupsense_server/lib/src/startup_sense/`. The RPC endpoint validates each
submission, stores it for the signed-in user, creates and validates a report,
then marks that record completed. The report JSON and original idea are stored
in the Serverpod database; provider credentials are not stored in the database.

## Prerequisites

- Flutter 3.44.4 or newer (verified here with Flutter 3.47.7).
- Dart 3.12.2 or newer (verified here with Dart 3.13.5).
- Serverpod CLI 4.0.4.
- Windows Developer Mode if Flutter reports that plugin symlinks cannot be
  created. Enable it in **Settings → System → For developers**, then rerun
  `flutter pub get` from `startupsense_flutter/`.

Serverpod CLI 4.0.4 is installed in the Pub global cache in this environment.
If the `serverpod` command is not on PATH, the PowerShell examples below invoke
its wrapper directly. To install that exact CLI version in another
environment:

```powershell
dart pub global activate serverpod_cli 4.0.4
```

The development config uses the Serverpod-managed embedded PostgreSQL database
at `startupsense_server/.serverpod/development/pgdata`; Docker is not required
for that configuration. The test config uses its own embedded PostgreSQL data
directory. The existing `docker-compose.yaml` is for an alternate external
PostgreSQL setup.

## Run locally (Windows PowerShell)

Run these commands from the repository root. On first start, the
`--apply-migrations` argument applies the generated `startup-sense` database
migration. Serverpod's configured companion Flutter app is launched with the
server.

```powershell
# Configure Featherless for this server process.
$env:FEATHERLESS_API_KEY = "your-featherless-key"
# Optional override; defaults to Qwen/Qwen3-Next-80B-A3B-Instruct.
# $env:FEATHERLESS_MODEL = "provider/model-name"

# Start the development stack and apply pending migrations.
& "$env:LOCALAPPDATA\Pub\Cache\bin\serverpod.bat" start -- --apply-migrations
```

When `FEATHERLESS_API_KEY` is set, the server calls Featherless through its
chat completions API, using `Qwen/Qwen3-Next-80B-A3B-Instruct` by default.
Set `FEATHERLESS_MODEL` to override it with another model ID available to your
Featherless account. The provider key must remain in the server process.
Without a key, the backend uses deterministic demo analysis. Every demo report
is labelled as simulated and is not presented as AI output. Provider errors
are returned as structured errors rather than silently changing to demo mode.

To run Flutter separately in Chrome while the server is running:

```powershell
Set-Location startupsense_flutter
flutter run -d chrome
```

For a physical device, set `SERVER_URL` to a URL reachable from that device as
described in `startupsense_flutter/lib/client.dart` before running Flutter.

Development email sign-in uses the Serverpod email identity provider already
configured in `startupsense_server/lib/server.dart`. In development,
verification codes are written to the server logs. Create/sign in to an
account before using analyses; history and report retrieval are restricted to
the authenticated account.

## AI, evidence, and privacy

- Set `FEATHERLESS_API_KEY` in the server process environment only. Never put
  it in Flutter code, `--dart-define`, a client configuration asset, or a
  database record.
- `.env.example` is a reference template only; Serverpod does not load `.env`
  files automatically. Set environment variables in the server's shell.
- The server asks the provider for JSON, deserializes it into typed report
  models, validates required sections, and applies request timeouts and
  provider/rate-limit error handling.
- No live market or competitor research is implemented. Competitor categories
  and market observations are preliminary hypotheses, not sourced facts.
  Reports do not make up citations, market sizes, customer counts, or revenue.
- Saved records carry the authenticated Serverpod user ID. Every list and
  detail query is scoped to that user.

## Migrations and code generation

After editing a `.spy.yaml` model or endpoint, regenerate the server and client
protocol from the server package:

```powershell
Push-Location startupsense_server
& "$env:LOCALAPPDATA\Pub\Cache\bin\serverpod.bat" generate
Pop-Location
```

After changing a table model, create a new migration:

```powershell
Push-Location startupsense_server
& "$env:LOCALAPPDATA\Pub\Cache\bin\serverpod.bat" create-migration --tag your-lowercase-tag
Pop-Location
```

For this project the `startup_analysis` table and user-history index migrations
are already generated under
`startupsense_server/migrations/20261014134959008-startup-sense/` and
`startupsense_server/migrations/20261014144100096-startup-sense-index/`. Use
`serverpod start -- --apply-migrations` to apply all pending migrations while
starting the local server. In a running development session with the Serverpod
MCP available, its `apply_migrations` tool can apply pending migrations
without restarting.

## Checks

Run these from the repository root:

```powershell
dart format startupsense_server/lib/src/startup_sense startupsense_server/test/unit startupsense_server/test/integration/startup_analysis_endpoint_test.dart startupsense_flutter/lib/main.dart startupsense_flutter/lib/theme.dart startupsense_flutter/lib/data/startup_sense_repository.dart startupsense_flutter/lib/widgets/sense_widgets.dart startupsense_flutter/lib/features startupsense_flutter/lib/services/report_export_service.dart startupsense_flutter/test/idea_form_screen_test.dart
dart analyze startupsense_server startupsense_flutter
```

Run backend tests (uses the embedded PostgreSQL configured in
`startupsense_server/config/test.yaml`):

```powershell
Push-Location startupsense_server
dart test
Pop-Location
```

Run the focused Flutter form test:

```powershell
Push-Location startupsense_flutter
flutter test test/idea_form_screen_test.dart
Pop-Location
```

## Troubleshooting

- **`serverpod` is not recognized:** use the full
  `"$env:LOCALAPPDATA\Pub\Cache\bin\serverpod.bat"` path shown above, or add
  the Pub global cache `bin` directory to PATH.
- **Plugin symlink support error on Windows:** enable Developer Mode, then run
  `Set-Location startupsense_flutter; flutter pub get; Pop-Location`. This is
  required by Flutter tooling for native plugin symlinks; the project uses the
  `printing` plugin for PDF/print export.
- **Cannot connect to the API:** confirm the Serverpod stack is running at
  `http://localhost:8080`. For a physical device, `localhost` refers to the
  device, so configure a reachable server address.
- **Report cannot be saved:** confirm pending migrations were applied during
  server startup and inspect the Serverpod logs for database/provider errors.
- **Demo report shown:** this is expected when the server process has no
  non-empty `FEATHERLESS_API_KEY`; demo output is deterministic and explicitly
  labelled.
