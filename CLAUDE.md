# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

`jemquarie` is a Ruby gem that wraps the Macquarie ESI SOAP web service. It fetches cash transactions, balances, account details, and credential expiry for Macquarie clients.

## Commands

```bash
# Install dependencies
bundle install

# Run all tests
bundle exec rake spec

# Run a single spec file
bundle exec rspec spec/lib/importer_spec.rb

# Run linter
bundle exec rubocop --parallel

# Auto-fix rubocop offenses
bundle exec rubocop -a
```

CI (`.github/workflows/`) runs the same two commands: `bundle exec rake test` and `bundle exec rubocop --parallel` on Ruby 3.3.1.

## Architecture

All SOAP communication goes through a single endpoint (`Jemquarie::BASE_URI`) using the `generate_xml_extract` operation defined in `lib/jemquarie/extract.wsdl`. The gem is structured in two layers:

**Operation classes** (`lib/jemquarie/*.rb`) — each inherits from `Base`, represents one API call, and exposes a single public method that builds a SOAP message and delegates parsing to its mixed-in parser module:
- `Importer#cash_transactions`
- `Balance#balances`
- `AccountDetails#account_details`
- `Expiry#expiry`
- `Service#date`

**Parser modules** (`lib/jemquarie/parser/*.rb`) — each is `include`d into its matching operation class. `Parser::Generic` (included in `Base`) handles the common XML unwrapping and `RequestStatus == "Failure"` error path. Per-operation parsers extract domain-specific fields from the unwrapped XML.

**Configuration** lives on `Jemquarie::Jemquarie` class-level ivars, set once at boot via `Jemquarie::Jemquarie.api_credentials(key, app_name, log_level, logger, log_requests)`. The api key, username, and password are SHA1-hashed then Base64-encoded (`Base#hash_key`) before being placed in the SOAP envelope — callers always pass unhashed values.

**Error contract** — every operation returns a Hash `{ :error => "..." }` (or `{ error:, code: }` for API failures) on any non-success path, or the parsed result Array/Hash on success. Don't raise from operation methods.

## Conventions

- Tests use RSpec + WebMock with `WebMock.disable_net_connect!` — no real network. Fixtures and stubs go through WebMock.
- RuboCop target Ruby 3.3, `NewCops: enable`. Notable relaxed cops: `Layout/LineLength` 130, `Metrics/MethodLength` 200, `Metrics/ModuleLength` 200. Style cops for `HashSyntax`, `StringLiterals`, `Documentation` are disabled — match the existing `:symbol => value` hash rocket style and double-quoted strings already in the codebase.
- `# frozen_string_literal: true` at the top of every Ruby file.
