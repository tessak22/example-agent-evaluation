## Section 01: Executive Summary

Evaluating as senior engineering leadership at a Series A SaaS company (20-person team, AWS/ECS/K8s stack), Control Plane delivers a genuinely fast and production-grade deployment experience. The CLI took a workload from zero to a live HTTPS endpoint in under 90 seconds with TLS, autoscaling, and firewall rules configured by default. The core platform works. What's broken is the path to getting there: the Docker Compose deployment feature (a key migration onramp) crashes on every input due to a CLI bug, there is no migration guide from AWS or Kubernetes anywhere in the docs or blog, and the billing/trial situation is undocumented, leaving evaluators unsure if they'll hit a paywall before deploying their first test workload.

**Bottom line:** The product is strong but the onramp is weak. Control Plane needs to fix the broken `cpln stack` command, publish an AWS migration guide, and clarify whether a free trial exists. Until then, the best parts of this platform are hidden behind unnecessary evaluation friction.

---

## Section 02: At-a-Glance Scorecard

- **Completed core workflow**: Yes. Deployed three workloads (standard, serverless, K8s-converted), created secrets, viewed logs via LogQL, verified live HTTPS endpoints, and cleaned up all resources. The Docker Compose deployment sub-path was blocked by a CLI bug but alternative paths succeeded.

- **Stages completed vs. blocked**: All 8 stages completed (First Impressions, Documentation, Pricing, Use Cases, Security & Trust, Signup & Onboarding, Core Workflow, Output & Results). No stage was fully blocked. The Docker Compose path within Core Workflow was blocked.

- **Sentiment breakdown**:
  - Positive: 22
  - Neutral: 21
  - Frustration: 16

- **Blockers encountered**: 1
  - Entry 50: `cpln stack manifest` crashes with unhandled JavaScript exception on all Docker Compose files in CLI v3.9.1

- **Top 3 friction points**:
  1. Docker Compose (`cpln stack`) completely broken in current CLI release (entry 50, blocker)
  2. No migration guide from AWS/Kubernetes anywhere in docs, blog, or website (entries 12, 22, 32, significant)
  3. Billing/trial ambiguity: homepage says "Sign Up for Free" but no free tier or trial is documented (entry 36, significant)

- **Top 3 bright spots**:
  1. CLI-to-live-endpoint in under 90 seconds with production-grade defaults (entries 47, 57)
  2. Transparent usage-based pricing with no tiers, no minimums, and bundled infrastructure (entries 14, 15, 16)
  3. Security defaults that exceed what most teams build themselves: mTLS, gVisor, HSM-backed secrets, locked-down firewall (entry 24)

- **Agent-ready score**:
  - Documentation completeness: **Medium**. 200+ pages with strong reference material, but a missing middle layer between quickstart and production deployment. An agent could follow the quickstart but would struggle to compose a realistic deployment from scattered guides.
  - API/SDK discoverability: **High**. CLI with structured JSON/YAML output, comprehensive `--help` on every command, REST API, Terraform provider, and Pulumi support. The llms.txt file is a forward-thinking touch.
  - Error message quality: **Low**. Ranges from excellent ("provide --org or set one in your profile") to raw JavaScript stack traces. An agent would fail to self-correct on bad errors.
  - Onboarding friction: **Medium**. 5 steps to first deploy with an SSO-only auth model (good) but an immutable org name as the first decision (bad) and unclear billing requirements.
  - Pricing clarity: **High**. Fully transparent usage-based pricing with per-unit costs. An agent could calculate expected costs without ambiguity.

---

## Section 03: Developer Journey Map

### Stage 1: First Impressions

- ❌ **Homepage leads with multi-cloud, not simplification.** The tagline "From Many Clouds, One" and hero messaging focus on multi-cloud orchestration. A single-cloud team drowning in K8s complexity would not immediately see themselves in this pitch. (Entry 1)
  > "My team is AWS-only right now. I'm not trying to go multi-cloud, I'm trying to stop wrestling with Kubernetes."
  > *Persona relevance: A multi-cloud pitch misses teams that are single-cloud but drowning in operational complexity.*

