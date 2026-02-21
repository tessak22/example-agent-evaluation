# Agent-Based Developer Product Evaluation: Laravel Cloud

An evaluation of [Laravel Cloud](https://cloud.laravel.com) conducted entirely by an AI agent (Claude Code) acting as a senior engineering lead at a Series B SaaS company running Laravel on Forge. This project demonstrates a structured, multi-phase framework for evaluating developer tools through the lens of a specific persona.

## What Is This?

This is an **agent-based product evaluation** — a methodology where an AI agent walks through the full evaluation journey a developer or engineering leader would take when considering a new platform. The agent follows a structured persona, logs every observation with sentiment and severity, and produces a findings report at the end.

The product evaluated here is **Laravel Cloud**, a fully managed deployment platform for Laravel applications built by the Laravel team. The agent evaluated it across four phases, from reading the homepage to writing deployment workflows and API provisioning scripts.

## Evaluation Persona

| Field | Details |
|-------|---------|
| **Role** | Senior Full-Stack / Backend Engineer, Engineering Lead |
| **Company** | Series B SaaS, 30-person engineering team |
| **Current Stack** | PHP 8.3/Laravel 11, MySQL, Redis, AWS (EC2 via Forge), GitHub Actions, Inertia.js + Vue |
| **Core Question** | "Could this replace our Forge setup so we stop managing servers and get autoscaling, preview environments, and faster deploys without hiring a DevOps engineer?" |

## Evaluation Phases

| Phase | Description | Entries |
|-------|-------------|---------|
| **Phase 1** — Pre-Signup Discovery | Web crawl of homepage, docs (172 pages), pricing, comparisons, security, trust center, status page, blog, and incident reports | 1–37 |
| **Phase 2** — Signup & Onboarding | Authentication flow, org creation, billing, source control, environments, queues, scheduled tasks, team roles | 38–52 |
| **Phase 3** — Core Workflow | Created Laravel 12 app, evaluated API documentation, wrote GitHub Actions workflows, wrote API provisioning script, assessed databases, domains, logging, Octane/SSR, and Cloud vs Forge | 53–70 |
| **Phase 4** — Findings Report | Structured report with scorecard, journey map, critical issues, quick wins, and recommendations | Report |

## Key Findings

- **70 log entries** across 8 evaluation stages
- **Sentiment**: 42 positive · 22 neutral · 6 frustration
- **0 blockers** — an unusual result; all friction points are minor
- **Bright spot**: Zero-config deployment — no CLI, no Docker, no YAML, no infrastructure account. Git push triggers a full build/deploy with TLS, CDN, and autoscaling
- **Primary risk**: Operational maturity — 3-hour outage day before evaluation, Early Access API, one published case study, Cloud absent from public status page

## Contents

```
├── evaluation-log.md                           # Full 70-entry evaluation log
├── findings-report.md                          # Structured findings report
├── test-app/                                   # Laravel 12 application with deployment artifacts
│   ├── .github/workflows/deploy.yml            #   Deploy hook GitHub Actions workflow
│   ├── .github/workflows/deploy-api.yml        #   API-based GitHub Actions workflow
│   ├── scripts/provision.sh                    #   Full API provisioning script
│   └── ...                                     #   Standard Laravel 12 scaffolding
└── README.md
```

## How It Was Built

The entire evaluation — web research, documentation analysis, application scaffolding, CI/CD workflows, API scripts, log entries, and the findings report — was performed by Claude Code in a single session using the [Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code). The agent created a real Laravel application, wrote deployment workflows targeting the Laravel Cloud API, and wrote a provisioning script demonstrating the full infrastructure lifecycle. Live deployment was not performed because the platform's intentional UI-first, no-CLI design gates hands-on testing behind account creation.
