---
name: linkedin
version: 0.1.0
description: >
  This skill should be used when the user asks to "optimize my linkedin", "review my
  linkedin", "update my linkedin", "linkedin help", "improve my linkedin profile",
  or wants feedback on their LinkedIn profile sections. Reviews and rewrites LinkedIn
  content with field-appropriate, high-signal language.
---

# LinkedIn Optimization

Review and optimize LinkedIn profile sections. All changes are drafted for the user to
copy-paste into LinkedIn manually — never claim to update LinkedIn directly.

## Load Context

1. Read `~/.claude/career-toolkit.local.md` for profile data (field, target role, level, feedback style, data path).
   - If the file doesn't exist, inform the user: "Looks like you haven't set up your profile yet. Run `/career-toolkit:setup` first — it takes about 5 minutes." Stop here.
2. Read `data_path` from the profile to locate the user's workspace (default: `~/Documents/career-toolkit/`).
3. Check if `linkedin.md` exists in the workspace (from a previous session). If yes, read it as current state.
4. If `resume.md` exists, read it for context — metrics and details to pull from.

## Get LinkedIn Text

If no `linkedin.md` exists, obtain the user's current LinkedIn content:

**Option A (recommended):** "Copy the text from your LinkedIn profile sections and paste them here. Start with your headline and About section — we can do Experience after."

**Option B:** "You can also download your LinkedIn profile as a PDF: go to your profile, click the 'More' button, then 'Save to PDF.' Drop the PDF into your career-toolkit folder in Documents."

After receiving content, save it to `[data_path]/linkedin.md` as the current-state reference.

## Review Process

Read `${CLAUDE_PLUGIN_ROOT}/references/career-principles.md` — specifically the "LinkedIn vs. Resume" and "LinkedIn Style Principles" sections for grounding.

### Analyze Each Section

For each LinkedIn section (Headline, About, Experience entries, Skills):

1. **Compare against target positioning** from the profile. Does this section support where the user is heading?
2. **Check for field-appropriate language.** A marketer's LinkedIn reads differently from an engineer's or a nurse's. Adapt the voice to match the user's field.
3. **Check for level-appropriate signals.** Use the level signals from career-principles.md, adapted to the user's field.
4. **Flag issues:** too long, too generic, too resume-like, missing keywords for their target role, or containing anti-patterns.

### Draft Revisions

Write all proposed changes to `[data_path]/drafts/linkedin-revisions.md`.

For each section being revised:
- Show the current text
- Provide **2-3 alternative versions** at different lengths/tones — the user riffs on options rather than accepting a single draft
- Explain briefly why each change matters (1 sentence per suggestion)
- Mark sections as `[PENDING]` or `[APPLIED]` so progress tracks across sessions

### Style Adaptation by Field

The core principles are universal (brevity, ownership language, results over tasks). The voice adapts:

- **Technical fields:** Emphasize systems, scale, architecture decisions. Name technologies.
- **Creative fields:** Emphasize craft, impact on brand/audience, portfolio-worthy projects.
- **Healthcare:** Emphasize patient outcomes, protocol improvements, certifications, compliance.
- **Business/finance:** Emphasize revenue impact, portfolio size, risk management, client outcomes.
- **Education:** Emphasize student outcomes, curriculum development, program growth.

Do not apply a tech voice to a non-tech user's profile.

## Iterate

Expect pushback on tone. When the user says something doesn't sound like them:
- Go shorter — the answer is almost always fewer words
- Ask what specifically feels off
- Generate new options that incorporate their feedback
- Reference how professionals in their specific field actually write their profiles

## Safety Rails

- Never suggest skills or keywords the user can't back up in a conversation
- Never claim to update LinkedIn — always produce drafts for manual copy-paste
- Don't erase personality, side projects, or non-traditional experience — reframe it as a strength
- Adapt feedback tone to the user's stated preference from their profile
