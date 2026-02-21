# Control Plane — Evaluation Log

## Evaluation Metadata

| Field | Details |
|-------|---------|
| **Product** | Control Plane |
| **URL** | https://controlplane.com |
| **Description** | Container deployment and orchestration platform aimed at backend and DevOps engineers managing cloud infrastructure |
| **Date** | 2026-02-21 |
| **Scope** | Full evaluation — Pre-signup discovery, Signup & Onboarding, Core Workflow, and Output & Results |

### Evaluator Persona

| Field | Details |
|-------|---------|
| **Role** | Full-Stack / DevOps / Platform / Backend |
| **Seniority** | Senior / Engineering Leadership |
| **Company Context** | Series A SaaS company, 20-person engineering team, currently managing infrastructure on AWS with a mix of ECS and raw Kubernetes that's becoming painful to maintain as the team grows |
| **Tech Stack** | Node.js/TypeScript, Python, PostgreSQL, Redis, Docker, Kubernetes, AWS (ECS, EKS, RDS), Terraform, GitHub Actions |
| **Priorities** | Reducing infrastructure operational overhead, developer self-service for deployments, not needing a dedicated platform engineering hire, production-grade reliability without Kubernetes complexity, clear pricing that scales predictably with usage |
| **Evaluation Lens** | "Could this replace our current infrastructure setup so my engineers spend time on product instead of DevOps, without hiring a platform engineer?" |

---

## Phase 1 — Pre-Signup Discovery

### Stage: First Impressions

#### Entry 1 — Loaded controlplane.com homepage and read the hero section
> **Sentiment:** Neutral · **Severity:** Minor

The tagline is "From Many Clouds, One" and the primary pitch is about deploying across AWS, GCP, and Azure as a unified environment. My first reaction is that this is heavily multi-cloud oriented. My team is AWS-only right now. I'm not trying to go multi-cloud — I'm trying to stop wrestling with Kubernetes. The homepage doesn't immediately tell me "stop managing K8s, we'll handle it." It tells me "run across all clouds." That's a different problem than the one I have.

**Persona Relevance:** A multi-cloud pitch misses teams like mine that are single-cloud but drowning in operational complexity. The primary value prop feels targeted at enterprises already committed to multi-cloud, not a 20-person team trying to simplify.

---

#### Entry 2 — Read the feature callouts and value propositions on the homepage
> **Sentiment:** Neutral · **Severity:** Minor

Scrolling past the hero, I see claims of 99.999% uptime, 60-80% cost reduction, and "10x developer productivity." The feature set is actually deep — Global Virtual Cloud, Capacity AI for auto-scaling, Universal Cloud Identity for cross-cloud IAM, built-in service mesh and observability. There's a lot here. But the branded terminology (GVC®, Cloud Wormhole®, Capacity AI) makes me feel like I'm going to have to learn a whole proprietary vocabulary before I even know if this fits.

---

#### Entry 3 — Reviewed customer logos and case studies on the homepage
> **Sentiment:** Positive

The customer stories are actually compelling for my situation. SafeHealth reduced AWS spend by 75% and "avoided hiring 10-15 DevOps engineers." Qualifi cut server costs by 90% and "eliminated the time we spent on DevOps." Acoer talks about developers spending 20% of time on DevOps and fixing that. These are exactly my pain points. The case studies tell a better story than the hero section does. I wish the homepage led with "stop wasting your engineers on infrastructure" instead of "multi-cloud freedom."

**Persona Relevance:** The customer stories — particularly Qualifi, SafeHealth, LeasePilot, and Acoer — map almost perfectly to a Series A team trying to reduce DevOps overhead without hiring.

---

#### Entry 4 — Checked the homepage navigation and product structure
> **Sentiment:** Frustration · **Severity:** Minor

The nav has Solutions, Pricing, Products, Resources, and Company. Under Products I later found there are actually four distinct products: CPLN-Serverless, CPLN-MK8s (Managed Kubernetes), CPLN-BYOK, and CPLN-GPU-Ocean. This isn't immediately clear from the homepage. I'd need to figure out which product applies to me. For my use case it's probably CPLN-Serverless, but having four products with codenames means I need to do research just to figure out what to buy.

---

#### Entry 5 — Looked for a "Talk to Sales" vs "Self-Serve" path
> **Sentiment:** Neutral · **Severity:** Minor

There are two CTAs — "Sign Up for Free" and "Talk to an Engineer." The sign-up links to console.cpln.io/signup. This is good — I can try it without talking to sales. But there's no free tier mentioned on the homepage. "Sign Up for Free" is ambiguous. Does free mean there's a free tier, or does it just mean the signup is free? That ambiguity would make me hesitate.

---

### Stage: Documentation

#### Entry 6 — Navigated to docs.controlplane.com and read the docs landing page
> **Sentiment:** Positive

The docs are structured well. I can see quickstart guides, concepts, reference docs, guides, CLI reference, IaC integrations (Terraform, Pulumi), and even an MCP server section. The breadth is impressive. The docs also publish an llms.txt file, which is a nice modern touch — they're thinking about AI-assisted workflows.

---

#### Entry 7 — Read the quickstart guide
> **Sentiment:** Positive

