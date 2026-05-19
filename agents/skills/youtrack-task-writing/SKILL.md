---
name: youtrack-task-writing
description: Use when creating, editing, refining, triaging, or reviewing YouTrack issues and task descriptions. Enforces clear titles, structured descriptions, actionable acceptance criteria, and requires using YouTrack MCP to inspect real projects, fields, issue types, and allowed values before proposing or creating tasks.
version: 1.0.0
license: MIT
compatibility: opencode
metadata:
  audience: developers
  workflow: issue-tracking
---

# Writing YouTrack Tasks

## Overview

Use this skill when the user asks to create a new task in YouTrack, improve an existing issue, rewrite a vague ticket, or prepare a task body before creation.

Default stance: a good YouTrack task is executable by another engineer without a follow-up meeting.

## Mandatory Tooling

Always use **YouTrack MCP** when the task involves a real YouTrack project or issue.

Use YouTrack MCP to verify:

- the correct project
- available issue types
- required and optional custom fields
- allowed values for priority, state, subsystem, component, sprint, assignee, tags, etc.
- existing linked issues, duplicates, parents, epics, and dependencies

Do not invent field values, issue types, or workflow states from memory.

If the user only wants a draft and no live YouTrack context is available, write the draft in YouTrack-ready format and explicitly mark any unknown fields as "verify via YouTrack MCP".

## Workflow

1. Determine whether the user wants a draft, an update to an existing issue, or issue creation in a live project.
2. If live YouTrack data matters, inspect the project and issue metadata through YouTrack MCP first.
3. Identify the task category: bug, feature, improvement, chore, spike, tech debt, support, or incident follow-up.
4. Rewrite the task so the title states the outcome or problem, not the activity.
5. Structure the description so implementation scope and acceptance are testable.
6. Before creating or updating the issue, check for ambiguity, missing constraints, and invented assumptions.

## Writing Rules

### Title

A strong title is:

- specific
- short
- outcome-oriented
- searchable

Prefer:

- `Prevent duplicate webhook delivery during retry`
- `Add retention period filter to audit log export`
- `Investigate intermittent 502 responses from billing API`

Avoid:

- `Fix bug`
- `Improve API`
- `Do webhooks`
- `Research issue`

### Description

Use this structure by default:

1. **Context**: what is happening and why this task exists
2. **Problem / Goal**: the concrete issue to solve or result to achieve
3. **Scope**: what is included
4. **Out of scope**: what must not be changed
5. **Acceptance criteria**: observable conditions for done
6. **Dependencies / Links**: related tasks, incidents, PRs, docs
7. **Notes / Risks**: migration concerns, rollout caveats, open questions

### Acceptance Criteria

Acceptance criteria must be testable and externally observable.

Good criteria usually:

- describe system behavior
- include edge cases when they matter
- avoid implementation details unless required

Prefer:

- `Retrying the same webhook event does not create a second delivery record.`
- `If the retention filter is empty, export behavior remains unchanged.`
- `A user without billing permissions receives 403 from the endpoint.`

Avoid:

- `Code is clean`
- `Refactor completed`
- `Works correctly`
- `Use repository pattern`

## Best Practices

- Write the problem before the solution.
- Capture business impact when known.
- Separate implementation ideas from required behavior.
- Split unrelated work into separate issues.
- For spikes, state the decision expected at the end.
- For bugs, include current behavior, expected behavior, and reproduction clues.
- For feature work, include user value and rollout constraints.
- For tech debt, explain operational or delivery cost if left unresolved.
- Preserve domain language already used in the project and YouTrack fields.

## Category Guidance

### Bug

Include:

- current behavior
- expected behavior
- reproduction context
- impact
- logs, screenshots, or traces if available

### Feature / Improvement

Include:

- user or business outcome
- trigger or use case
- constraints
- measurable acceptance criteria

### Spike / Investigation

Include:

- question to answer
- boundaries of investigation
- expected artifact: recommendation, RFC, estimate, root cause, or options

## References

Use these references when you need concrete templates and examples:

- **Good vs bad issue examples and rewrite patterns**: [references/BEST_PRACTICES.md](references/BEST_PRACTICES.md)

