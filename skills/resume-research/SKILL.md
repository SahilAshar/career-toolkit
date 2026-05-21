---
name: resume-research
description: >
  This skill should be used when the user asks to "research resume patterns", "resume
  best practices", "resume research", "what should my resume look like", "what do good
  resumes look like", or wants to understand current resume conventions for their target
  role and field. Researches live sources and returns structured findings — not actual
  resume bullets.
---

# Resume Research

Research what high-quality resumes look like for the user's specific target role, field,
and level. Returns structured findings — patterns, anti-patterns, verb recommendations,
keyword guidance, and metrics advice. Does NOT write resume bullets — provides raw
materials the user can work with.

## Load Context

1. Read `~/.claude/career-toolkit.local.md` for profile data (field, target role, level, companies).
   - If the file doesn't exist: "Run `/career-toolkit:setup` first to set up your profile." Stop here.
2. Read `${CLAUDE_PLUGIN_ROOT}/references/career-principles.md` for baseline principles.
3. Check for existing research in `[data_path]/research/` — read any prior findings to build on rather than re-derive.

## Accept Overrides

The user may specify a different target than their profile defaults. Common patterns:
- "Research resumes for senior product marketers" — override role
- "What do resumes look like at Google for PMs?" — override company
- "Resume best practices for director-level finance" — override level + field

Use overrides when provided; fall back to profile defaults otherwise.

## Research Steps

Use WebSearch with background subagents to parallelize across source categories.

### 1. Field-Specific Resume Guides

Search for current resume guides specific to the user's field:
- "[field] resume guide 2026"
- "[target_role] resume examples"
- "best [field] resume tips"
- Field-specific career sites and communities

Do NOT rely only on tech-centric sources (Tech Interview Handbook, Levels.fyi, etc.) for
non-tech fields. Find sources that speak to the user's actual industry.

### 2. Community Insights

Search communities where professionals in the user's field discuss resumes:
- Reddit communities relevant to their field (r/marketing, r/nursing, r/cscareerquestions, r/jobs, etc.)
- Industry-specific forums and Slack communities
- Blind (for tech/corporate roles)
- Field-specific professional associations

Look for: real peer feedback, common mistakes, what hiring managers in that field actually care about.

### 3. Job Posting Analysis

If target companies are specified, search for current job postings:
- Extract the language, keywords, and qualifications emphasized
- Note patterns across multiple postings for the same role
- Identify must-have vs. nice-to-have qualifications

### 4. Professional Profile Analysis

Search for how people at the target level/company describe their work:
- LinkedIn profiles (search for "[target_role] at [company]")
- Company blog posts, team pages, or engineering/marketing/etc. blogs
- Conference speaker bios at the target level

## Synthesize Findings

Structure the output into these categories:

### Action Verb Tiers
Ranked by signal strength for the user's specific field and level. Not generic — adapted from what the research shows top performers in their field actually use.

### Bullet Structure Patterns
How to frame [action + what + scale + result] in their field. Include 3-5 real examples from the research (anonymized if needed).

### Metrics Guidance
What to quantify in their field, what not to force, and credibility thresholds. A nurse's metrics (patient outcomes, error rates) differ from a marketer's (conversion rates, campaign ROI).

### Keyword Recommendations
Terms that recruiters and ATS systems in their field search for. Sourced from job posting analysis, not guesswork.

### Anti-Patterns
Field-specific language mistakes. What signals the wrong level, wrong role, or lacks credibility in their particular industry.

### Company-Specific Calibration
If target companies were specified: what those companies specifically value vs. generic advice. Sourced from their job postings, culture pages, and employee profiles.

## Save Output

Write findings to `[data_path]/research/[YYYY-MM-DD]-[target-role-slug].md`.

Include a metadata header noting:
- Date of research
- Target role/level/field researched
- Sources consulted
- Whether this builds on prior research

## Cross-Reference

Compare new findings against the baseline in `references/career-principles.md`. Explicitly note:
- Agreements (high confidence — multiple sources align)
- Contradictions (flag for the user — field-specific advice may diverge from general principles)
- Novel findings (things not covered in the baseline)

## Safety Rails

- Prioritize recent sources (current year) — resume conventions shift fast
- Distinguish between universal advice and field/level-specific patterns
- Flag when sources conflict and note consensus vs. outlier positions
- Do not write resume bullets — return research for the user to work with
- Do not recommend keywords or skills the user can't defend