The quickstart walks through creating a GVC across aws-us-west-2 and gcp-us-east1, then deploying a sample "helloworld-go" workload. Four paths are offered: Console UI, CLI, Terraform, and Pulumi. The CLI path is clean — install via npm or Homebrew, login, create GVC, create workload, open it. About 6 commands total. That's a solid first-run experience. I appreciate that Terraform is a first-class citizen since that's already in our stack.

**Persona Relevance:** Having Terraform as a quickstart option alongside CLI is exactly right for a team already using Terraform. I wouldn't have to learn a new IaC tool.

---

#### Entry 8 — Examined the CLI installation and toolchain
> **Sentiment:** Positive

The CLI installs via `npm install -g @controlplane/cli` or Homebrew. It's a Node.js package — aligns well with our stack. The CLI has shell completion, structured output (JSON/YAML), and covers the full resource lifecycle. There's also a `cpln stack deploy` command that reads Docker Compose files directly. That's a very smart onramp — most of our services already have docker-compose files for local dev.

**Persona Relevance:** The Node.js CLI and Docker Compose deploy path are direct hits for a team running Node.js services with existing Docker workflows.

---

#### Entry 9 — Read the Docker Compose deployment guide
> **Sentiment:** Positive

The `cpln stack deploy` command converts docker-compose.yml services, volumes, and secrets into Control Plane equivalents. You can add an `x-cpln` block to customize workload specs (CPU, memory, autoscaling). Service-to-service communication uses `http://service-name.{GVC}.cpln.local:{port}`. This is a realistic migration path — I could take existing compose files and get them running without rewriting everything. The caveat that `x-cpln` blocks **replace** rather than merge spec sections is the kind of sharp edge that would bite someone, but at least it's documented.

---

#### Entry 10 — Read the GitOps / CI/CD integration guide
> **Sentiment:** Neutral · **Severity:** Minor

They support GitHub Actions, GitLab, Bitbucket, CircleCI, and Google Cloud Build. The approach uses the CLI (`cpln apply`) to push YAML/JSON resource definitions. There's a Terraform path too. But the actual GitHub Actions example isn't shown inline in the guide — it points to an external examples repo. I would have preferred seeing a complete workflow YAML right in the docs. Also, there's a noted gotcha: if you rename a resource, `cpln apply` creates a new one instead of updating, leaving orphans. That's the kind of thing that would cause confusion in CI pipelines.

**Persona Relevance:** GitHub Actions is our CI/CD — having an integration path matters. But the lack of an inline workflow example means I'd need to go hunt through a GitHub repo to see what a real pipeline looks like.

---

#### Entry 11 — Read the Terraform provider documentation
> **Sentiment:** Neutral · **Severity:** Minor

The Terraform provider is published on the Terraform Registry (`controlplane-com/cpln`). Setup looks standard — provider block, org config, and you can authenticate via env vars (CPLN_ORG, CPLN_TOKEN). Examples live in a GitHub repo. The docs are thin here — they tell me the provider exists and how to configure it, but don't walk through a realistic scenario like "deploy a Node.js API with a PostgreSQL connection." I'd have to piece it together from the examples repo and reference docs.

---

#### Entry 12 — Looked at the overall docs for database/stateful service guidance
> **Sentiment:** Frustration · **Severity:** Significant

I don't see a clear guide for "how do I connect my Control Plane workloads to AWS RDS" or "how do I run PostgreSQL." There are guides for native networking (AWS PrivateLink for RDS via Terraform, GCP Private Service Connect for Cloud SQL), and there's a "Cloud Wormhole" feature for connecting to private VPC resources. The information exists but it's scattered — I'd need to read the native networking guide, the Cloud Wormhole docs, and the identity/secrets guides to piece together a complete picture of connecting to my existing RDS instances.

**Persona Relevance:** My team's core question is "can this talk to our existing AWS RDS and Redis?" A clear "migrating from AWS" or "connecting to existing AWS services" guide would immediately answer the most important question for our evaluation.

---

#### Entry 13 — Reviewed the breadth of documentation coverage
> **Sentiment:** Positive

The docs are comprehensive in surface area — there are 200+ pages covering everything from API reference to managed Kubernetes to MCP server integration for AI coding tools. Reference docs exist for every resource type (workloads, GVCs, identities, policies, secrets, domains, volumes). There are detailed workload configuration docs covering autoscaling, capacity, containers, firewalls, JWT auth, load balancing, security, and volumes. This is a platform with real depth, not a thin wrapper.

---

### Stage: Pricing

#### Entry 14 — Read the pricing page at controlplane.com/pricing
> **Sentiment:** Positive

Pricing is purely usage-based — no tiers, no minimums, no contracts. CPU is $0.062/millicore-month, RAM is $0.007/MB-month. They claim "a typical workload costs under $5/month per location." This is refreshingly transparent compared to most platform vendors. I can actually estimate costs. If a typical Node.js service uses ~25 millicores and, say, 256MB RAM, that's roughly $1.55 + $1.81 = ~$3.36/month per location. That's cheap.

**Persona Relevance:** Usage-based with no minimums is ideal for a Series A company. I can start small and costs scale linearly. No surprise jumps when I cross a tier boundary.

---

#### Entry 15 — Calculated what my team's workloads might cost
> **Sentiment:** Positive