- ❌ **Proprietary terminology creates a learning-curve perception.** Branded terms like GVC, Cloud Wormhole, Capacity AI, and Universal Cloud Identity suggest a steep vocabulary investment before you can evaluate fit. (Entry 2)

- ✅ **Customer stories are compelling and persona-relevant.** SafeHealth (75% AWS savings, avoided 10-15 DevOps hires), Qualifi (90% cost reduction, eliminated DevOps), and Acoer (20% developer time reclaimed) are direct matches for this persona. (Entry 3)
  > "The case studies tell a better story than the hero section does. I wish the homepage led with 'stop wasting your engineers on infrastructure' instead of 'multi-cloud freedom.'"

- ❌ **Four product codenames with no guidance on which to choose.** CPLN-Serverless, CPLN-MK8s, CPLN-BYOK, and CPLN-GPU-Ocean are not immediately distinguishable from the homepage. (Entry 4)

- ❌ **"Sign Up for Free" is ambiguous.** Does "free" mean a free tier, a trial, or just that signup itself costs nothing? The homepage doesn't clarify. (Entry 5)

- ❌ **Disconnect between homepage messaging and actual customer base.** The marketing leads with enterprise multi-cloud while the customer stories prove operational simplification for small teams. (Entry 31)
  > *Persona relevance: A VP Engineering at a Series A company scanning the homepage for 30 seconds might bounce, thinking "that's not my problem."*

### Stage 2: Documentation

- ✅ **Docs are well-structured with impressive breadth.** 200+ pages covering CLI, API, Terraform, Pulumi, K8s operator, MCP server. The llms.txt file for AI discoverability is a modern touch. (Entries 6, 13)

- ✅ **Quickstart offers four parallel paths.** Console UI, CLI, Terraform, and Pulumi. Having Terraform as a first-class quickstart option is exactly right for teams already using it. (Entry 7)
  > *Persona relevance: Having Terraform as a quickstart option alongside CLI is exactly right for a team already using Terraform.*

- ✅ **CLI installs via npm with Docker Compose deploy support.** The `@controlplane/cli` npm package and `cpln stack deploy` for Compose files are direct hits for Node.js teams with Docker workflows. (Entry 8)

- ✅ **Docker Compose guide is well-documented.** The `x-cpln` block for customization, service-to-service communication via `cpln.local`, and the replace-not-merge caveat are clearly explained. (Entry 9)

- ❌ **No "connect to AWS RDS" or "connect to existing AWS services" guide.** The information exists across native networking, Cloud Wormhole, and identity docs, but is scattered across 3+ pages. (Entry 12)
  > "My team's core question is 'can this talk to our existing AWS RDS and Redis?' A clear 'connecting to existing AWS services' guide would immediately answer the most important question for our evaluation."

- ❌ **GitHub Actions example not shown inline.** The CI/CD guide points to an external examples repo instead of showing a complete workflow YAML in the docs. (Entry 10)

- ❌ **Terraform docs are thin.** Provider setup is documented but no real-world example (e.g., "deploy a Node.js API with PostgreSQL") exists in the docs themselves. (Entry 11)

- ❌ **Missing middle layer between quickstart and production.** The quickstart deploys hello-world. The reference docs explain every knob. But "migrate my real-world Node.js + PostgreSQL + Redis stack from AWS" is not documented as a coherent narrative. (Entry 32)
  > *Persona relevance: A senior engineer evaluating a platform switch needs to see the migration path, not just the destination.*

### Stage 3: Pricing

- ✅ **Transparent usage-based pricing with no tiers.** CPU at $0.062/millicore-month, RAM at $0.007/MB-month. No minimums, no contracts, no lock-ins. A typical workload under $5/month per location. (Entry 14)
  > *Persona relevance: Usage-based with no minimums is ideal for a Series A company. No surprise jumps when you cross a tier boundary.*

- ✅ **Back-of-napkin math works out to dramatic savings.** 12 microservices across 2 locations estimated at $250-400/month total, versus current EKS + ECS + AWS services costs. (Entry 15)

