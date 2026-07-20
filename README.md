# AI Rules & Prompts

[![GitHub stars](https://img.shields.io/github/stars/adriaanbalt/ai.rules.prompts?style=social)](https://github.com/adriaanbalt/ai.rules.prompts)

A lean, production-tested framework for AI-assisted development. Rules that make Cursor (and any AI coding tool) behave like a senior engineer who knows your codebase.

**Stack-agnostic.** The methodology works for Next.js, Django, Rails, Go, Rust — anything. Stack-specific rules are included as examples you adapt.

---

## Why This Exists

AI coding assistants are powerful but undirected. Without guardrails, they:
- Invent patterns instead of following yours
- Generate verbose, tutorial-style code instead of matching conventions
- Skip validation, producing code that doesn't compile
- Ignore your team's established error handling, testing, and naming

This repo provides the **rules, hooks, governance, and rollout playbook** to fix that.

---

## Quick Start

```bash
# Clone
git clone https://github.com/adriaanbalt/ai.rules.prompts.git

# Copy universal rules to your project
cp ai.rules.prompts/rules/0*.mdc your-project/.cursor/rules/

# Copy .cursorignore template
cp ai.rules.prompts/.cursorignore.template your-project/.cursorignore

# (Optional) Copy hooks
cp ai.rules.prompts/hooks/hooks.json your-project/.cursor/hooks.json
```

Or symlink for auto-updates:
```bash
ln -s /path/to/ai.rules.prompts/rules/0*.mdc your-project/.cursor/rules/
```

---

## Repository Structure

```
ai.rules.prompts/
├── rules/                          # ← Copy these into .cursor/rules/
│   ├── 00-engineering-discipline   # Core reasoning & quality (always applied)
│   ├── 01-surgical-fixes           # Debugging methodology
│   ├── 02-testing                  # Test patterns & coverage
│   ├── 03-typescript-types         # Type safety constraints
│   ├── 04-react-performance        # React/animation best practices
│   ├── 05-markdown-creation        # Documentation standards
│   ├── 06-qa-report                # QA report formatting
│   ├── 07-qa-regression            # Regression testing checklist
│   ├── 08-onboarding-scaffold      # Guided first-contribution workflow
│   └── nextjs-supabase/            # ← Stack example (adapt for your stack)
│       ├── 10-api-routes
│       ├── 11-database-queries
│       ├── 12-error-handling
│       ├── 13-security
│       ├── 14-supabase-migrations
│       ├── 15-hooks-react
│       ├── 16-design-system-tokens
│       ├── 17-https-oauth
│       ├── 18-environment-variables
│       ├── 19-logging-monitoring
│       ├── 20-multi-tenancy
│       ├── 21-stripe-connect
│       ├── 22-aws-lambda-sam
│       ├── 23-email-pipeline
│       ├── 24-rag-ai-pipeline
│       └── 25-provider-abstraction
├── skills/                         # On-demand multi-step workflows
│   ├── qa-session/                 # Full QA testing workflow
│   ├── rule-authoring/             # How to write new rules
│   ├── feature-scaffold/           # Phased feature implementation
│   └── deploy-checklist/           # Multi-service deployment
├── hooks/                          # Behavioral nudges (post-save reminders)
│   ├── hooks.json                  # Hook definitions
│   └── README.md                   # How hooks work
├── docs/                           # Governance & operations
│   ├── ROLLOUT-PLAYBOOK.md         # 4–6 week team adoption plan
│   ├── PLATFORM-RUNBOOK.md         # Maintaining rules over time
│   ├── SUCCESS-METRICS.md          # How to measure impact
│   └── GOVERNANCE.md               # Security & trust boundaries
├── prompt-library/                 # Reusable prompt templates
│   ├── qa-testing.mdc
│   ├── problem-analysis.mdc
│   ├── refactoring.mdc
│   └── ...
├── .cursorignore.template          # AI trust boundary (copy to your project)
└── README.md
```

---

## How It Works

### Four Layers of Enforcement

```
Rules (AI reads these every session)
  → "Always match existing naming conventions"
  → "Never leave TODOs or placeholders"

Skills (On-demand multi-step workflows)
  → "Run a full QA session from scope to report"
  → "Scaffold a feature with phased checkpoints"

Hooks (Fire on specific events)
  → "Did you check types after saving this .ts file?"
  → "Does this test cover error cases?"

CI (Machine-enforced, blocks merge)
  → Lint, type-check, test suite
  → Rules DON'T duplicate CI — they complement it
```

### Rule Format

Every rule is a `.mdc` file with YAML frontmatter:

```markdown
---
description: One-line purpose (shown in Cursor's rule picker)
globs: "**/*.ts"      # Which files trigger this rule
alwaysApply: false    # true = active on every prompt (use sparingly)
---

# Rule Title

Constraints and patterns go here. Keep it under 100 lines.
Include WHY — the incident or pattern that motivated this rule.
```

### Numbering Convention

| Range | Scope | Examples |
|-------|-------|---------|
| 00–09 | Universal (any project) | Engineering discipline, testing, QA |
| 10–19 | Stack-specific | API routes, migrations, auth |
| 20–29 | Team/role-specific | QA workflows, DevOps patterns |

---

## Skills (On-Demand Workflows)

Skills are multi-step playbooks the agent follows when invoked. Copy to `.cursor/skills/` in your project:

```bash
cp -r ai.rules.prompts/skills/* your-project/.cursor/skills/
```

| Skill | What it does | Invoke with |
|-------|-------------|-------------|
| `qa-session` | Full QA workflow: scope → test → report → tickets | "Run a QA session on this PR" |
| `rule-authoring` | Write new rules following the methodology | "Create a rule for our API patterns" |
| `feature-scaffold` | Phased implementation with checkpoints | "Scaffold the new payments feature" |
| `deploy-checklist` | Multi-service deploy coordination | "Deploy this to production" |

**Rules vs Skills:**
- Rules fire automatically (always-on or glob-triggered)
- Skills fire on demand (user invokes explicitly)
- Rules = constraints. Skills = workflows.

---

## For QA Engineers

Rules `06-qa-report` and `07-qa-regression` are designed for QA workflows:

- **06-qa-report**: Standardized report format so AI generates consistent, actionable QA reports
- **07-qa-regression**: Regression checklist ensuring no feature area is missed during testing
- **prompt-library/qa-testing.mdc**: Ready-made prompts for test scenario generation

The onboarding scaffold (`08`) guides QA engineers through their first contribution with checkpoints.

---

## Adapting for Your Stack

The `rules/nextjs-supabase/` directory is a **reference implementation**. To create rules for your stack:

1. Copy the structure to `rules/your-stack/`
2. Replace patterns with your framework's conventions
3. Keep the same constraints-not-tutorials philosophy
4. Number in the 10–19 range

Example for Django:
```
rules/django/
├── 10-views.mdc           # View patterns, DRF serializers
├── 11-models.mdc          # Model conventions, migrations
├── 12-auth.mdc            # Authentication/authorization
├── 13-testing.mdc         # pytest patterns, fixtures
└── 14-celery.mdc          # Task queue patterns
```

---

## Design Principles

1. **Constraints, not tutorials.** Rules tell the AI what NOT to do. It already knows how to code.
2. **Under 100 lines.** If a rule is longer, it's a tutorial. Split or trim it.
3. **Include WHY.** "Don't use `any`" is weak. "Don't use `any` — it caused 3 production type errors in June" is strong.
4. **Match, don't invent.** Rules encode YOUR existing patterns, not ideal patterns from docs.
5. **Fail open.** Hooks remind; only CI blocks. A broken rule should never prevent work.
6. **Lean > comprehensive.** 10 sharp rules beat 50 verbose ones. Every token costs context.

---

## Contributing

1. Fork the repo
2. Add/modify rules following the numbering convention
3. Keep rules under 100 lines
4. Include a WHY annotation for any new constraint
5. Test the rule in a real Cursor session before submitting

---

## License

MIT