We run about 12 microservices. If each uses ~50 millicores and 512MB on average across 2 locations, that's roughly (50 * $0.062 + 512 * $0.007) * 2 * 12 = ($3.10 + $3.58) * 24 = ~$160/month in compute. Plus egress at $0.12/GB, logging (first 100GB free), and a dedicated load balancer at $60/month. Rough estimate: $250-400/month for our entire stack. That's dramatically less than what we're paying for EKS + ECS + associated AWS services. The Capacity AI claim of "10x reduction" in resource usage due to scale-to-zero would push this even lower.

**Persona Relevance:** At this price point, the ROI math is trivial for a Series A company. Even if the real number is 3x the estimate, it would still save money versus our current AWS bill plus the engineering time spent on ops.

---

#### Entry 16 — Checked for hidden costs and what's included for free
> **Sentiment:** Positive

NAT gateways, internet gateways, TLS certs, DNS, secrets management, container registry, audit trail, container orchestration, service mesh, VPN, and auto-scaling are all included at no extra cost. On AWS, NAT gateways alone cost us ~$100+/month. TLS cert management is a pain. The fact that these are bundled is a genuine differentiator and removes a whole class of hidden costs that plague AWS deployments.

---

#### Entry 17 — Looked for information about support costs
> **Sentiment:** Frustration · **Severity:** Minor

The pricing page doesn't mention support tiers or costs. The products page mentions "premier support" as a supplementary service, but there's no pricing for it. I don't know if basic support is included or if I'd need to pay extra for something beyond email. For a Series A team without a dedicated platform engineer, the quality and responsiveness of support is critical. This is a gap.

---

### Stage: Use Cases

#### Entry 18 — Read the customer case studies page
> **Sentiment:** Positive

There are 16 customer stories. The range is impressive — fintech (Linker Finance, Allio), healthcare (SafeHealth, Acoer, Nevvon), SaaS (Popmenu, Qualifi, LeasePilot), e-commerce (DIV Brands, Printivity), and tech (Outrider, Fastback). Several closely match my company profile: Qualifi ("too much team time on DevOps versus product development"), Linker Finance ("manual AWS console management, unpredictable deployment times"), LeasePilot ("no internal DevOps team"), and Allio ("optimize resources for serverless Node.js deployment"). These aren't Fortune 500 case studies — they're real startup/scaleup stories.

**Persona Relevance:** The presence of multiple Series A/B-sized companies with small engineering teams and no dedicated DevOps is exactly the social proof I need. This isn't a platform that only works at enterprise scale.

---

#### Entry 19 — Read the Qualifi case study in detail
> **Sentiment:** Positive

Qualifi is a cloud-based recruitment platform that cut server costs by 90% and "eliminated DevOps bottlenecks." They freed engineers for product development and got seamless multi-cloud deployment. This is almost a 1:1 match for what I'm trying to achieve. The fact that they're a small product company, not a Fortune 500, makes this more credible as a proof point for our size.

---

#### Entry 20 — Read the Allio case study — a Node.js fintech company
> **Sentiment:** Positive

Allio specifically calls out "serverless deployment of our Node.js apps" and uses Terraform integration. They achieved zero-downtime deployments and accelerated time-to-market by 6 months. They also got SOC 2 compliance support. This maps directly to our stack (Node.js, Terraform) and our compliance aspirations.

**Persona Relevance:** A Node.js fintech using Terraform on Control Plane with SOC 2 compliance — this is almost exactly what our stack evolution would look like.

---

#### Entry 21 — Reviewed the blog for relevant technical content
> **Sentiment:** Neutral · **Severity:** Minor

The blog is active with recent posts (multiple in January-February 2026). The content is thought-leadership oriented — articles about cloud cost optimization, infrastructure resilience, and why engineers quit due to DevOps burden. The "Why Your Best Engineers Are Quitting" post headline resonates directly with my concern about retention. However, the blog is heavy on strategy and light on technical how-to content. I didn't find migration guides, "how we built X" deep dives, or architecture walkthroughs. Most posts are by a single author (Barak Brudo) which feels more like a company blog than a community.

---

#### Entry 22 — Looked for specific migration guides or "moving from AWS ECS/EKS" content
> **Sentiment:** Frustration · **Severity:** Significant

I couldn't find a dedicated "migrating from AWS" or "migrating from Kubernetes" guide anywhere — not in the blog, not in the docs, not on the solutions pages. For a platform that's positioning itself as an alternative to raw K8s management, a migration guide is table stakes. I need to know: what does the transition look like? Can I migrate one service at a time? How do I handle the cutover for a production workload? This is a significant gap.

**Persona Relevance:** The entire evaluation question is "could this replace our current infrastructure?" Without a migration guide, I'm left guessing at how painful the transition would actually be.

---

#### Entry 23 — Tried to access solutions sub-pages (developer-self-service, cost, enhancement)
> **Sentiment:** Frustration · **Severity:** Minor

Multiple solutions sub-page URLs returned 404 errors — I tried /solution/developer-self-service, /solution/cost, /solutions/developer-self-service, /solutions/cost, and /solutions/enhancement. The nav menu lists these pages but at least some of the URL patterns I tried were broken. Either the URL scheme is different than expected, or these pages genuinely don't resolve. For a product that emphasizes developer experience, having broken navigation paths is a bad look.

---

### Stage: Security & Trust

#### Entry 24 — Read the security documentation at docs.controlplane.com/core/security
> **Sentiment:** Positive