- ✅ **Infrastructure bundled at no extra cost.** NAT gateways, TLS certs, DNS, secrets management, container registry, audit trail, service mesh, auto-scaling all included. On AWS, these are separate line items. (Entry 16)

- ❌ **Support pricing is invisible.** "Premier support" is mentioned on the products page but not priced. No indication whether basic support is included. (Entry 17)

### Stage 4: Use Cases & Blog

- ✅ **16 customer stories spanning startups to mid-market.** Multiple direct matches for this persona: Qualifi, Linker Finance, LeasePilot, Allio. These are real startup/scaleup stories, not enterprise logos. (Entry 18)
  > *Persona relevance: The presence of multiple Series A/B-sized companies with small engineering teams and no dedicated DevOps is exactly the social proof this persona needs.*

- ✅ **Allio case study is a near-exact stack match.** Node.js, Terraform, SOC 2 compliance, serverless deployment. (Entry 20)
  > *Persona relevance: A Node.js fintech using Terraform on Control Plane with SOC 2 compliance is almost exactly what our stack evolution would look like.*

- ❌ **No migration guide exists anywhere.** Not in the blog, not in the docs, not on solutions pages. For a platform positioning itself as an alternative to raw K8s, this is table stakes. (Entry 22)

- ❌ **Blog is strategy-heavy, how-to-light.** Active posting cadence but no migration guides, architecture walkthroughs, or "how we built X" deep dives. (Entry 21)

- ❌ **Solutions sub-pages return 404 errors.** Multiple URL patterns for solutions pages listed in the nav menu returned 404. (Entry 23)

### Stage 5: Signup & Onboarding

- ✅ **SSO-only authentication is the right default.** Google, GitHub, Microsoft, and SAML. No email/password. Appropriate security posture for an infrastructure platform. (Entry 34)
  > *Persona relevance: SSO via Google or GitHub means zero credential management overhead for the team.*

- ✅ **Workload abstraction model is clean and intuitive.** Organization, GVC (environment), Workload (container). Four workload types: Serverless, Standard, Cron, Stateful. Six autoscaling strategies. (Entry 43)

- ✅ **CLI onboarding is fast and shareable.** Six commands to first deploy. npm package fits the Node.js toolchain. Commands are copy-pasteable in Slack. (Entry 44)
  > *Persona relevance: For a team of 20 engineers, the CLI path is how adoption actually spreads.*

- ❌ **Organization names are immutable with no documented warning.** The first action after signup is creating an org that can never be renamed or deleted. (Entry 35)
  > "If I fat-finger my org name or use a placeholder, I'm stuck with it."

- ❌ **Billing/trial situation is undocumented.** Docs require "establishing a billing account" as a prerequisite. No free tier or trial is mentioned. "Sign Up for Free" on the homepage may be misleading. (Entry 36)
  > *Persona relevance: A senior engineer doing a quick evaluation doesn't want to enter a credit card to kick the tires.*

- ❌ **Demo request form requires phone number.** Five required fields including phone number to schedule a demo. Signals enterprise sales, not developer self-service. (Entry 40)
  > *Persona relevance: Requiring a phone number immediately flags this as a high-touch sales process.*

- ❌ **Product demo videos have no titles or descriptions.** Six bare YouTube embeds with no way to know which one is relevant without watching them all. (Entry 39)

- ❌ **No in-product onboarding documented.** No mention of wizards, tours, tooltips, or checklists inside the console. (Entry 42)
  > *Persona relevance: Engineers will sign in and click around. If the console doesn't guide them, the first experience will be confusing.*

- ❌ **Docs bootstrapping gap.** The org creation guide requires an `org_creator` role "assigned by a billing administrator," but doesn't explain what happens for the very first user signing up. (Entry 37)

### Stage 6: Core Workflow

- ✅ **GVC creation and workload deployment in under 90 seconds.** `cpln gvc create` completed instantly. Workload was live and responding to HTTP in about 60 seconds. 242ms response time on the endpoint. (Entry 47)
  > "From gvc create to live HTTP response: under 90 seconds. That's genuinely impressive."

