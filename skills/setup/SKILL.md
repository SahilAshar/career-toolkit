---
name: setup
description: >
  This skill should be used when the user asks to "set up my profile", "get started",
  "initialize career toolkit", "setup", or is using the career-toolkit plugin for the
  first time. Guides the user through an interactive onboarding flow — collecting career
  context, creating a workspace folder, and ingesting their resume.
---

# Career Toolkit Setup

Interactive onboarding that creates the user's career profile and workspace. This is often
the user's first experience with Claude Code — keep language plain, avoid jargon, and explain
every step.

## Pre-Flight Check

1. Check if `~/.claude/career-toolkit.local.md` already exists.
   - If yes: inform the user a profile already exists. Offer to update it or start fresh. Read the existing profile and show a summary of what's on file.
   - If no: proceed with fresh setup.

## Interview Flow

Use the AskUserQuestion tool for structured questions where possible. Ask in batches of 1-2 questions — do not overwhelm.

### Round 1: Identity

Collect in conversation:
- **Name** — "What's your name?"
- **Field/industry** — "What field or industry do you work in?" Give examples: marketing, engineering, nursing, finance, education, design, etc.
- **Current role** — "What's your current job title?"

### Round 2: Goals

- **Target role** — "What role are you aiming for next?" Explicitly note: "If you're not sure yet, that's totally fine — just say 'exploring' and we can figure it out together."
- **Target level** — Frame in plain language, not corporate ladder codes. Use AskUserQuestion with options like: "Early career", "Mid-level", "Senior / Lead", "Director / Executive", "Not sure"
- **Target companies** — "Any specific companies you're interested in? This is optional but helps me tailor keyword advice."

### Round 3: Preferences

- **Feedback style** — Use AskUserQuestion: "How do you like to receive feedback?" with options: "Direct and blunt — don't sugarcoat it", "Encouraging but honest", "Detailed and thorough", "High-level bullets only"

## Create Workspace

1. Create `~/Documents/career-toolkit/` and `~/Documents/career-toolkit/drafts/` and `~/Documents/career-toolkit/research/`
2. Tell the user clearly: "I created a folder called **career-toolkit** in your Documents folder. You can find it in Finder by going to Documents > career-toolkit. This is where your drafts and research will live."

## Resume Ingestion

Offer two paths:

1. **PDF drop** — "Do you have your resume as a PDF? Drop it into the career-toolkit folder in your Documents and tell me when it's there." Then read the PDF from `~/Documents/career-toolkit/` (look for any .pdf file) using the Read tool.
2. **Paste** — "Or you can paste your resume text right here in the chat."

If the user doesn't have a resume ready, that's fine — note it in the profile as pending and move on. The review and research skills still work with just the profile context.

When a resume is provided:
- Extract the text content
- Write a clean markdown version to `~/Documents/career-toolkit/resume.md`
- Preserve all content faithfully — do not rewrite or improve it during ingestion

## Write Profile

Save the collected information to two locations:

### ~/.claude/career-toolkit.local.md

This is the plugin's persistent config. Write YAML frontmatter with all profile fields:

```yaml
---
name: [name]
field: [field/industry]
current_role: [current title]
target_role: [target role or "exploring"]
level: [current level]
target_level: [target level]
companies: [list of target companies, or empty]
feedback_style: [direct/encouraging/detailed/high-level]
data_path: ~/Documents/career-toolkit
setup_complete: true
resume_ingested: [true/false]
---
```

### ~/Documents/career-toolkit/profile.md

A human-readable version the user can browse in Finder or any text editor. Write it in plain markdown with headers and descriptions — not raw YAML.

## First Value Offer

After setup completes, offer an immediate next step:

"Your profile is all set! Here's what you can do now:"
- "Type `/career-toolkit:resume-review` to get a detailed review of your resume"
- "Type `/career-toolkit:linkedin` to optimize your LinkedIn profile"
- "Type `/career-toolkit:resume-research` to research what great resumes look like in your field"

If a resume was ingested, recommend starting with resume-review. If not, recommend resume-research.

## Edge Cases

- **User doesn't know their target role**: Record "exploring" — all other skills handle this gracefully by providing general best practices rather than role-specific advice.
- **~/Documents/ doesn't exist**: Check for it before creating. If missing (unusual), fall back to creating `~/career-toolkit/` and note the path in the config.
- **Non-English resume**: Ingest as-is. Note the language in the profile so review/research skills can adapt.
- **User wants to update an existing profile**: Read the current .local.md, show what's on file, ask what they want to change, and update only the changed fields.