The security model is solid. All external traffic is end-to-end TLS with Let's Encrypt certs rotating every 60 days. Internal service-to-service communication uses mTLS with hourly cert rotation. Workloads are isolated by default — no internal or external communication enabled out of the box, you have to explicitly open firewall rules. Container isolation uses gVisor for kernel syscall filtering plus cgroups and namespaces. Secrets are envelope-encrypted at rest with HSM-backed keys across multiple cloud providers. This is a more secure default posture than most teams achieve with raw Kubernetes.

**Persona Relevance:** As a team that doesn't have a dedicated security engineer, inheriting this level of security by default — mTLS, gVisor, HSM-backed secrets — is genuinely valuable. We'd never build this ourselves.

---

#### Entry 25 — Read the compliance documentation
> **Sentiment:** Positive

They have SOC 2 Type II and PCI DSS Level 1 certifications. The compliance page lists third-party penetration testing, background checks on personnel, OWASP Top 10-aligned development practices, and customer data isolation in dedicated trust zones. SOC 2 and PCI audit reports are available on request. This is credible compliance posture for a platform vendor.

---

#### Entry 26 — Checked for HIPAA, GDPR, and other compliance frameworks
> **Sentiment:** Neutral · **Severity:** Minor

HIPAA is not mentioned anywhere in the docs or compliance page. GDPR isn't explicitly called out either. For healthcare-adjacent SaaS companies or those with EU customers, this could be a blocker. For my specific context it's not an immediate issue, but it's worth noting as a gap.

---

#### Entry 27 — Checked for privacy policy and terms of service links
> **Sentiment:** Neutral

Both Privacy Policy and Terms of Use are linked in the footer and resolve to valid pages. They exist and are accessible. The presence of both is expected baseline trust signal.

---

#### Entry 28 — Checked the status page at status.cpln.io
> **Sentiment:** Positive

The status page is well-organized. It monitors 10+ service components (API, Console, DNS, Container Registry, Workloads, Cloud Identity, Grafana, Logs, etc.) across AWS, GCP, and Azure regions. Everything shows operational as of today. There's an RSS feed for incident updates. Having a public status page with per-component, per-region visibility is a strong trust signal. Many smaller platform vendors don't offer this level of transparency.

---

#### Entry 29 — Looked for information about data residency, backup, and disaster recovery
> **Sentiment:** Frustration · **Severity:** Minor

The homepage claims 99.999% uptime. The architecture is multi-region by design, which inherently provides DR capability. But I couldn't find an explicit DR/backup policy document, data residency commitments, or an SLA document with penalty terms. The "five nines" claim is bold — I'd want to see the actual SLA backing it before putting production workloads on this.

**Persona Relevance:** Before committing production infrastructure, engineering leadership needs to see a formal SLA, not just a marketing claim. "99.999%" on a homepage isn't the same as a contractual guarantee with credits.

---

#### Entry 30 — Checked the footer for compliance badges
> **Sentiment:** Positive

The footer displays PCI DSS Level 1 and SOC 2 Type II badges. These are visible on every page, which is good — it signals that compliance is part of the brand, not an afterthought. Compliance badges in the footer are a well-understood trust pattern for B2B SaaS evaluation.

---

#### Entry 31 — Assessed overall positioning and messaging coherence
> **Sentiment:** Neutral · **Severity:** Minor

There's a disconnect between what the homepage sells (multi-cloud freedom) and what the customer stories prove (operational simplification for small teams). The most compelling proof points — Qualifi eliminating DevOps overhead, LeasePilot modernizing without a DevOps team, SafeHealth avoiding 10-15 hires — are about escaping infrastructure complexity, not about multi-cloud. The product seems to genuinely solve both problems, but the marketing leads with the enterprise pitch while the actual customer base skews toward the "simplify my life" use case that would resonate with teams like mine.

**Persona Relevance:** If I'm a VP Engineering at a Series A company scanning the homepage for 30 seconds, the multi-cloud messaging might make me bounce — thinking "that's not my problem." The customer stories would keep me, but only if I scroll far enough to find them.

---

#### Entry 32 — Assessed documentation completeness for a new evaluation
> **Sentiment:** Neutral · **Severity:** Significant

The docs have strong breadth (200+ pages, covers CLI/API/Terraform/Pulumi/K8s operator) and good reference material. But there's a missing middle layer — the "how do I actually migrate my real-world Node.js + PostgreSQL + Redis stack from AWS ECS to Control Plane" guide. The quickstart deploys a hello-world Go app. The reference docs explain every knob. But the journey from "I have a production app on AWS" to "it's running on Control Plane" isn't documented as a coherent narrative. I'd be stitching together pieces from 5-6 different docs pages.

**Persona Relevance:** A senior engineer evaluating a platform switch needs to see the migration path, not just the destination. The gap between "hello world quickstart" and "production deployment reference" is where my evaluation stalls.

---

## Phase 2 — Signup & Onboarding

### Stage: Signup & Onboarding

#### Entry 33 — Navigated to the signup page at console.cpln.io/signup
> **Sentiment:** Neutral · **Severity:** Minor

The signup page is a JavaScript SPA — the raw page just shows "You need to enable JavaScript to run this app" with the tagline "From many clouds, one." There's no server-rendered fallback, no preview of what I'm signing up for, and no information about what the signup flow will ask me. From a web standards perspective this is fine for a console app, but it means search engines, link previews, and any non-JS context (like sharing the signup link in Slack) will show nothing useful. Minor, but it's a missed opportunity for the signup link to sell the product one last time before you commit.

