---
name: sdlc-workflow
description: Guide work through the full AI-native SDLC — from signal through production ownership. Use when starting any non-trivial work, investigating bugs, planning features, or when someone jumps straight to coding without context.
---

# AI-Native SDLC Workflow

## Why This Exists

Most teams only use AI for Phase 6 (code generation). They jump from signal to execute. That's the autocomplete trap — speed upstream, whiplash downstream. PRs ship faster but sit longer in review, incidents creep up, and senior engineers burn out repeating feedback.

This skill walks through all 8 phases. Use whichever phases apply to the current work.

## The Eight Phases

```
Signal → Investigate → Plan → Ticket → Align → Execute → Review → Own
  1          2           3       4        5        6         7       8
```

## Determine Entry Point

Not all work starts at Phase 1:

| Situation | Start at |
|-----------|----------|
| Alert/bug/customer report | Phase 1 (Signal) |
| "Something's broken" | Phase 2 (Investigate) |
| New feature request | Phase 3 (Plan) |
| Ticket already exists with AC | Phase 5 or 6 (Align/Execute) |
| PR needs review | Phase 7 (Review) |
| Production incident | Phase 8 (Own) then loop to Phase 2 |

---

## Phase 1: Signal

**What:** A trigger arrives — bug report, alert, customer request, regression, or new requirement.

**Actions:**
- Capture the signal source (who reported, when, severity)
- Note the affected area (which service, feature, user segment)
- Decide: is this urgent (fix now) or planned (goes through planning)?

**Output:** One-sentence problem statement with source and severity.

---

## Phase 2: Investigate

**What:** Understand the problem before proposing solutions. Gather evidence.

**Actions:**
1. Check logs/traces for the affected service
2. Search codebase for related files (`@` references in Cursor)
3. Look at recent changes to the affected area (`git log --since`)
4. Check related tickets/PRs for context
5. Identify the root cause vs symptoms

**Prompt pattern:**
```
Given these logs/traces: [paste]
And this code: @path/to/affected/file
What is the most likely root cause? Show your reasoning.
```

**Output:** Root cause identified with evidence. If ambiguous, state the top 2–3 hypotheses.

**CHECKPOINT:** Do not proceed to Plan without a root cause or clear hypothesis.

---

## Phase 3: Plan

**What:** Design the solution. Consider trade-offs. Break into shippable chunks.

**Actions:**
1. Propose 2–3 approaches with trade-offs
2. Select one, justify why
3. Check: does this match existing patterns in the codebase?
4. Break into small, reviewable chunks (each independently shippable if possible)
5. Identify risks and mitigation

**Prompt pattern:**
```
Given this root cause: [from Phase 2]
And these constraints: @path/to/conventions, @path/to/existing-pattern

Propose 3 approaches. For each: effort, risk, trade-offs.
Then recommend one and break it into ≤3 PRs.
```

**Output:** Chosen approach + breakdown into steps/PRs.

**CHECKPOINT:** Plan reviewed before execution. Does it match existing patterns?

---

## Phase 4: Ticket

**What:** Create or update the issue with clear acceptance criteria.

**Actions:**
1. Write a clear title (what changes, not how)
2. Describe the problem (from Phase 2)
3. Describe the solution (from Phase 3)
4. List acceptance criteria (testable, specific)
5. Note dependencies and deployment considerations

**Acceptance criteria template:**
```markdown
- [ ] [Specific observable behavior]
- [ ] [Error case handled: what happens when X]
- [ ] [Performance: response time < Xms / no N+1]
- [ ] [Tests: unit + integration covering critical paths]
- [ ] [No regressions in related features]
```

**Output:** Ticket created/updated with AC.

---

## Phase 5: Align

**What:** Confirm direction with the team before deep work. Prevent wasted effort.

**Actions:**
- Share the plan briefly (Slack, standup, or async doc)
- Get explicit approval from the relevant reviewer/lead
- Resolve any disagreements before coding

**Output:** Explicit "go" from the team. If async, link to the approval.

**Why this phase exists:** AI makes executing the wrong plan very fast. Alignment before execution prevents expensive rewrites.

---

## Phase 6: Execute

**What:** Write the code. This is where rules fire automatically.

**Actions:**
1. Follow the plan from Phase 3 (don't deviate without re-aligning)
2. Match existing conventions (rules enforce this)
3. Write small, focused commits
4. Include tests with each change
5. Self-review before requesting review

**What rules handle at this phase:**
- Engineering discipline (verify before acting, match patterns)
- Stack-specific constraints (API patterns, DB queries, types)
- Onboarding scaffold (phased implementation with checkpoints)

**Output:** PR(s) ready for review.

---

## Phase 7: Post-Ship Review

**What:** Review the change for correctness, security, and risk — not just style.

**Review checklist:**
```
Correctness:
- [ ] Logic handles edge cases (null, empty, concurrent, large data)
- [ ] Error handling is appropriate (not swallowed, not over-caught)
- [ ] Types are satisfied (no `any`, no `@ts-ignore`)

Security:
- [ ] No secrets exposed
- [ ] Input validated at boundaries
- [ ] Authorization checked (right user, right tenant)

Observability:
- [ ] Key operations logged
- [ ] Errors traceable (request ID, user context)

Tests:
- [ ] Critical paths tested
- [ ] Regression scenario covered
- [ ] Tests actually assert behavior (not just "no error")

Risk assessment:
- [ ] What's the blast radius if this breaks?
- [ ] Is there a rollback path?
- [ ] Does this need a feature flag?
```

**Output:** Approved or changes requested with specific items.

---

## Phase 8: Production Ownership

**What:** Monitor the change after deploy. Validate it works with real traffic.

**Actions:**
1. Watch error monitoring for new errors (first 30 minutes)
2. Check performance metrics (response times, throughput)
3. Verify the fix/feature works for the original reporter
4. Close the ticket only after production validation
5. If issues arise: loop back to Phase 2 (Investigate)

**Output:** Ticket closed with production confirmation. Or: new signal → loop back.

---

## Quick Reference

```
┌─────────────────────────────────────────────────────────┐
│  Phase 1: Signal      → "What happened?"                 │
│  Phase 2: Investigate → "Why did it happen?"             │
│  Phase 3: Plan        → "How should we fix/build it?"   │
│  Phase 4: Ticket      → "What does done look like?"     │
│  Phase 5: Align       → "Does the team agree?"          │
│  Phase 6: Execute     → "Build it (rules enforce)."     │
│  Phase 7: Review      → "Is it safe to ship?"           │
│  Phase 8: Own         → "Is it working in prod?"        │
└─────────────────────────────────────────────────────────┘
```

## Common Mistakes

- **Skipping Phase 2:** Jumping to code without understanding the root cause. You'll fix the symptom, not the problem.
- **Skipping Phase 3:** No plan means no scope. Changes sprawl.
- **Skipping Phase 5:** Building the wrong thing fast is worse than building the right thing slow.
- **Skipping Phase 7:** "It works on my machine" doesn't survive production traffic.
- **Skipping Phase 8:** Closing the ticket before confirming production behavior. Hope is not a monitoring strategy.
