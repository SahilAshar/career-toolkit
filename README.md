# career-toolkit

AI-powered career optimization for everyone. Resume review, LinkedIn optimization, and job search research — works for any field, any level.

## What it does

Install this Claude Code plugin and get four skills:

- **`/career-toolkit:setup`** — Interactive onboarding. Answer a few questions about your career goals and drop in your resume. Takes about 5 minutes.
- **`/career-toolkit:resume-review`** — Three-perspective resume review (recruiter, ATS/keywords, level-signal). Get specific, actionable feedback.
- **`/career-toolkit:linkedin`** — Optimize your LinkedIn profile with field-appropriate language. Get multiple draft options to choose from.
- **`/career-toolkit:resume-research`** — Research what great resumes look like for your specific target role. Get patterns, keywords, and anti-patterns.

## Getting started

1. Open Claude Code
2. Install the plugin: `/plugin install career-toolkit`
3. Run setup: `/career-toolkit:setup`
4. Follow the prompts — Claude will walk you through everything

## How it works

Setup asks you a few questions (your field, target role, career level, feedback preferences) and creates a profile that all the other skills use. Your data lives in two places:

- **`~/Documents/career-toolkit/`** — Your workspace. Resume, drafts, and research live here. Browse it in Finder anytime.
- **`~/.claude/career-toolkit.local.md`** — Plugin config. Stores your profile so skills work from any directory.

## Works for any field

This toolkit adapts to your industry. Whether you're in engineering, marketing, nursing, finance, education, design, or anything else — the skills adjust their language, examples, keyword research, and review criteria to match your field.

## Requirements

- [Claude Code](https://claude.ai/code) (desktop app or CLI)
