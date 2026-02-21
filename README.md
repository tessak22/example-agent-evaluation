# Built for Devs — Agent-Based Product Evaluations

Real product evaluations conducted by an AI agent walking through the full developer journey — from first landing page visit to live deployments. Each evaluation follows a structured, persona-driven methodology and produces a detailed log of every observation alongside a findings report with actionable results.

## What You Get

Every evaluation produces three things:

1. **Evaluation Log** — A sequential record of every action the agent took, what it observed, and how it felt about it. Each entry is tagged with sentiment (positive / neutral / frustration), severity, and persona relevance.
2. **Findings Report** — A structured deliverable with an executive summary, scorecard, developer journey map, critical issues, quick wins, and recommendations.
3. **Test Artifacts** — Real code, configs, and deployment files created during hands-on testing (Dockerfiles, Terraform configs, CI/CD workflows, YAML manifests, etc.).

## Completed Evaluations

| Product | Category | Entries | Sentiment | Blockers | Report |
|---------|----------|---------|-----------|----------|--------|
| [Control Plane](control-plane/) | Container Orchestration | 59 | 22 positive · 21 neutral · 16 frustration | 1 | [Findings Report](control-plane/findings-report.md) |

## Evaluation Methodology

Each evaluation runs through four phases:

| Phase | What Happens |
|-------|-------------|
| **Phase 1 — Pre-Signup Discovery** | Homepage, docs, pricing, case studies, security, and trust signals are crawled and assessed from the outside |
| **Phase 2 — Signup & Onboarding** | Authentication flow, org setup, billing, onboarding experience, and time-to-value are evaluated |
| **Phase 3 — Core Workflow** | Hands-on testing with real tools — CLI installs, live deployments, API calls, IaC configs, CI/CD pipelines, error handling |
| **Phase 4 — Findings Report** | Everything is synthesized into a structured report with scores, issues, and recommendations |

The agent operates under a defined **persona** (role, seniority, tech stack, priorities) so every observation is grounded in a specific buyer context — not generic commentary.

## How It Works

Evaluations are conducted by [Claude Code](https://docs.anthropic.com/en/docs/claude-code) following structured prompts that define the persona, evaluation path, output format, and rules of engagement. The agent has access to web browsing, CLI tools, file creation, and real infrastructure — it doesn't just read docs, it actually deploys things and reports what happens.
