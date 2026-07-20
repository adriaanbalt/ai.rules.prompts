# Prompt Library Quick Reference

## How to Use

Reference prompts in Cursor chat using the `@` syntax:

```
@prompt-library/category prompt-name Your request here
```

Or reference the file and mention the prompt:

```
@prompt-library/category Use the prompt-name prompt: Your request here
```

## All Available Commands

### Communication Prompts

```
@prompt-library/communication clarifying-questions
@prompt-library/communication explain-only-concise
@prompt-library/communication explain-only-detailed
@prompt-library/communication confirmation-check
@prompt-library/communication conversation-outline
@prompt-library/communication update-documentation
@prompt-library/communication balanced-evaluation
```

### Development Prompts

```
@prompt-library/development bug-analysis
@prompt-library/development debug-analysis
@prompt-library/development debug-with-validation
@prompt-library/development code-only
@prompt-library/development function-length
@prompt-library/development minimal-changes
@prompt-library/development update-code
@prompt-library/development problem-area-only
@prompt-library/development step-by-step
@prompt-library/development suggest-first
@prompt-library/development evaluate-methods
@prompt-library/development internationalization
@prompt-library/development ui-from-markdown
@prompt-library/development technical-roadmap
@prompt-library/development git-commit
@prompt-library/development naming-convention
@prompt-library/development persona-pain-points
@prompt-library/development user-journey-implementation
@prompt-library/development consolidate-files
```

### Strategic Analysis Prompts

```
@prompt-library/strategic-analysis mckinsey-framework
@prompt-library/strategic-analysis competitive-deep-dive
@prompt-library/strategic-analysis ceo-strategy-whisperer
```

### Document Parsing Prompts

```
@prompt-library/document-parsing fix-spaces
@prompt-library/document-parsing fix-paragraphs
```

### Refactoring Prompts

```
@prompt-library/refactoring explain-before
@prompt-library/refactoring separation-of-concerns
@prompt-library/refactoring iterative-refactor
```

### Problem Analysis Prompts

```
@prompt-library/problem-analysis alternative-perspective
```

### QA Testing Prompts

```
@prompt-library/qa-testing start-qa-session
@prompt-library/qa-testing format-qa-report
@prompt-library/qa-testing batch-update-tickets
@prompt-library/qa-testing screenshot-bug-report
@prompt-library/qa-testing regression-summary
@prompt-library/qa-testing duplicate-check
@prompt-library/qa-testing smoke-test-checklist
@prompt-library/qa-testing qa-handoff-notes
```

## Usage Examples

### Example 1: Debug Analysis
```
@prompt-library/development debug-analysis Fix the bug in the login component
```

### Example 2: Strategic Analysis
```
@prompt-library/strategic-analysis ceo-strategy-whisperer Analyze the marketing operations industry
```

### Example 3: Communication
```
@prompt-library/communication explain-only-concise Explain how authentication works
```

### Example 4: Refactoring
```
@prompt-library/refactoring separation-of-concerns Review this component for refactoring opportunities
```

### Example 5: Multiple Prompts
```
@prompt-library/development debug-analysis @prompt-library/communication explain-only-concise Review these error logs
```

## Notes

- Prompts are **not automatically applied** - they only load when referenced
- You can combine multiple prompts in one message
- Reference prompts at the start of your message for best results
- If Cursor doesn't recognize the prompt name, try: `@prompt-library/category Use the prompt-name prompt: Your request`

