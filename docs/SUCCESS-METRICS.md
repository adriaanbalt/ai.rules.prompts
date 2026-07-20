# Success Metrics

How to measure whether AI rules are working.

## North Star Metric

**Time to first merged PR** for new contributors (human or AI agent).

This single metric captures whether rules successfully encode enough context for someone unfamiliar with the codebase to produce mergeable work.

## Supporting Metrics

### Quality Indicators

| Metric | How to measure | Target |
|--------|---------------|--------|
| Convention-related review comments | Count comments about naming, structure, patterns per PR | ↓ 50% after 30 days |
| CI pass rate on first push | % of PRs that pass CI without revision | ↑ to >80% |
| Review cycles per PR | Average rounds of review before merge | ↓ to <2 |
| Regression rate | Bugs introduced per sprint | Stable or ↓ |

### Adoption Indicators

| Metric | How to measure | Target |
|--------|---------------|--------|
| Rule coverage | % of team with rules installed | 100% by Phase 2 |
| Rule PR frequency | How often rules are updated by the team | >1/month (healthy) |
| Engineer confidence | Survey: "I understand the codebase conventions" | ↑ over baseline |

### What NOT to Measure

- **Lines of code generated** — vanity metric, incentivizes bloat
- **Cursor usage hours** — doesn't correlate with quality
- **Number of rules** — more rules ≠ better rules
- **AI acceptance rate** — accepting bad suggestions is worse than rejecting good ones

## Measurement Schedule

| Timeframe | Action |
|-----------|--------|
| Day 0 | Baseline: current time-to-first-PR, review comment count, CI pass rate |
| Day 30 | First report: lighthouse team metrics vs baseline |
| Day 60 | Full team report: all metrics vs baseline |
| Day 90 | Quarterly review: decide what to keep, change, remove |
| Ongoing | Monthly check-in on north star metric |

## Reporting Template

```markdown
## AI Rules Impact — [Month/Quarter]

**North star:** Time to first merged PR
- Baseline: [X days]
- Current: [Y days]
- Change: [↑/↓ Z%]

**Quality:**
- Convention review comments: [X → Y] per PR
- CI first-push pass rate: [X% → Y%]
- Review cycles: [X → Y] average

**Adoption:**
- Rules installed: [X/Y] engineers
- Rule updates this period: [X] PRs
- Rules removed (graduated): [X]

**Actions:**
- [What we're changing based on data]
```

## When Rules Are Failing

If metrics aren't improving after 30 days:

1. **Rules are too abstract** — they need more project-specific detail
2. **Rules are too verbose** — AI is ignoring them due to context pressure
3. **Rules are wrong** — they encode outdated or incorrect patterns
4. **Rules aren't installed** — check adoption coverage
5. **Problem isn't rule-shaped** — maybe you need CI checks, not AI guidance
