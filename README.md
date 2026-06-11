# Hybrid CI/CD Orchestration with GitHub Actions & Cloud Observability

An enterprise grade, two-stage decoupled deployment and monitoring system. This project demonstrates a **hybrid architectural pattern** that separates heavy software compilation workflows (CI) from target environment orchestration (CD). Static analysis and OCI-compliant container builds are handled in ephemeral cloud instances, while continuous deployment, container isolation, and host telemetry reporting execute natively inside private infrastructure via an authenticated background daemon.

---

## 🏗️ Architecture Overview

The pipeline operates like a **relay race** using a multi file workflow design to completely segregate continuous integration environments from production runtime credentials, avoiding circular dependencies or security risks:

```text
[ Developer Push ]
       │
       ▼
 ┌───────── File #1: Cloud Execution (GitHub-Hosted) ──────────────────────┐
 │ • Triggers instantly on git push                                         │
 │ • Boots clean Ubuntu virtualization stack                                │
 │ • Runs static syntax auditing & linting                                 │
 │ • Compiles codebase & builds OCI-compliant Docker Image Layer            │
 │ • Pushes immutable image to GitHub Container Registry (GHCR)             │
 └─────────────────────────┬────────────────────────────────────────────────┘
                           │
                 (Success Signal Sent)
                           │
                           ▼
 ┌───────── File #2: Private Infrastructure (Self-Hosted AWS EC2) ──────────┐
 │ • Listens for successful completion of File #1                           │
 │ • Communicates securely via an authenticated background systemd service  │
 │ • Logs into secure container registry (GHCR)                             │
 │ • Purges older runtime tasks & cleans host space                         │
 │ • Pulls new image layers & instantiates container on Port 8080           │
 │ • Executes local bash monitoring script directly on the host machine     │
 │ • Feeds real time host CPU, RAM, & Disk telemetry back to GitHub UI      │
 └──────────────────────────────────────────────────────────────────────────┘