- ✅ **`cpln apply` worked first try with a custom YAML definition.** Serverless workload with autoscaling by concurrency, Capacity AI, and env vars deployed cleanly. (Entry 48)

- ✅ **K8s-to-CPLN converter is a practical migration tool.** `cpln convert` correctly translated a standard K8s Deployment + Service into deployable Control Plane YAML. The convert-then-apply pipeline worked end-to-end. (Entry 49)
  > *Persona relevance: This is exactly the migration path a team would need. Take existing K8s YAML, convert, review, apply.*

- ✅ **GitHub Actions workflow is composable and portable.** About 30 lines using CLI commands. No proprietary GitHub Action required. Same commands work in any CI system. (Entry 54)

- ❌ **`cpln stack manifest` crashes on all Docker Compose files.** Unhandled JavaScript exception ("Cannot read properties of undefined") in CLI v3.9.1. Tested with multiple compose file variations. (Entry 50)

- ❌ **Secret creation has poor discoverability.** 13 type-specific `create-*` subcommands instead of a unified `create --type`. Requires file input for simple string values. Error message ("Did you mean update?") is misleading. (Entry 51)

- ❌ **Logs require LogQL syntax, not workload names.** `cpln logs "hello-world" --gvc eval-test-gvc` fails. Correct syntax is `cpln logs '{workload="hello-world", gvc="eval-test-gvc"}'`. (Entry 52)
  > *Persona relevance: Making engineers learn LogQL syntax before they can see a log line is unnecessary friction.*

- ❌ **Error messages are inconsistent.** Ranges from excellent to raw JS exceptions. Some errors suggest the wrong command. (Entry 55)

- ❌ **Destructive operations have no confirmation prompt.** `cpln gvc delete` removes the GVC and all workloads silently. No "are you sure?" by default. (Entry 56)
  > *Persona relevance: In a 20-person team, someone will eventually run `cpln gvc delete production` by accident.*

### Stage 7: Output & Results

- ✅ **Time-to-working-deployment is competitive with the best PaaS platforms.** Under 2 minutes from CLI install to live endpoint. Under 5 minutes including a custom serverless workload with autoscaling. (Entry 57)
  > "This is faster than any Kubernetes-based deployment I've done. It's competitive with Heroku/Railway for speed but with production-grade features those platforms lack."

- ✅ **Deployed workloads have production-grade defaults.** TLS automatic, firewall locked down by default, mTLS between services, autoscaling configured. (Entry 58)
  > *Persona relevance: The gap between "evaluation deployment" and "production deployment" is mostly about data connections (RDS, Redis), not about the platform itself.*

- ✅ **The CLI is the star of this product.** The core loop of define-apply-live is excellent. The YAML definitions are simpler than K8s manifests while being more capable. (Entry 59)

---

## Section 04: Critical Issues Blocking Adoption

### 1. Docker Compose deployment path is completely broken

**What happened:** `cpln stack manifest` crashes with "Cannot read properties of undefined (reading 'replace')" on every Docker Compose file tested, including a bare-minimum compose.yaml with only an image and port. This is a bug in CLI version 3.9.1. (Entry 50)

**Impact:** The agent worked around it by using `cpln apply` and `cpln convert` instead. But the Docker Compose path is specifically promoted in the docs as the easy migration onramp. Having it broken in the current release means the most accessible migration story doesn't work.

> "The Docker Compose path was one of the most compelling migration stories. Having it broken in the current CLI release undermines that entire narrative. My team's services all have docker-compose files. This was supposed to be the easy path."

*Persona relevance: A Node.js team with existing Docker workflows would naturally try Compose first. This broken path would shake confidence in the platform's reliability during the critical evaluation window.*

### 2. No migration guide from AWS or Kubernetes

**What happened:** No dedicated migration guide exists anywhere across the docs (200+ pages), blog (10+ posts), or website solutions pages. The agent searched in all three locations. (Entries 12, 22, 32)

