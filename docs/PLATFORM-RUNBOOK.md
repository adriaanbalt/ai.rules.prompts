# Platform Runbook

How to maintain and evolve rules after initial rollout.

## Rule Change Contract

**Any convention change requires updating three things in the same PR:**

1. The code (new pattern)
2. The rule (`.mdc` file reflecting the new pattern)
3. The onboarding docs (if the change affects new contributors)

If a rule changes but the code doesn't reflect it, the rule is aspirational — not a standard.

## Adding a New Rule

1. **Identify the need:** A mistake is recurring, a review comment keeps appearing, or a new convention is agreed upon.
2. **Check existing rules:** Does another rule already cover this? (Extend, don't duplicate.)
3. **Write the rule:** Under 100 lines. Constraint, not tutorial. Include WHY.
4. **Choose the right scope:**
   - `alwaysApply: true` — Only if it applies to literally every file edit (very rare)
   - `globs: "pattern"` — Target the specific file types affected
5. **Number appropriately:**
   - `00-09` — Universal rules (any project)
   - `10-19` — Stack-specific rules (in the appropriate subdirectory)
6. **Test:** Use the rule in a real session. Does it fire when expected? Is it helpful?
7. **PR:** Submit with description of what problem this prevents.

## Modifying an Existing Rule

1. **State the reason:** What changed? (New pattern agreed, old one deprecated, rule too verbose)
2. **Update the rule** with the change
3. **Update affected code** if the convention itself changed
4. **Notify the team** — rules changes affect everyone's workflow

## Removing a Rule

Remove a rule when:
- The convention it encodes is now universal team knowledge (engineers "graduated")
- The convention was wrong or is deprecated
- CI/linting now catches the same issue (rule is redundant)

**Never remove silently.** Note in the PR why it was removed.

## Ownership Model

| Layer | Owner | Change frequency |
|-------|-------|-----------------|
| Universal rules (00-09) | Tech lead / senior eng | Rarely (quarterly review) |
| Stack rules (10-19) | Domain expert for that stack | As conventions evolve |
| Hooks | Platform team | When recurring mistakes identified |
| `.cursorignore` | Security / platform | When trust boundary changes |

## Quarterly Review

Every quarter, review all rules:

- [ ] Are any rules consistently ignored? (Remove or fix)
- [ ] Are any rules outdated? (Update or remove)
- [ ] Are there new recurring review comments? (Add rules)
- [ ] Are hooks causing fatigue? (Tune or remove)
- [ ] Have metrics improved? (Report to leadership)

## Troubleshooting

| Symptom | Likely cause | Fix |
|---------|-------------|-----|
| Rule not activating | Glob doesn't match current file | Check `globs` pattern |
| Rule too noisy | `alwaysApply: true` on a narrow concern | Change to glob-scoped |
| AI ignoring rule | Rule is too long (>200 lines) | Condense to constraints only |
| Conflicting rules | Two rules give contradictory guidance | Consolidate or add priority |
| Hook firing on wrong files | Glob too broad | Narrow the `match` pattern |
