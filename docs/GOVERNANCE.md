# Governance

Security, privacy, and trust boundaries for AI-assisted development.

## Trust Model

```
┌─────────────────────────────────────────────┐
│  AI CAN read/edit (workspace - .cursorignore) │
├─────────────────────────────────────────────┤
│  AI CANNOT read/edit (.cursorignore)         │
│  - Secrets, credentials, keys               │
│  - CI/CD pipelines                          │
│  - Lock files                               │
│  - Generated/binary assets                  │
├─────────────────────────────────────────────┤
│  AI CANNOT reach (network boundary)          │
│  - Production databases                     │
│  - Internal APIs (without MCP approval)     │
│  - Customer data                            │
└─────────────────────────────────────────────┘
```

## .cursorignore (First Line of Defense)

The `.cursorignore` file makes listed paths **invisible** to the AI. Unlike `.gitignore`, this controls what the AI can even *see*, not just what gets committed.

**Non-negotiable entries:**
- All `.env*` files (secrets)
- CI/CD workflows (prevent AI from modifying deployment)
- Lock files (AI should never regenerate these)

**Recommended entries:**
- Large binary assets (waste context window)
- Generated output directories
- Vendor/third-party code

See `.cursorignore.template` for a complete starting point.

## Privacy Mode

For teams handling sensitive data:

- **Enable Privacy Mode** in Cursor settings (code never sent to cloud)
- Use local models when processing proprietary code
- Audit which MCP servers have access to what data
- Never include customer data in rule examples

## MCP (Model Context Protocol) Governance

If your team uses MCP servers:

| MCP Server | Risk Level | Approval Required |
|------------|-----------|-------------------|
| Read-only docs/wiki | Low | Team lead |
| Issue tracker (read) | Low | Team lead |
| Issue tracker (write) | Medium | Eng manager |
| Database (read) | High | Security + Eng manager |
| Database (write) | Critical | Security + VP Eng |
| Deployment triggers | Critical | Security + VP Eng |

**Principle:** AI should have the minimum access needed. Expand access only with explicit approval.

## Agent Guardrails

When using AI agents (autonomous multi-step execution):

1. **Sandbox by default** — agents run in restricted environments
2. **No production access** — agents cannot deploy or access prod databases
3. **Review before merge** — agent-generated PRs require human approval
4. **Audit trail** — all agent actions are logged

## Rule Security

Rules themselves can be a security surface:

- **Don't put secrets in rules** (even as examples)
- **Don't encode internal URLs** in rules shared publicly
- **Review rule PRs** like code PRs — they influence all AI-generated output
- **Version control rules** — they're infrastructure, not documentation

## Compliance Checklist

Before rolling out AI rules to a team:

- [ ] `.cursorignore` installed and reviewed by security
- [ ] No secrets in any rule file
- [ ] MCP access levels approved
- [ ] Privacy Mode evaluated for compliance requirements
- [ ] Agent usage policy documented
- [ ] Rule change process has PR review requirement
- [ ] Quarterly review cadence scheduled
