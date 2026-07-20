# Next.js/React/Supabase Cursor Rules

By **Adriaan Balt** ([www.adriaanbalt.com](https://www.adriaanbalt.com)) — battle-tested cursor rules extracted from production Next.js/React/Supabase applications.

## What's Inside

Development standards, architecture patterns, security, infrastructure, UI/UX, and testing rules designed to minimize context window usage while maximizing code quality.

## Rule Categories

### Always Applied

One consolidated rule that's always active:

1. **engineering-discipline.mdc** — Core engineering discipline
   - Read before writing, match existing patterns
   - Plan before executing, verify after completing
   - No TODOs or placeholders, complete changes only
   - Evidence-based decisions, explicit assumptions

### Context-Specific Rules

These activate when working with matching file patterns:

#### API & Backend

2. **api-routes.mdc** — Next.js API route standards (`app/api/**/*.ts`)
3. **database-queries.mdc** — Supabase query standards (`lib/database/**/*.ts`)
4. **security.mdc** — Auth, validation, secrets, data protection
5. **supabase-migrations.mdc** — Migration workflow and validation
6. **error-handling.mdc** — Error functions, user messages, logging
7. **logging-monitoring.mdc** — Structured logging and performance monitoring

#### Frontend

8. **design-system-tokens.mdc** — Semantic tokens over hardcoded colors (`*.tsx, *.css, tailwind.config*`)
9. **hooks.mdc** — Custom React hooks standards (`lib/hooks/**/*.ts`)
10. **typescript-types.mdc** — Type organization and conventions
11. **react-performance-animations.mdc** — Performance optimization and animation standards

#### Infrastructure & Configuration

12. **https-configuration.mdc** — HTTPS proxy setup, OAuth flow, port reference
13. **environment-variables.mdc** — Naming, validation, organization

#### Development Practices

14. **surgical-fixes.mdc** — Diagnose first, minimal targeted changes
15. **testing.mdc** — Test structure, mocking, worker tests

#### Documentation

16. **markdown-creation.mdc** — Markdown file headers with date/time handling (`*.md`)

#### QA

17. **qa-report.mdc** — Auto-format QA notes into structured reports
18. **qa-regression-checklist.mdc** — Regression workflow with MCP integration (agent-requestable)

### Prompt Library

The `prompt-library/` directory contains reusable prompts organized by category. Not automatically applied — only loaded when explicitly referenced.

```
@prompt-library/category prompt-name Your specific request here
```

**Categories:** communication, development, qa-testing, strategic-analysis, document-parsing, refactoring, problem-analysis

See `prompt-library/README.mdc` for complete documentation.

## Usage

### In Cursor

1. Clone this repository to your workspace
2. Link or copy rules to your project's `.cursor/rules/` directory
3. Reference specific rules in your project documentation

### Rule File Structure

```markdown
---
description: Brief description
globs: "**/*.ts,**/*.tsx"
alwaysApply: true/false
---

# Rule Content
```

## Design Principles

- **Rules are constraints, not tutorials.** Only specify deviations from standard practice.
- **Always-applied rules must be tiny.** Every token loads on every interaction.
- **No duplication.** Each pattern exists in exactly one place.
- **Context-specific by default.** Rules load only when relevant files are being edited.

## License

These rules are provided as-is. Adapt and modify as needed.

---

**Made by [Adriaan Balt](https://www.adriaanbalt.com)**
