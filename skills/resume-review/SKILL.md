---
name: resume-review
description: >
  This skill should be used when the user asks to "review my resume", "check my resume",
  "how's my resume", "resume review", "resume feedback", "critique my resume", or wants
  a thorough multi-lens evaluation of their resume. Runs three parallel reviewers and
  synthesizes findings into prioritized action items.
---

# Resume Review

Thorough multi-perspective resume review. Three parallel reviewers evaluate the resume from
different angles, then findings are synthesized into a single prioritized action plan.

## Load Context

1. Read `~/.claude/career-toolkit.local.md` for profile data (field, target role, level, companies, feedback style, data path).
   - If the file doesn't exist: "Run `/career-toolkit:setup` first to set up your profile — it takes about 5 minutes." Stop here.
2. Read `[data_path]/resume.md` for the resume content.
   - If no resume exists: offer to ingest one now (PDF from the career-toolkit folder, or paste into chat). Save to `resume.md` before proceeding.
3. Read `${CLAUDE_PLUGIN_ROOT}/references/career-principles.md` for grounding principles.
4. Read `${CLAUDE_PLUGIN_ROOT}/skills/resume-review/references/review-agents.md` for detailed agent prompts.

## Run Three Parallel Reviews

Use the Agent tool to launch all three reviewers concurrently. Each agent receives:
- The full resume text
- The user's profile context (field, current role, target role, target level, target companies)
- The career principles from references/career-principles.md
- Its specific review instructions from references/review-agents.md

### Agent A: Recruiter Lens
A senior recruiter hiring for the user's target role in their field. Evaluates first impressions, section scoring, language quality, and structure. Answers: "Would I advance this candidate?"

### Agent B: ATS & Keywords Lens
An ATS and keyword optimization specialist for the user's field. Researches current job postings for the target role (use WebSearch), evaluates keyword coverage, skills section, and formatting. Provides specific wording edits.

### Agent C: Level-Signal Lens
A senior hiring committee member evaluating whether the resume reads at the right level. Ranks bullets by signal strength, checks for decision-making visibility, and assesses whether the resume overcomes any experience gaps.

See `references/review-agents.md` for detailed agent prompt templates.

## Synthesize Findings

Combine all three reviews into a single structured output:

### Output Format

1. **Verdict** — one-line level read (e.g., "Reads as a mid-level marketer, not yet senior" or "Strong senior nurse profile, ready for lead roles")
2. **Top 3 Themes** — patterns that appeared across multiple reviewers
3. **Highest-Leverage Changes** — prioritized list of specific actions, ordered by impact. Each item should be concrete: quote exact phrases that need changing, reference specific bullets by position, and provide example rewrites.
4. **Section-by-Section Scorecard** — consolidated scores (1-5) from all three lenses in a table
5. **Field-Specific Notes** — anything unique to the user's industry (certifications to highlight, field-specific ATS patterns, etc.)

## Adapt to Preferences

- **Feedback style** from profile determines tone:
  - "direct": Be brutally honest. No softening.
  - "encouraging": Lead with strengths, then improvements. Still honest.
  - "detailed": Provide extensive commentary on every section.
  - "high-level": Top 5 bullets only, no deep dives.

## Safety Rails

- Only recommend adding skills or keywords the user can genuinely defend in an interview or conversation
- Flag any claims that might get scrutinized (inflated scope, short tenure, unverifiable metrics)
- Ground all feedback in the career principles reference — no vibes-based advice
- Do not rewrite the resume — provide specific, actionable feedback the user implements themselves

## Additional Resources

### Reference Files
- **`references/review-agents.md`** — Detailed prompt templates for each of the three review agents, with field-adaptive instructions