**Impact:** The agent was able to piece together a migration approach from the K8s converter, native networking docs, and secrets guides, but this required reading 5-6 separate pages. The persona's central evaluation question ("could this replace our current infrastructure?") cannot be answered from a single document.

> "The entire evaluation question is 'could this replace our current infrastructure?' Without a migration guide, I'm left guessing at how painful the transition would actually be."

*Persona relevance: A team evaluating a platform switch needs to see the complete transition path. The gap between "hello world quickstart" and "production deployment reference" is where the evaluation stalls.*

### 3. Billing/trial ambiguity creates a trust gap

**What happened:** The homepage says "Sign Up for Free." The docs require "establishing a billing account" as a prerequisite for the quickstart. No free tier or trial period is documented. (Entry 36)

**Impact:** The agent was already logged in to an existing account, so this didn't block the core workflow. But for a new evaluator, this ambiguity could stop the evaluation before it starts. Entering a credit card for an unknown cost structure is a high-friction ask.

> "If there's a free trial or sandbox, it's not documented. If there isn't one, the 'Sign Up for Free' CTA on the homepage is misleading."

*Persona relevance: A senior engineer doing a quick evaluation at a startup is comparing multiple tools. Having to commit financially before seeing the product is a competitive disadvantage against platforms with explicit free tiers.*

---

## Section 05: Quick Wins

**1. Fix `cpln stack manifest` crash**
*Small Effort*
This is a bug in CLI v3.9.1 causing an unhandled JS exception. Fix the bug and release a patch. The Docker Compose deployment path is documented and promoted but non-functional. Every evaluator who tries it will hit this.
Addresses: Entry 50

**2. Publish a "Migrating from AWS ECS/EKS" guide**
*Medium Effort*
Write a single, end-to-end guide covering: connecting to existing RDS via PrivateLink, managing secrets for database credentials, converting K8s manifests with `cpln convert`, deploying the first service, and setting up CI/CD with GitHub Actions. The pieces exist in scattered docs pages. Combine them into one narrative.
Addresses: Entries 12, 22, 32

**3. Document the free tier/trial situation explicitly**
*Small Effort*
If a free trial exists, say so on the pricing page and homepage. If it doesn't, remove "Sign Up for Free" or replace it with "Start for Under $5/month." Ambiguity here costs conversions.
Addresses: Entries 5, 36

**4. Add `cpln workload logs <name>` as a shortcut**
*Small Effort*
Keep LogQL for power users but add a simple `cpln workload logs <name> --gvc <gvc>` command that wraps the LogQL query. First-time users should not need to learn a query language to see their logs.
Addresses: Entry 52

**5. Add confirmation prompts for destructive operations**
*Small Effort*
`cpln gvc delete` and `cpln secret delete` should prompt "Are you sure? This will delete [resource] and all its children. Type the name to confirm:" unless a `--yes` or `--force` flag is passed.
Addresses: Entry 56

**6. Add titles and descriptions to product demo videos**
*Small Effort*
The six YouTube embeds on the product demos page have no labels. Add a title and one-sentence description to each so evaluators can find the relevant demo without watching all six.
Addresses: Entry 39

**7. Simplify secret creation with a unified `create` command**
*Small Effort*
Add `cpln secret create --type opaque --name <name> --value <value>` as a simpler alternative to the 13 type-specific subcommands. Keep the subcommands for advanced use but provide a discoverable default path.
Addresses: Entry 51

**8. Add a warning about org name immutability during creation**
*Small Effort*
Surface "Organization names cannot be changed or deleted after creation" prominently in the org creation flow, both in the console UI and in the documentation.
Addresses: Entry 35

---

## Section 06: What the Agent Found Valuable

### CLI-to-live-endpoint speed
The core deployment loop is genuinely fast: install the CLI in 11 seconds, create a GVC instantly, deploy a workload and have a live HTTPS endpoint in under 90 seconds. This is competitive with the best PaaS platforms while providing production-grade features (autoscaling, mTLS, firewall rules) that those platforms lack. This is the product's most defensible advantage.
> "From gvc create to live HTTP response: under 90 seconds. That's genuinely impressive." (Entry 47)

