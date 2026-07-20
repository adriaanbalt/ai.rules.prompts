---
name: feature-scaffold
description: Scaffold a new feature end-to-end with phased checkpoints. Use when building a new feature, adding a new module, or starting implementation on a ticket.
---

# Feature Scaffold

## Quick Start

Build a new feature using phased implementation with validation checkpoints. This prevents monolithic changes and ensures each layer works before building the next.

## Workflow

```
Feature Scaffold Progress:
- [ ] Phase 1: Context & Plan
- [ ] Phase 2: Types & Interfaces
- [ ] Phase 3: Data Layer
- [ ] Phase 4: Business Logic
- [ ] Phase 5: UI (if applicable)
- [ ] Phase 6: Tests
- [ ] Phase 7: Integration & Validation
```

## Phase 1: Context & Plan

Before writing code:

1. **Find the reference:** Identify the most similar existing feature in the codebase.
2. **Read it thoroughly:** Note patterns for file location, naming, imports, error handling, tests.
3. **Map the surfaces:**

```markdown
## Feature: [Name]

**Reference feature:** [path to similar existing feature]

**Affected surfaces:**
- [ ] Types/interfaces: [where]
- [ ] Database: [tables, migrations needed?]
- [ ] API routes: [which endpoints]
- [ ] Business logic: [which lib/ modules]
- [ ] UI components: [which pages/components]
- [ ] Tests: [what to cover]
```

4. **State the plan** in 1–3 sentences. Wait for confirmation.

**CHECKPOINT:** Plan reviewed. Proceed only after approval.

## Phase 2: Types & Interfaces

Define the shape of data before implementing:

1. Add/extend database types (if DB-backed)
2. Define request/response types for API routes
3. Define component prop types (if UI)
4. Export from the canonical location

**Verification:** Run `tsc --noEmit` — types compile with no errors.

**CHECKPOINT:** Types defined. All downstream code will conform to these.

## Phase 3: Data Layer

Create the data access:

1. Write migration (if new table/columns needed)
2. Create/extend data access functions in `lib/`
3. Follow existing client selection patterns (user client vs admin)
4. Scope all queries by tenant (`.eq('app_id', appId)`)

**Verification:** Data layer functions work in isolation. Test with a simple script or test file.

**CHECKPOINT:** Data flows correctly. No business logic yet.

## Phase 4: Business Logic

Implement the core logic:

1. Create API route handler(s) following existing patterns
2. Wire up auth + membership checks
3. Implement the business rules
4. Handle errors using domain error types
5. Add logging for key operations

**Verification:** API responds correctly via curl/Postman/test.

**CHECKPOINT:** Business logic works end-to-end via API. No UI yet.

## Phase 5: UI (if applicable)

Build the interface:

1. Create page/component in the correct route group
2. Wire up data fetching (React Query or server component)
3. Handle loading, error, and empty states
4. Follow existing UI patterns (form handling, styling)
5. Ensure responsive behavior

**Verification:** UI renders correctly. Actions trigger the API. States display properly.

**CHECKPOINT:** Feature works visually. Ready for testing.

## Phase 6: Tests

Write tests following project patterns:

1. **Unit tests:** Business logic, validation, edge cases
2. **Integration tests:** API routes with auth/membership
3. **Component tests:** Key UI interactions (if applicable)

Priority order:
- Authorization (wrong user can't access)
- Tenant isolation (can't see other tenant's data)
- Happy path (core flow works)
- Error cases (invalid input handled gracefully)

**Verification:** All tests pass. No existing tests broken.

**CHECKPOINT:** Tests pass. Coverage includes critical paths.

## Phase 7: Integration & Validation

Final checks:

1. Run full lint + type check
2. Run full test suite (not just new tests)
3. Verify no regressions in related features
4. Check for any documentation that needs updating
5. Self-review: consistency with reference feature from Phase 1

**CHECKPOINT:** Ready for PR. All CI-equivalent checks pass locally.

## Shortcuts for Common Scenarios

**Bug fix:** Skip to Phase 4 (you already know the context). Still do Phase 6–7.

**Refactoring:** Phase 1 is discovery, Phase 2–4 is the move, Phase 7 is critical (no behavior change).

**API-only (no UI):** Skip Phase 5.

**UI-only (existing API):** Skip Phases 3–4, start at Phase 5.

## Why Phases Matter

Each phase produces a verifiable intermediate state:
- Types compile → data shape is correct
- Data layer works → persistence is correct
- API works → business logic is correct
- UI works → user experience is correct
- Tests pass → regressions are caught

Skipping phases leads to debugging multiple layers simultaneously.
