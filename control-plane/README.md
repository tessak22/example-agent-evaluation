# Agent-Based Developer Product Evaluation: Control Plane

An evaluation of [Control Plane](https://controlplane.com) conducted entirely by an AI agent (Claude Code) acting as a senior engineering leader at a Series A SaaS company. This project demonstrates a structured, multi-phase framework for evaluating developer tools through the lens of a specific persona.

## What Is This?

This is an **agent-based product evaluation** — a methodology where an AI agent walks through the full evaluation journey a developer or engineering leader would take when considering a new platform. The agent follows a structured persona, logs every observation with sentiment and severity, and produces a findings report at the end.

The product evaluated here is **Control Plane**, a container deployment and orchestration platform. The agent evaluated it across four phases, from reading the homepage to deploying live workloads via the CLI.

## Evaluation Persona

| Field | Details |
|-------|---------|
| **Role** | Senior Engineering Leadership |
| **Company** | Series A SaaS, 20-person engineering team |
| **Current Stack** | Node.js/TypeScript, AWS (ECS/EKS), Terraform, GitHub Actions |
| **Core Question** | "Could this replace our infrastructure so my engineers spend time on product instead of DevOps, without hiring a platform engineer?" |

## Evaluation Phases

| Phase | Description | Entries |
|-------|-------------|---------|
| **Phase 1** — Pre-Signup Discovery | Web crawl of homepage, docs, pricing, case studies, and security pages | 1–32 |
| **Phase 2** — Signup & Onboarding | Authentication methods, org creation, billing flow, onboarding experience | 33–45 |
| **Phase 3** — Core Workflow | Hands-on CLI testing: deployed workloads, created secrets, tested converters, wrote Terraform and CI/CD configs | 46–59 |
| **Phase 4** — Findings Report | Structured report with scorecard, journey map, critical issues, and quick wins | Report |

## Key Findings

- **59 log entries** across 8 evaluation stages
- **Sentiment**: 22 positive, 21 neutral, 16 frustration
- **1 blocker**: `cpln stack manifest` (Docker Compose deployment) crashes on all input in CLI v3.9.1
- **Bright spot**: CLI to live HTTPS endpoint in under 90 seconds with TLS, autoscaling, and firewall defaults

## Contents

```
├── evaluation-log.md                  # Full 59-entry evaluation log
├── findings-report.md                 # Structured findings report
├── cpln-test-app/                     # Artifacts created during hands-on testing
│   ├── server.js                      #   Node.js test server
│   ├── Dockerfile                     #   Container definition
│   ├── cpln-workload.yaml             #   Native CPLN workload definition
│   ├── k8s-deployment.yaml            #   Kubernetes manifest (input for converter)
│   ├── converted-k8s.yaml             #   Output of cpln convert
│   ├── docker-compose.yml             #   Compose file (triggered CLI bug)
│   ├── terraform/main.tf              #   Terraform configuration
│   └── .github/workflows/deploy.yml   #   GitHub Actions deployment workflow
└── README.md
```

## How It Was Built

The entire evaluation — web research, CLI installation, live deployments, log entries, and the findings report — was performed by Claude Code in a single session using the [Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code). The agent installed the Control Plane CLI, created GVCs, deployed workloads to real infrastructure, verified HTTP endpoints, queried logs, and cleaned up resources.
