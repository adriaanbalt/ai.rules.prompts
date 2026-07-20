# AI Rules & Prompts

[![GitHub](https://img.shields.io/github/stars/adriaanbalt/ai.rules.prompts?style=social)](https://github.com/adriaanbalt/ai.rules.prompts)

By **Adriaan Balt** ([www.adriaanbalt.com](https://www.adriaanbalt.com)) — battle-tested Cursor rules extracted from production Next.js/React/Supabase applications.

## Why This Exists

Cursor rules shape how AI writes code in your project. Most rule sets are bloated — they waste context window tokens on generic programming knowledge the AI already has. This collection is deliberately lean: **18 rules in ~900 lines** that specify only project-specific constraints, conventions, and architectural decisions.

### Design Principles

- **Rules are constraints, not tutorials.** Only specify deviations from standard practice.
- **Always-applied rules must be tiny.** Every token loads on every interaction.
- **No duplication.** Each pattern exists in exactly one place.
- **Context-specific by default.** Rules load only when relevant files are being edited.

## Quick Start

```bash
# Clone into your workspace
git clone git@github.com:adriaanbalt/ai.rules.prompts.git

# Copy rules into your project
cp ai.rules.prompts/*.mdc your-project/.cursor/rules/
```

Or symlink for automatic updates:
```bash
ln -s /path/to/ai.rules.prompts/*.mdc your-project/.cursor/rules/
```

## Rule Categories

### Always Applied

One consolidated rule active on every interaction (~300 tokens):

| Rule | Purpose |
|------|---------|
| **engineering-discipline.mdc** | Read before writing, match patterns, plan before executing, no placeholders, self-review |

### Context-Specific (activate on matching file patterns)

#### API & Backend

| Rule | Glob | Purpose |
|------|------|---------|
| **api-routes.mdc** | `app/api/**/*.ts` | Route structure, auth, validation, responses |
| **database-queries.mdc** | `lib/database/**/*.ts` | Client selection, query patterns, error handling |
| **security.mdc** | `app/api/**/*.ts, lib/auth/**/*.ts` | Auth, input validation, secrets, data protection |
| **supabase-migrations.mdc** | `supabase/migrations/**/*.sql` | Migration workflow, timestamp validation |
| **error-handling.mdc** | `**/*.{ts,tsx}` | Error functions, user messages, retry logic |
| **logging-monitoring.mdc** | `app/api/**/*.ts, lib/**/*.ts` | Structured logging, performance monitoring |

#### Frontend

| Rule | Glob | Purpose |
|------|------|---------|
| **design-system-tokens.mdc** | `**/*.tsx, **/*.css, tailwind.config*` | Semantic tokens, no hardcoded colors |
| **hooks.mdc** | `lib/hooks/**/*.ts` | Hook structure, authenticatedFetch, return types |
| **typescript-types.mdc** | `lib/types/**/*.ts, **/*.{ts,tsx}` | Type organization, conventions |
| **react-performance-animations.mdc** | `**/*.tsx, **/*.css` | Perf rules, animation decision framework |

#### Infrastructure

| Rule | Glob | Purpose |
|------|------|---------|
| **https-configuration.mdc** | `.env*, config.toml, docker-compose*` | HTTPS proxy, OAuth flow, port reference |
| **environment-variables.mdc** | `**/*.{ts,tsx,js,json}` | Naming, validation, file loading |

#### Practices

| Rule | Glob | Purpose |
|------|------|---------|
| **surgical-fixes.mdc** | `**/*.{ts,tsx,js,jsx}` | Diagnose first, minimal changes |
| **testing.mdc** | `**/*.test.{ts,tsx}, **/*.spec.{ts,tsx}` | Structure, mocking, worker tests |
| **markdown-creation.mdc** | `**/*.md` | File headers, date/time format |
| **qa-report.mdc** | — | Auto-format QA notes into reports |
| **qa-regression-checklist.mdc** | — | Regression workflow (agent-requestable) |

### Prompt Library

Reusable prompts in `prompt-library/` — loaded only when explicitly referenced:

```
@prompt-library/development Your request here
```

**Categories:** communication, development, qa-testing, strategic-analysis, document-parsing, refactoring, problem-analysis

## Rule File Format

```markdown
---
description: Brief description of what this rule enforces
globs: "**/*.ts,**/*.tsx"
alwaysApply: false
---

# Rule content here
```

| Field | Purpose |
|-------|---------|
| `description` | Shown in Cursor's rule picker |
| `globs` | File patterns that trigger this rule |
| `alwaysApply` | If `true`, loads on every interaction (use sparingly) |

## Stack

These rules are optimized for:
- **Next.js 15+** (App Router)
- **React 19+**
- **Supabase** (Auth, Database, RLS)
- **TypeScript 5+**
- **Tailwind CSS** (with design system tokens)
- **Framer Motion** (animations)

Adapt the patterns for other stacks by keeping the structure and replacing the specifics.

## Contributing

When adding rules:
1. Keep them under 100 lines — if it's longer, you're writing a tutorial
2. Include only project-specific constraints (not things the AI already knows)
3. Use context-specific globs — avoid `alwaysApply` unless absolutely necessary
4. Check for overlap with existing rules before adding

## License

MIT — use, adapt, and share freely.

---

**Made by [Adriaan Balt](https://www.adriaanbalt.com)**
