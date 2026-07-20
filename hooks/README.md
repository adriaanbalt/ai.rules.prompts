# Hooks

Hooks are behavioral nudges that fire after specific events. They don't block — they remind.

## How Hooks Work

1. **Event fires** (e.g., file saved)
2. **Match pattern** checks if the file matches the glob
3. **Action executes** (currently: prompt the agent with a reminder)

## Design Principles

- **Fail open** — if a hook errors, it does nothing. Never block the developer.
- **Nudge, don't enforce** — hooks remind; CI enforces.
- **Phase 2 rollout** — only add hooks after rules have proven effective. Don't start here.

## Installation

Copy `hooks.json` to your project's `.cursor/hooks.json`:

```bash
cp hooks/hooks.json your-project/.cursor/hooks.json
```

## Customization

Edit the `match` patterns to fit your project structure. Add new hooks for project-specific workflows (e.g., remind to update docs when API routes change).

## When to Add a Hook

Add a hook when:
- A mistake keeps recurring despite rules
- The cost of the mistake is high (data loss, security)
- A simple reminder would prevent it

Don't add a hook when:
- The rule already covers it adequately
- CI already catches it
- It would fire too frequently (notification fatigue)
