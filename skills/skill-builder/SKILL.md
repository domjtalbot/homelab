---
name: skill-builder
description: "Create or update repo skills when the user asks to create a new skill, add a skill, or update an existing skill. Use the repo skills catalog and follow the local skill conventions."
---

# Skill Builder

Use this skill to add or update skills in `skills/` and register them in `skills/skills-catalog.md`.

## Qualifying questions

Ask the minimum needed:

1) Skill name (kebab-case, <64 chars)
2) Trigger phrases (exact user phrasing)
3) Purpose (1 sentence)
4) Required resources (scripts/references/assets?)
5) Any non-negotiable rules or "don’ts"

If the user already provided these, proceed without asking.

## Workflow

1) **Create the skill skeleton**
   - If available, run:
     - `python3 <CODEX_HOME>/skills/.system/skill-creator/scripts/init_skill.py <skill-name> --path skills [--resources scripts,references,assets]`
   - Otherwise create the folder manually under `skills/<skill-name>/` with `SKILL.md` and any needed resource folders.

2) **Write SKILL.md**
   - Add frontmatter `name` and `description`.
   - Keep body concise, imperative voice, only what Codex needs.
   - No README files inside the skill folder.

3) **Add resources**
   - Put detailed content in `references/` when needed.
   - Add scripts only if repeated code is likely.

4) **Register the skill**
   - Update `skills/skills-catalog.md` with:
     - Purpose
     - Trigger phrases
     - Path

5) **Do NOT edit**
   - `AGENTS.md`, `CLAUDE.md`, `.github/copilot-instructions.md` (they already point to the catalog).

## Output expectations

- `skills/<skill-name>/SKILL.md` created/updated
- `skills/skills-catalog.md` updated
- No secrets in any skill files

## Reference

See `references/skill-template.md` for a concise SKILL.md template.
