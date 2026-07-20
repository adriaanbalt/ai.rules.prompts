# AI-Native SDLC

How to wire AI into the full software development lifecycle — not just code generation.

## The Problem

Most teams use AI coding tools as faster autocomplete: open editor, ask for a function, paste the result, fix what's wrong, repeat. That works for solo side projects. It does not survive contact with a production codebase, a review queue, or a team that needs to trust the output.

**AI-assisted** = faster execution on the same foundation.
**AI-native** = rebuilt operating model where AI participates in planning, ticketing, review, and production ownership — not just writing code.

The difference matters because speed upstream creates whiplash downstream. More PRs ship faster, but they sit longer in review, incidents creep up, and senior engineers stop trusting the tool.

## The Eight Phases

| Phase | What happens | AI's role | Without AI |
|-------|--------------|-----------|------------|
| **1. Signal** | Bug, alert, customer ask | Entry point (captures context) | Same |
| **2. Investigate** | Logs, traces, related code | Root-cause analysis on structured data | Manual log reading, context switching |
| **3. Plan** | Options, trade-offs, shippable chunks | Plan grounded in codebase context | RFC in a doc with no code awareness |
| **4. Ticket** | Issue with acceptance criteria | Drafted from the plan | Manual, often incomplete |
| **5. Align** | Team confirms direction | AI wrote the brief; human approves | Same, but the brief is better |
| **6. Execute** | Small PRs, tests, match conventions | Rules enforce patterns automatically | Code generation (what most teams do) |
| **7. Review** | Automated + risk pass | Security, correctness, risk analysis | Human-only review (slower, inconsistent) |
| **8. Own** | Monitor, fix, validate in prod | Debug production issues in-editor | Separate tools, context switching |

**Key insight:** Most teams only use Phase 6. Phases 2–4 and 7–8 are where the transformation happens.

## How This Repo Maps to the SDLC

| Phase | What this repo provides |
|-------|------------------------|
| 1–2 | `skills/sdlc-workflow` guides investigation |
| 3 | `skills/sdlc-workflow` structures planning |
| 4 | `skills/sdlc-workflow` provides AC template |
| 5 | Human step (AI drafted the brief) |
| 6 | `rules/` enforce conventions; `skills/feature-scaffold` structures execution |
| 7 | `skills/qa-session` for QA; review checklist in SDLC skill |
| 8 | `skills/deploy-checklist` for shipping; SDLC skill for monitoring |

## The Enforcement Stack

```
Phase 6 (Execute):
┌─────────────────────────────────────────┐
│  Rules (automatic)                       │
│  "Match naming conventions"              │
│  "Scope all queries by tenant"           │
├─────────────────────────────────────────┤
│  Skills (on-demand)                      │
│  "Scaffold this feature in phases"       │
│  "Run the full QA workflow"              │
├─────────────────────────────────────────┤
│  Hooks (post-event)                      │
│  "Did you check types?"                  │
│  "Does this test cover errors?"          │
├─────────────────────────────────────────┤
│  CI (blocks merge)                       │
│  Lint, type-check, test suite            │
└─────────────────────────────────────────┘
```

## Rollout Order for Teams

When adopting this framework, start in this order:

1. **Planning (Phases 2–4)** — Biggest immediate impact. AI-assisted planning catches issues before code exists.
2. **Rules (Phase 6)** — 5–10 rules encoding your team's conventions. Start with `00-engineering-discipline` + your stack-specific patterns.
3. **Review (Phase 7)** — Add the QA skill and review checklist. Catch issues before they reach production.
4. **Production (Phase 8)** — Wire monitoring tools (if available via MCP) so you can debug without leaving the editor.

Don't try to adopt all 8 phases at once. See `docs/ROLLOUT-PLAYBOOK.md` for the phased adoption plan.

## Measuring Success

| Metric | What it tells you | Target |
|--------|-------------------|--------|
| Time to first merged PR | Onboarding effectiveness | ↓ 30–50% |
| Convention review comments | Rule quality | ↓ 50% by 3rd PR |
| CI pass rate on first push | Execution quality | ↑ to >80% |
| Review cycles to merge | Plan quality (fewer surprises) | ↓ to <2 |
| Incidents post-deploy | Review + monitoring quality | Stable or ↓ |

See `docs/SUCCESS-METRICS.md` for the full measurement framework.

## AI-Assisted vs AI-Native

| Dimension | AI-Assisted (ceiling) | AI-Native (target) |
|-----------|----------------------|-------------------|
| Planning | Human writes RFC, AI suggests edits | AI drafts RFC grounded in codebase; human approves |
| Execution | AI suggests code, human accepts/edits | AI generates with rules enforcing patterns |
| Review | Human reviews everything | AI pre-screens (security, correctness); human reviews risk |
| Governance | Bolt-on (external docs) | Embedded (rules, hooks, `.cursorignore`) |
| Metric | Individual productivity | System-level delivery (time-to-merge, incident rate) |
| Engineer role | Implementer | Specifier, verifier, orchestrator |

## When to Use Each Phase

**Not every task needs all 8 phases:**

| Task type | Phases to use |
|-----------|---------------|
| Urgent production bug | 1 → 2 → 6 → 7 → 8 (skip formal planning, fix fast) |
| New feature | 1 → 2 → 3 → 4 → 5 → 6 → 7 → 8 (full lifecycle) |
| Refactoring | 3 → 5 → 6 → 7 (plan, align, execute, verify) |
| Documentation | 3 → 6 (plan structure, write it) |
| Tech debt cleanup | 2 → 3 → 6 → 7 (investigate scope, plan, execute, verify) |

Use judgment. The framework guides — it doesn't mandate ceremony for trivial work.
