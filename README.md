# Automated Hybrid CI/CD Pipeline & Host-Level Infrastructure Observability

An enterprise-grade, two-stage decoupled deployment and monitoring system. This project demonstrates a **hybrid architectural pattern** that separates heavy software compilation workflows (CI) from target environment orchestration (CD). Static analysis and OCI-compliant container builds are handled in ephemeral cloud instances, while continuous deployment, container isolation, and host telemetry reporting execute natively inside private infrastructure via an authenticated background daemon.

---

## 🏗️ Architecture Overview

The pipeline operates like a sequential **relay race** using a multi-file workflow design to completely segregate continuous integration environments from production runtime credentials, avoiding circular dependencies or security risks.

### The Code Execution Flow:
* **Stage 1: Developer Push:** Modifying code triggers the central GitHub coordinator.
* **Stage 2: Cloud Execution (GitHub-Hosted CI):** GitHub spins up a clean, short-lived Ubuntu instance. It checks code syntax, compiles the app, builds the immutable Docker image, and safely uploads it to the GitHub Container Registry (GHCR).
* **Stage 3: The Automation Hand-off:** Once Stage 1 finishes successfully, GitHub pings your private server using an authenticated background system connection.
* **Stage 4: Private Infrastructure (Self-Hosted CD):** Your AWS EC2 background daemon fetches the task, clears out legacy containers, pulls down the new container image from GHCR, and spins it up on Port 8080.
* **Stage 5: Onboard Monitoring:** The host server immediately runs a local Bash observability script to check system performance and streams the results directly back to your GitHub Actions interface.

### Key Design Implementations:
* **Asynchronous Execution:** Code builds never execute on or directly access the target server, reducing exposure to credential theft.
* **Non-Privileged Routing:** The web application maps to port 8080 internally and externally. This eliminates the security hazard of running a public-facing web framework as the root user on standard Linux privilege channels (Port 80).
* **Telemetry Profiling:** Captures the initialization phase workload (showing resource stabilization from an initial container pull spike of 71.9% CPU down to an idle resting state of 10% CPU inside a 1-second interval).

---

## 🧰 Tech Stack & Tools Used

* **Infrastructure Platform:** Amazon Web Services (AWS EC2) running Ubuntu Server 24.04 LTS
* **Containerization Engine:** Docker Engine (v25+), OCI Specifications
* **Automation & Orchestration Core:** GitHub Actions Cloud Platform
* **Build Fleet:** GitHub-Hosted Cloud Runners (ubuntu-latest)
* **Deployment Worker:** Private GitHub Self-Hosted Runner (Configured as a Linux background systemd service)
* **Artifact Warehouse:** GitHub Container Registry (ghcr.io)
* **Languages & Environments:** Python 3.11 (Application Layer), Bash (Observability Layer), YAML (Orchestration Layer)

---

## 📋 Prerequisites

Ensure your environments fulfill the following baseline criteria before running the workflows:

### 1. AWS EC2 Security Policy Configuration
* **Inbound Rules:** Your EC2 Security Group must permit inbound TCP traffic on port 8080 from 0.0.0.0/0 (or your specific IP) to allow external browser validation.
* **Outbound Rules:** Ensure outbound access is fully open so the server can talk out to GitHub's registry servers.

### 2. Docker Target Environment Setup
Docker must be installed on your EC2 instance. The default ubuntu system user must be appended to the core docker Unix group to allow execution without requiring explicit sudo commands.

### 3. GitHub Packages Read/Write Permissions
Go to your repository Settings > Actions > General > Workflow permissions and select Read and write permissions to allow the pipeline to push built container images to the registry.

---

## 🚀 Step-by-Step Run & Deployment Instructions

### Step 1: Hook Up the Private Self-Hosted Instance Daemon
1. Navigate to your repository on the GitHub website.
2. Select Settings > Actions > Runners > New self-hosted runner.
3. Choose Linux as the runner platform.
4. Establish your terminal context via SSH inside your AWS EC2 instance.
5. Execute the exact download and configuration commands supplied by the GitHub browser wrapper page.
6. When running the configuration script, accept the default settings and tags.
7. Do not run the runner interactively. Instead, install it as a resilient system background service so it survives shell logouts.
8. Verify the background daemon status to ensure it is running successfully.

### Step 2: Push the Pipeline Configurations to GitHub
Commit and dispatch your changes to your repository.

### Step 3: Track the Automated Relay Race
1. Open the Actions tab inside your GitHub repository browser UI.
2. Observe the Continuous Integration cloud-hosted task test your application syntax and compile your Docker container image.
3. The absolute second it finishes successfully, watch the downstream Continuous Deployment workflow trigger automatically. This task runs entirely on your private EC2 machine via your background runner daemon.
4. Drill down into the deployment logs under the infrastructure health check step to observe your server's live resource parameters.

### Step 4: External Browser Verification
Open a web browser tab and view your application live via your server's IP over port 8080.

---

## 📁 Project Structure & File Content Reference

This deployment maps out into clean, decoupled environment blocks:

1. **Application Layer:** An optimized, unprivileged Python web server routing traffic securely inside the network parameters.
2. **OCI Package Configuration:** Docker architecture isolating the runtime code footprint.
3. **Local Observability Telemetry Engine:** Underlying logic monitoring core system layers post-deployment.
4. **Stage 1 Pipeline:** Cloud Build orchestration dealing entirely with code compilation and artifact warehouse registry delivery.
5. **Stage 2 Pipeline:** Private continuous deployment automation responding instantly to upstream status hand-offs.

---

## 🧠 Core Competencies Proven in this Project

* **Decoupled Workflow Orchestration:** Mastered complex event-driven continuous deployment pipelines spanning separate compute resources without direct system linkages.
* **Host Hardening & Least-Privilege Design:** Structured unprivileged container mapping routes to run internet-facing web apps securely without requiring dangerous host root level configurations.
* **Linux Infrastructure Automation:** Translated ephemeral manual shell loops into permanent background system daemons using native Linux service engine controls (systemd).
* **Systems Observability:** Querying and aggregating real-time core OS telemetry parameters directly during software configuration transformations.e