### Transparent, usage-based pricing
No tiers, no minimums, no contracts. Per-millicore and per-MB pricing that a developer can calculate on a napkin. NAT gateways, TLS, DNS, secrets, service mesh, and auto-scaling are bundled at no extra cost. This removes an entire class of hidden costs that plague AWS deployments.
> "NAT gateways alone cost us ~$100+/month. TLS cert management is a pain. The fact that these are bundled is a genuine differentiator." (Entry 16)

### Security defaults that exceed DIY Kubernetes
End-to-end TLS with Let's Encrypt, mTLS with hourly cert rotation between services, gVisor for container isolation, HSM-backed envelope encryption for secrets, and a locked-down firewall by default. A small team without a security engineer inherits enterprise-grade security posture automatically.
> "As a team that doesn't have a dedicated security engineer, inheriting this level of security by default is genuinely valuable. We'd never build this ourselves." (Entry 24)

### K8s manifest converter as a migration tool
`cpln convert` correctly translates standard Kubernetes Deployment + Service YAML into Control Plane format, preserving resource limits, ports, env vars, replicas, and labels. The convert-then-apply pipeline works end-to-end and provides a practical migration path from existing K8s infrastructure.
> "This is exactly the migration path my team would need. Take existing K8s YAML, convert it, review the output, apply." (Entry 49)

### Customer case studies from similar-sized companies
16 customer stories, with several direct matches for a Series A team: Qualifi (eliminated DevOps bottlenecks), LeasePilot (no internal DevOps team), Allio (Node.js serverless with Terraform and SOC 2). These are credible proof points from real startups, not enterprise logos.
> "The presence of multiple Series A/B-sized companies with small engineering teams and no dedicated DevOps is exactly the social proof I need." (Entry 18)

### SOC 2 Type II and PCI DSS Level 1 certifications
Compliance badges in the footer, third-party penetration testing, OWASP-aligned development. Audit reports available on request. This is credible compliance posture that saves a growing company months of work.

### Terraform and GitHub Actions as first-class citizens
The Terraform provider is on the registry. The CLI works as a standard shell tool in any CI system. A 30-line GitHub Actions workflow handles the full build-push-deploy cycle. No proprietary CI abstractions or vendor lock-in.
> "GitHub Actions is our CI/CD. A 30-line deployment workflow using CLI commands is exactly the right level of complexity." (Entry 54)

### npm-based CLI fits Node.js toolchains
`npm install -g @controlplane/cli` is the install path. No separate binary, no extra runtime. Structured JSON/YAML output, shell completion, and comprehensive `--help` on every command. The CLI is the best part of this product.

---

## Section 07: Evaluation Profile

- **Persona**: Senior engineering leadership (Full-Stack/DevOps/Platform) at a Series A SaaS company. 20-person engineering team. Node.js/TypeScript, Python, PostgreSQL, Redis, Docker, Kubernetes, AWS (ECS, EKS, RDS), Terraform, GitHub Actions.
- **Evaluation lens**: "Could this replace our current infrastructure setup so my engineers spend time on product instead of DevOps, without hiring a platform engineer?"
- **Scope**: Full pre-signup discovery (homepage, docs, pricing, blog, security), signup and onboarding flow assessment, and hands-on core workflow (CLI install, GVC creation, workload deployment, K8s conversion, Docker Compose attempt, secrets, logs, Terraform config, GitHub Actions workflow, cleanup).
- **Stages reached**: All 8 stages completed. No stage fully blocked.
- **Session summary**: The agent installed the CLI, deployed three workloads to a live environment, verified HTTPS endpoints, queried logs, and cleaned up resources. The core platform delivered on its promise of fast, production-grade container deployment. The evaluation was slowed by a broken Docker Compose command, scattered documentation for AWS integration, and ambiguity around billing. The product is strong where it matters most (deploy speed, security defaults, pricing transparency) but loses potential adopters through onboarding friction and missing migration content.
