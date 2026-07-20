---
name: qa-session
description: Run a full QA testing session — gather scope, execute tests, generate report, update tickets. Use when starting QA, running regression tests, validating a feature, or preparing a QA handoff.
---

# QA Session

## Quick Start

Run a structured QA session from scope definition through report delivery.

## Workflow

Copy this checklist and track progress:

```
QA Session Progress:
- [ ] Step 1: Define scope
- [ ] Step 2: Set up environment
- [ ] Step 3: Execute test cases
- [ ] Step 4: Document findings
- [ ] Step 5: Generate report
- [ ] Step 6: Update tickets
```

## Step 1: Define Scope

Determine what's being tested:

**Feature validation?** → Focus on the specific feature's acceptance criteria
**Regression?** → Use the regression checklist (rule `07-qa-regression`)
**Release?** → Full regression + new feature validation

Gather:
- Which branch/PR is being tested?
- What changed? (read the diff or PR description)
- What are the acceptance criteria?
- What areas might be affected by the change?

## Step 2: Set Up Environment

1. Pull the branch under test
2. Verify local environment is running (`yarn dev` or equivalent)
3. Confirm test data is available (seed if needed)
4. Note the environment: browser, OS, screen size
5. Clear caches if testing UI changes

## Step 3: Execute Test Cases

For each test case:

```markdown
### TC-[number]: [Test case name]

**Preconditions:** [What must be true before testing]
**Steps:**
1. [Action]
2. [Action]
3. [Action]

**Expected:** [What should happen]
**Actual:** [What actually happened]
**Status:** PASS | FAIL | BLOCKED
**Evidence:** [Screenshot path or description]
```

Test priority order:
1. Happy path (core workflow functions correctly)
2. Authorization (correct users see correct data)
3. Error cases (invalid input, network failures, empty states)
4. Edge cases (boundary values, concurrent access, large data)
5. Cross-browser/device (if applicable)

## Step 4: Document Findings

For each bug found:

```markdown
## BUG: [Short title]

**Severity:** Critical | High | Medium | Low
**Steps to reproduce:**
1. [Step]
2. [Step]
3. [Step]

**Expected behavior:** [What should happen]
**Actual behavior:** [What happens instead]
**Environment:** [Browser, OS, screen size]
**Evidence:** [Screenshot/recording]
**Regression?** Yes/No (did this work before?)
```

## Step 5: Generate Report

Use this template:

```markdown
# QA Report — [Feature/Release Name]

**Date:** [YYYY-MM-DD]
**Tester:** [Name]
**Branch/PR:** [Reference]
**Environment:** [Details]

## Summary

| Metric | Count |
|--------|-------|
| Test cases executed | [N] |
| Passed | [N] |
| Failed | [N] |
| Blocked | [N] |

## Verdict: PASS / FAIL / CONDITIONAL PASS

[One-paragraph summary of findings and recommendation]

## Bugs Found

[List bugs with severity and status]

## Regression Impact

[Areas tested for regression, any regressions found]

## Risks & Notes

[Anything the team should know before shipping]
```

## Step 6: Update Tickets

- Move tested tickets to appropriate state (Passed QA / Failed QA)
- Attach QA report to the PR or ticket
- Create new tickets for bugs found
- Tag bugs with severity and affected area
- Notify the developer if critical/high bugs found

## When to Fail a Release

- Any Critical severity bug
- More than 2 High severity bugs
- Regression in a previously working feature
- Security vulnerability (any severity)
- Data integrity issue

## Tips

- Test the unhappy path first — developers usually test the happy path
- Check mobile/responsive if the feature has UI
- Verify permissions: can a non-admin see what they shouldn't?
- Check what happens with empty states and first-time users
- If something feels slow, note it — performance is a feature