---

#### Entry 34 — Identified available authentication methods for signup
> **Sentiment:** Positive

According to the docs, Control Plane supports four SSO providers for authentication: Google, GitHub, Microsoft, and SAML. There is no email/password option. SSO-only is actually a positive for my context — it eliminates password management overhead and means my team can use our existing Google Workspace or GitHub identities. For a platform that handles production infrastructure, forcing SSO is a reasonable security decision.

**Persona Relevance:** SSO via Google or GitHub means zero credential management overhead for my team. This is the right default for an infrastructure platform.

---

#### Entry 35 — Investigated what happens immediately after signup — the organization creation step
> **Sentiment:** Frustration · **Severity:** Significant

After authenticating, the first thing you need to do is create an Organization. The docs say org names are globally unique and immutable — "Orgs are immutable and cannot be renamed or deleted." That's a big decision to make as literally your first action on the platform, and there's no warning in the signup flow about its permanence (at least not documented). If I fat-finger my org name or use a placeholder, I'm stuck with it. This should be surfaced prominently with a confirmation step.

**Persona Relevance:** At a growing company, org naming matters for branding, compliance, and team identity. Making it permanent with no rename or delete option and no documented warning during creation is a real risk for someone trying the product quickly.

---

#### Entry 36 — Investigated the billing setup requirement
> **Sentiment:** Frustration · **Severity:** Significant

The docs mention you need to "establish a billing account" as a prerequisite for the quickstart, but the billing concepts page doesn't explain what happens before you enter payment details. Can I explore the console without a credit card? Can I create a GVC and look around before committing financially? The pricing page said "no minimums" and the homepage says "Sign Up for Free" but there's no explicit free tier or trial period documented. I genuinely don't know if I'll hit a paywall before I can deploy my first test workload.

**Persona Relevance:** A senior engineer doing a quick evaluation doesn't want to enter a credit card to kick the tires. If there's a free trial or sandbox, it's not documented. If there isn't one, the "Sign Up for Free" CTA on the homepage is misleading.

---

#### Entry 37 — Investigated the permission model for new organizations
> **Sentiment:** Frustration · **Severity:** Minor

