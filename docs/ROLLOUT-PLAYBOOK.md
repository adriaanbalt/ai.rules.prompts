# Rollout Playbook

How to deploy AI rules to a team over 4–6 weeks.

## Phase 0: Discovery (2–3 days)

**Goal:** Understand existing conventions before encoding them.

- [ ] Mine recent PRs for repeated review comments (these become rules)
- [ ] Interview 2–3 recent joiners: "What was confusing in your first week?"
- [ ] Identify the team's existing CI checks (don't duplicate — integrate)
- [ ] Baseline metrics: time-to-first-merged-PR for recent hires, review cycle count

**Output:** List of 5–10 conventions worth encoding as rules.

## Phase 1: Lighthouse (Weeks 1–2)

**Goal:** Install rules for 2–3 volunteer engineers. Prove value before scaling.

- [ ] Install `rules/00-engineering-discipline.mdc` + `rules/08-onboarding-scaffold.mdc`
- [ ] Add 3–5 project-specific rules (use `rules/nextjs-supabase/` as templates)
- [ ] Install `.cursorignore` from template
- [ ] Run 30-min enablement session: show rules in action, explain philosophy
- [ ] Collect feedback after 1 week: What helped? What was noisy?

**Output:** Validated rule set, lighthouse engineers are productive.

## Phase 2: Enable (Weeks 3–4)

**Goal:** Roll out to full team. Add hooks for common mistakes.

- [ ] Install rules for all team members
- [ ] Add hooks from `hooks/hooks.json` (quality reminder, QA checkpoint)
- [ ] Run role-specific sessions if applicable (QA, DevOps, PM)
- [ ] Assign rule ownership: who updates rules when conventions change?
- [ ] Track metrics: review comment reduction, CI pass rate on first push

**Output:** Full team using rules. Hook fatigue assessed and tuned.

## Phase 3: Mature (Weeks 5–6)

**Goal:** Team owns the rules. Platform team maintains infrastructure.

- [ ] Document rule change process (see PLATFORM-RUNBOOK.md)
- [ ] Set up quarterly rule review cadence
- [ ] Remove/archive rules that are no longer needed (engineers "graduated")
- [ ] Consider skills for complex, multi-step workflows
- [ ] Publish success metrics to leadership (see SUCCESS-METRICS.md)

**Output:** Self-sustaining system. SA/lead can step back.

## Recovery Plans

### Rules are being ignored
- Check: Are rules too verbose? (>100 lines = tutorial, not constraint)
- Check: Are rules wrong? (Outdated patterns create friction)
- Fix: Trim, update, or delete. Never force compliance on bad rules.

### Too many false-positive hooks
- Fix: Narrow the `match` glob or increase specificity of the message
- Fix: Remove the hook entirely — it's better to have no hook than a noisy one

### New hire still struggling despite rules
- Check: Is the onboarding scaffold rule installed?
- Check: Are they reading the rules or ignoring the AI's suggestions?
- Fix: Pair session showing rules in action. Rules work best when demonstrated.

## RACI

| Activity | Responsible | Accountable | Consulted | Informed |
|----------|-------------|-------------|-----------|----------|
| Write rules | Senior eng | Tech lead | Team | PM |
| Maintain rules | Platform/owning eng | Tech lead | All | — |
| Rollout decision | Tech lead | Eng manager | SA | Team |
| Metrics reporting | Tech lead | Eng manager | — | Leadership |
| Security review | Security | Eng manager | Platform | — |
