---
name: rule-authoring
description: Create or improve Cursor rules following the methodology. Use when writing a new rule, converting coding conventions to rules, or auditing existing rules for quality.
---

# Rule Authoring

## Quick Start

Create effective AI rules that encode team conventions as constraints, not tutorials.

## Before Writing

1. **Identify the problem:** What mistake keeps recurring? What review comment keeps appearing?
2. **Check existing rules:** Does a rule already cover this? Extend it instead of creating new.
3. **Gather evidence:** Find 2–3 real examples of the problem in PRs or code.

## Rule Template

```markdown
---
description: [One-line purpose — shown in Cursor's rule picker]
globs: "[file patterns this applies to]"
alwaysApply: false
---

# [Rule Title]

## [Core Pattern / Required Approach]

[Show the correct pattern with a brief code example]

## Common Violations

[What NOT to do — concrete anti-patterns]

## WHY

[The incident, bug, or pattern that motivated this rule. 1–2 sentences.]
```

## Decision: Scope

| Scope | When to use | Frontmatter |
|-------|-------------|-------------|
| `alwaysApply: true` | Applies to literally every file edit (very rare) | No globs needed |
| Glob-scoped | Applies to specific file types/paths | `globs: "pattern"` |

**Default to glob-scoped.** Only use `alwaysApply: true` for core principles (like engineering discipline).

## Decision: Numbering

| Range | Scope |
|-------|-------|
| 00–09 | Universal (any project, any stack) |
| 10–19 | Stack-specific (framework/language patterns) |
| 20–29 | Domain-specific (payments, email, AI, etc.) |

## Quality Checklist

Before committing a new rule, verify:

```
Rule Quality:
- [ ] Under 100 lines (if longer, it's a tutorial — split or trim)
- [ ] Constraints, not explanations (tells AI what NOT to do)
- [ ] Includes WHY (incident or pattern that motivated it)
- [ ] Has concrete examples (code snippets, not prose)
- [ ] Glob is precise (doesn't fire on irrelevant files)
- [ ] No duplication with existing rules
- [ ] No PII, secrets, or internal project names
- [ ] Tested in a real Cursor session
```

## Anti-Patterns

**Too verbose (tutorial):**
```markdown
# Bad — 200 lines explaining how React hooks work
React hooks are functions that let you "hook into" React state and lifecycle
features from function components. When using hooks, there are several rules
you must follow...
```

**Correct (constraint):**
```markdown
# Good — 5 lines of what's different about YOUR project
## Hook Rules
- Custom hooks live in `lib/hooks/` — never colocate with components
- Always return typed objects, never tuples
- Prefix data-fetching hooks with `use{Resource}` (e.g., `useProjects`)
```

**Too abstract:**
```markdown
# Bad — generic advice the AI already knows
"Write clean code. Use meaningful variable names."
```

**Correct (project-specific):**
```markdown
# Good — YOUR project's specific convention
"Name boolean state as `is{Condition}` or `has{Thing}`. 
DB columns use `is_` prefix (snake_case). TS uses `is` prefix (camelCase)."
```

## Converting Coding Conventions to Rules

When turning a CODING_CONVENTIONS.md into rules:

1. **Extract constraints** — ignore explanations, keep the "must/never/always" statements
2. **Group by file type** — each rule should target specific globs
3. **Add WHY** — conventions docs rarely explain incidents; add them
4. **Test token cost** — paste the rule into a session and check if the AI follows it
5. **Delete what the AI already knows** — generic best practices waste tokens

## Workflow

```
Identify problem → Check existing rules → Write rule → Test in session → PR
```

If the rule doesn't improve AI output in testing, it's not ready. Iterate or discard.