To create an org, you apparently need the `org_creator` or `billing_admin` role "assigned by a billing administrator." But if I'm the first user signing up, who assigns me that role? The docs describe this as a prerequisite but don't explain the bootstrap case — the very first user in a brand-new account. Either the first user automatically gets these permissions (which would make sense but isn't stated), or there's a chicken-and-egg problem. This is the kind of documentation gap that would leave me stuck at minute two of my evaluation.

**Persona Relevance:** The docs seem written for someone joining an existing org, not for the person creating the account from scratch. A first-time evaluator needs the "day zero" path to be crystal clear.

---

#### Entry 38 — Reviewed the console UI workflow from quickstart documentation
> **Sentiment:** Neutral · **Severity:** Minor

The quickstart describes the console experience for creating a GVC and deploying a workload. The flow is: click "Create" dropdown → select "GVC" → enter name → select locations → save. Then: navigate to "Workloads" → click "New" → configure container image → set port → click "Make Public" in Firewall → create. This is a reasonable number of steps (maybe 8-10 clicks to first deploy), and the mental model is clear: GVC is your environment, Workload is your service. But there are no screenshots in the docs — it's all text descriptions of UI elements. I can't preview what the console looks like before signing up.

---

#### Entry 39 — Checked for product demo videos that show the console experience
> **Sentiment:** Frustration · **Severity:** Minor

There's a product demos page with 6 embedded YouTube videos, but none of them have titles or descriptions on the page itself. They're just bare video embeds. I can't tell which one would show me the console dashboard, which one covers the deployment workflow, and which one is a sales overview. If I'm evaluating this product and want to see the UI before signing up, I'd have to watch all six videos to find the relevant one. That's not respectful of my time.

---

#### Entry 40 — Investigated the "Talk to an Engineer" alternative path
> **Sentiment:** Frustration · **Severity:** Minor

The demo request form asks for Name, Company Name, Email, Company Website, and Phone — all required. Five required fields just to schedule a demo is a lot. Phone number in particular feels unnecessary and would make me hesitate. In 2026, requiring a phone number for a demo request signals "we're going to cold-call you." For a developer product, this creates friction and distrust. The "Talk to an Engineer" path should feel like engineering support, not enterprise sales.

**Persona Relevance:** As engineering leadership at a startup, I'm evaluating dozens of tools. Requiring my phone number just to see a demo immediately flags this as a high-touch sales process, which doesn't match the self-serve positioning of "Sign Up for Free."

---

#### Entry 41 — Assessed the overall signup-to-value path based on available information
> **Sentiment:** Neutral

Piecing together the signup journey from docs and page visits, the path looks like: (1) SSO authentication via Google/GitHub/Microsoft, (2) create an immutable org, (3) set up billing, (4) create a GVC with locations, (5) deploy a workload. That's at least 5 distinct steps before you see a running container. The quickstart says deployment takes "1-2 minutes" after creation, so the time-to-value could be under 10 minutes if you know what you're doing. But the billing uncertainty (step 3) is a potential wall. If I have to enter a credit card and commit to charges before deploying a hello-world, that's a significant barrier for evaluation.

**Persona Relevance:** Compared to Heroku or Railway where you can deploy in under 5 minutes with no payment, or even AWS where you get a 12-month free tier, the lack of a documented free trial makes the signup-to-value path feel riskier for someone just evaluating.

---

#### Entry 42 — Looked for any in-product onboarding documentation (wizards, tours, guided setup)
> **Sentiment:** Neutral · **Severity:** Minor

I found no documentation of an onboarding wizard, product tour, or guided setup flow. The quickstart guide serves as the onboarding, but it's external to the product (in the docs site, not in the console). There's no mention of tooltips, checklists, or interactive walkthroughs inside the console. This might exist and just not be documented, but from the outside, it looks like you authenticate and land in a blank dashboard with no hand-holding. For a platform with concepts like GVCs, Workloads, Identities, and Policies, some in-product guidance would significantly reduce the learning curve.

**Persona Relevance:** My engineers aren't going to read the docs first. They're going to sign in and click around. If the console doesn't guide them, the first experience will be confusing, which undermines the "developer self-service" value proposition.

---

#### Entry 43 — Evaluated the workload abstraction model for onboarding clarity
> **Sentiment:** Positive

The core concepts are actually well-designed for onboarding: Organization → GVC (environment/region set) → Workload (your container). Three levels of hierarchy. The workload types are intuitive: Serverless (scales to zero), Standard (always on), Cron (scheduled), and Stateful (persistent storage). Six autoscaling strategies are available including concurrent requests and request latency, which is more sophisticated than basic CPU-based scaling. The mental model is clean, and I think my team could understand it quickly. The terminology is the only barrier — "GVC" is not self-explanatory, and I'd need to explain it to my team as "it's like an environment that spans regions."

---

#### Entry 44 — Checked whether the CLI offers a faster onboarding path than the console
> **Sentiment:** Positive

The CLI quickstart is 6 commands: install, login, set profile org, create GVC, create workload, open workload. That's genuinely fast. And because the CLI is an npm package, my team can add it to their existing Node.js toolchain without any extra runtime dependencies. The `cpln workload create --name hello-world --image gcr.io/knative-samples/helloworld-go --port 8080 --public` one-liner is the kind of command you can paste in Slack and a teammate can run immediately. This is a better onboarding path than the console for engineering teams.

**Persona Relevance:** For a team of 20 engineers, the CLI path is how adoption actually spreads. One engineer runs it, shares the commands in Slack, and others follow. The console is for ops visibility; the CLI is for developer onboarding.

---

#### Entry 45 — Assessed signup flow step count and friction summary
> **Sentiment:** Neutral

Summarizing the signup-to-first-deploy journey based on everything I've gathered. Authentication options: 4 (Google, GitHub, Microsoft, SAML) — good variety, SSO-only is appropriate. Estimated steps to first deploy: 5 (authenticate → create org → billing → create GVC → create workload). Known friction points: (1) org name is permanent with no undo, (2) billing requirement is unclear — no documented free tier or trial, (3) no in-product onboarding guidance documented, (4) product demos have no labels. Positive signals: (1) SSO means no password to manage, (2) CLI path is very fast, (3) workload concepts are clean, (4) Docker Compose path exists for migration.

---

## Phase 3 — Core Workflow

### Stage: Core Workflow

#### Entry 46 — Installed the Control Plane CLI via npm
> **Sentiment:** Positive

`npm install -g @controlplane/cli` completed in 11 seconds, installed cleanly with no errors. Running `cpln --version` returns structured JSON with version info. The CLI is immediately functional — `cpln --help` lists all commands with clear groupings (workload, gvc, secret, image, stack, convert, etc.). The command surface is large (30+ top-level commands) but well-organized. Install experience is exactly what I'd expect as a Node.js developer. No extra runtime, no separate binary — just an npm package.

**Persona Relevance:** npm install is the most natural install path for a Node.js team. Zero friction.

---

#### Entry 47 — Ran the quickstart — created a GVC and deployed a hello-world workload
> **Sentiment:** Positive

The quickstart workflow delivered on its promise. `cpln gvc create --name eval-test-gvc --location aws-us-west-2` completed instantly. `cpln workload create --name hello-world --gvc eval-test-gvc --image gcr.io/knative-samples/helloworld-go --port 8080 --public` created the workload in under a second. The workload was ready and responding to HTTP requests within about 60 seconds. I curled the endpoint and got "Hello World!" back with a 242ms response time. From `gvc create` to live HTTP response: under 90 seconds. That's genuinely impressive.

---

#### Entry 48 — Deployed a serverless workload using cpln apply with a YAML definition
> **Sentiment:** Positive

I wrote a YAML workload definition with type=serverless, autoscaling by concurrency, Capacity AI enabled, and an environment variable. `cpln apply -f cpln-workload.yaml --gvc eval-test-gvc` worked first try — "Created /org/tessak22/gvc/eval-test-gvc/workload/eval-api". The workload was ready within about 60 seconds and responded with "Hello Control Plane Evaluation!" The YAML format is clean and readable. The apply workflow feels like a simplified version of `kubectl apply` but with better defaults (firewall locked down by default, TLS automatic).

---

#### Entry 49 — Tested the K8s-to-CPLN converter with a standard Kubernetes Deployment YAML
> **Sentiment:** Positive

`cpln convert -f k8s-deployment.yaml -o yaml` correctly translated a standard Kubernetes Deployment + Service into Control Plane workload format. It mapped resource requests/limits to min/max CPU and memory, converted ports, preserved env vars, set replicas, and even transferred labels as tags. The output was clean YAML I could immediately feed to `cpln apply`. The convert → apply pipeline worked end-to-end. For a team migrating from K8s, this is a very practical tool — you can take your existing K8s manifests and get a working starting point without rewriting from scratch.

**Persona Relevance:** This is exactly the migration path my team would need. Take existing K8s YAML, convert it, review the output, apply. Not zero effort, but dramatically less than rewriting.

---

#### Entry 50 — Attempted the Docker Compose deployment path using `cpln stack manifest`
> **Sentiment:** Frustration · **Severity:** BLOCKER

`cpln stack manifest` crashed with an unhandled JavaScript exception: "Cannot read properties of undefined (reading 'replace')". I tried multiple variations — different compose files, minimal compose files, explicit flags (--dir, --compose-file, --gvc), even a bare-bones compose.yaml with just an image and port. Same crash every time. This is a bug in CLI version 3.9.1. The error message gives no indication of what went wrong or how to fix it — it's a raw JS stack trace leaking through. The Docker Compose path, which the docs promote as a key onramp for migration, is completely non-functional in the current CLI release.

**Persona Relevance:** The Docker Compose path was one of the most compelling migration stories — "take your existing compose files and deploy." Having it broken in the current CLI release undermines that entire narrative. My team's services all have docker-compose files. This was supposed to be the easy path.

---

#### Entry 51 — Attempted to create a secret using the CLI
> **Sentiment:** Frustration · **Severity:** Minor

My first attempt (`cpln secret create --name test-db-url --type opaque --payload "..."`) failed because the CLI uses subcommands per secret type: `create-opaque`, `create-aws`, `create-gcp`, etc. The error message was "Did you mean update?" which is unhelpful — no, I meant create. After reading the help, I found `create-opaque` requires `--file` not `--payload`, so the secret value must come from a file or stdin. I used `echo "..." | cpln secret create-opaque --name test-db-url --encoding plain -f -` and it worked. The discoverability of the secret creation workflow is poor — 13 different `create-*` subcommands is a lot to navigate, and requiring file input for a simple string value adds unnecessary friction.

---

#### Entry 52 — Queried workload logs using the CLI
> **Sentiment:** Neutral · **Severity:** Minor

The logs command uses LogQL syntax, not workload names. My first attempt (`cpln logs "hello-world" --gvc eval-test-gvc`) failed because `--gvc` isn't a valid flag — the query itself is a LogQL expression. The correct syntax is `cpln logs '{workload="hello-world", gvc="eval-test-gvc"}'`. Once I got the syntax right, the logs were comprehensive — I could see both container stdout/stderr and access logs with full request details (method, status, latency, upstream IP). The log output is rich and useful. But LogQL is not intuitive for someone who just wants "show me the logs for this workload." A shortcut like `cpln workload logs <name>` would dramatically improve the developer experience.

**Persona Relevance:** My engineers will want to tail logs during debugging. Making them learn LogQL syntax before they can see a log line is unnecessary friction. Most other platforms offer `<tool> logs <service-name>` as the simple path.

---

#### Entry 53 — Wrote a realistic Terraform configuration for a Node.js API + worker deployment
> **Sentiment:** Neutral · **Severity:** Minor

I wrote a complete Terraform config defining a GVC, two secrets (database URL, Redis URL), an identity, and two workloads (serverless API, standard worker). The Terraform provider syntax felt natural — standard HCL blocks for resources, environment variables as maps, autoscaling as a nested block. I couldn't run `terraform init` because Terraform isn't installed in this environment, so I can't validate whether the config actually works. But based on the provider documentation and the registry listing, the resource structure looks right. The main gap: I had to guess at the exact attribute names (e.g., `min_scale` vs `minScale`, `capacity_ai` vs `capacityAI`) because the docs don't show a complete real-world Terraform example — only provider setup and a link to a GitHub examples repo.

**Persona Relevance:** As a team already using Terraform, being able to manage Control Plane resources in HCL alongside our AWS resources is a big plus. But guessing at attribute names from thin docs is frustrating when you're trying to move fast.

---

#### Entry 54 — Wrote a GitHub Actions deployment workflow
> **Sentiment:** Positive

I wrote a CI/CD workflow that installs the CLI, builds and pushes a Docker image to the Control Plane registry, and updates the workload. The workflow is about 30 lines. The key steps are: `cpln image docker-login` for registry auth, standard `docker build && docker push` to the cpln registry, and `cpln workload update` to set the new image. This feels straightforward and composable — it's just CLI commands in a shell, not a proprietary GitHub Action with magic abstractions. The only thing I'm unsure about is `cpln workload update --set spec.containers.0.image=...` — the docs don't show this exact pattern, so I'm guessing at the update syntax.

**Persona Relevance:** GitHub Actions is our CI/CD. A 30-line deployment workflow using CLI commands is exactly the right level of complexity. No vendor lock-in on the CI side — these same commands work in any CI system.

---

### Stage: Output & Results

#### Entry 55 — Tested error message quality across the CLI
> **Sentiment:** Frustration · **Severity:** Minor

Error messages are inconsistent. Some are clear and actionable: "Cannot guess the organization: either provide --org or set one in your profile" tells me exactly what to do. Others are terrible: "Cannot read properties of undefined (reading 'replace')" is a raw JavaScript exception that tells me nothing. "Did you mean update?" when I tried `secret create` is misleading — it suggests the wrong command. The `--gvc` flag error on the logs command just says "Unknown argument: gvc" without suggesting the correct approach (LogQL). Overall, the error handling feels like it was built for the happy path — when things work, they work well; when they don't, the errors range from helpful to completely opaque.

---

#### Entry 56 — Tested cleanup and resource deletion
> **Sentiment:** Neutral · **Severity:** Minor

`cpln gvc delete eval-test-gvc` deleted the GVC and all its workloads silently and quickly. `cpln secret delete test-db-url` likewise worked without ceremony. No confirmation prompt, no "are you sure?" — it just deletes. For a production platform, the lack of deletion confirmation is concerning. One typo in a script and you've deleted a GVC with all its workloads. There's a `resource-protection` feature in the docs that might guard against this, but it's not enabled by default. The happy path is dangerously smooth.

**Persona Relevance:** In a 20-person team, someone will eventually run `cpln gvc delete production` by accident. The absence of a default confirmation prompt or soft-delete is a real operational risk.

---

#### Entry 57 — Assessed overall time-to-working-deployment
> **Sentiment:** Positive

From `npm install -g @controlplane/cli` to a live, publicly-accessible hello-world endpoint responding to HTTP requests: under 2 minutes. Including the time to write a custom YAML workload definition and deploy a serverless workload with autoscaling: under 5 minutes total. Including cleanup: 6 minutes. This is faster than any Kubernetes-based deployment I've done. It's competitive with Heroku/Railway for speed but with production-grade features (autoscaling, mTLS, multi-region, firewall rules) that those platforms lack.

---

#### Entry 58 — Assessed production-readiness of what I built
> **Sentiment:** Positive

In the span of this evaluation, I deployed three workloads (standard, serverless, K8s-converted), created secrets, viewed structured logs, and verified endpoints — all via CLI. The deployed workloads had TLS by default, firewall rules, and autoscaling configured. The serverless workload would scale to zero when idle (saving cost) and scale up to 5 replicas under load. The security defaults (locked-down firewall, mTLS between services) are better than what most teams configure in raw K8s. If I could connect this to my existing RDS and Redis via PrivateLink or Cloud Wormhole, this would be production-viable infrastructure.

**Persona Relevance:** The gap between "evaluation deployment" and "production deployment" is mostly about data connections (RDS, Redis) and CI/CD integration, not about the platform itself. The platform gives you production-grade defaults out of the box.

---

#### Entry 59 — Assessed the overall developer experience across all workflows attempted
> **Sentiment:** Positive

The CLI is the star of this product. Install, create, deploy, view — it's fast and mostly intuitive. The `cpln apply` and `cpln convert` workflows provide clean migration paths from K8s. The YAML workload definitions are simpler than K8s manifests while being more capable (built-in autoscaling policies, Capacity AI, firewall config). The biggest gaps: (1) `cpln stack` (Docker Compose) is completely broken in the current release, (2) logs require LogQL instead of simple workload-name queries, (3) secrets creation has too many subcommands, and (4) error messages are inconsistent. But the core loop — define workload, apply it, it's live in 60 seconds with TLS and a public endpoint — is excellent.

---

## Evaluation Summary

| Metric | Value |
|--------|-------|
| **Core workflow completed** | Yes — deployed three workloads (standard, serverless, K8s-converted), created secrets, viewed logs, verified live endpoints, and cleaned up. Docker Compose path was blocked by a CLI bug. |
| **Total entries** | 59 |
| **Stages completed** | First Impressions, Documentation, Pricing, Use Cases, Security & Trust, Signup & Onboarding, Core Workflow, Output & Results |
| **Stages blocked** | None fully blocked — Docker Compose sub-path blocked within Core Workflow |

### Sentiment Distribution

| Sentiment | Count |
|-----------|-------|
| Positive | 22 |
| Neutral | 21 |
| Frustration | 16 |

### Issues by Severity

| Severity | Count | Entries |
|----------|-------|---------|
| **Blocker** | 1 | #50 — `cpln stack manifest` crashes with unhandled JS exception on all Docker Compose files |
| **Significant** | 5 | #12 — no AWS integration guide; #22 — no migration guide; #32 — docs gap between quickstart and production; #35 — immutable org names without warning; #36 — unclear billing/trial |
| **Minor** | 16 | #1, #2, #4, #5, #10, #11, #17, #21, #23, #26, #29, #33, #37, #38, #39, #40, #42, #51, #52, #53, #55, #56 |

### Overall Assessment

Control Plane is a genuinely capable platform that delivers on its core promise of simplifying container deployment. The CLI-to-live-endpoint experience is fast and production-grade. For a Series A team looking to replace ECS/EKS complexity without hiring a platform engineer, this is a credible option. The main barriers to adoption are (1) the broken Docker Compose path, (2) the lack of a clear migration guide from AWS, and (3) the ambiguity around billing/free trial availability.

### Agent Readiness Notes

The CLI is highly agent-navigable — structured output (JSON/YAML), consistent command patterns, and comprehensive help text make it usable by AI agents. The docs are broad but have gaps in the "middle layer" between quickstart and reference. Error messages are inconsistent, which would trip up an agent trying to self-correct. The LogQL requirement for logs is a discoverability barrier for both humans and agents.
