# Enterprise Terraform Infrastructure for Next.js 

<a href="https://blazity.com/">
<picture>
  <source media="(prefers-color-scheme: dark)" srcset="/assets/blazity-logo-dark.svg">
  <source media="(prefers-color-scheme: light)" srcset="/assets/blazity-logo-light.svg">
  <img alt="Logo" align="right" height="80" src="/assets/blazity-logo-light.svg">
</picture>
</a>

This project provides a complete enterprise-grade Terraform setup for deploying a **Next.js** application to **AWS**. It integrates and configures a development cloud architecture with a fully automated deployment pipeline using Terraform and AWS services.

A part of the [next-enterprise][next-enterprise] tooling.

- [What is this?](#what-is-this)
- [Who is it for / Who is it NOT for?](#who-is-it-for)
- [What's the problem](#what-is-the-problem)
  - [Infrastructure Setup is repetitive and Error-Prone](#1-infrastructure-setup-is-repetitive-and-error-prone)
  - [Lack of Standardization across projects](#2-lack-of-standardization-across-projects)
  - [Production Readiness is an afterthought](#3-production-readiness-is-an-afterthought)
- [Architecture](#architecture)
- [Installation and setup](#installation-and-setup)
  - [Prerequisites](#prerequisites)
    - [AWS Account](#1-aws-account)
    - [GitHub Access](#2-github-access)
    - [GitHub CLI (gh)](#3-github-cli-gh)
    - [Go (Golang)](#4-go-golang)
  - [Install the Enterprise CLI](#install-the-enterprise-cli)
- [Setup and Deployment](#setup-and-deployment)
- [CLI](#cli)
  - [`enterprise completion` command](#enterprise-completion-command)
  - [`enterprise prepare` command](#enterprise-prepare-command)
  - [`enterprise help` command](#enterprise-help-command)
- [Troubleshooting](#troubleshooting)
- [Active maintainers](#active-maintainers)
- [License](#license)
- [Made with ❤️ at Blazity](#made-with-️-at-blazity)

## What is this?

This project is a CLI tool that bootstraps a production-ready Next.js application on AWS.

With a single command, it:
- Creates a new GitHub repository
- Configures GitHub Actions CI/CD
- Provisions AWS infrastructure using Infrastructure as Code
- Deploys a ready-to-use Next.js boilerplate application

The goal is to eliminate repetitive DevOps setup and provide a secure, scalable, and enterprise-ready starting point for modern web applications.

The result is a fully deployed Next.js application running in AWS with CI/CD enabled - in minutes so you can focus on building features instead of configuring DevOps.

It is not a quick-start template - it is an opinionated infrastructure baseline for serious production workloads.

## Who is it for?

**This project is for:**

- Full-stack developers working with Next.js
- Developers who want to deploy Next.js applications to AWS without manually configuring infrastructure
- Teams that want production-ready CI/CD from day one
- Startups that need to move fast without building DevOps foundations from scratch
- Organizations looking for a standardized, repeatable cloud architecture

**This tool is designed for teams that:**

- Want a secure and scalable AWS foundation for Next.js
- Prefer automation over manual cloud configuration
- Need standardized environments across projects
- Care about CI/CD, reproducibility, and infrastructure consistency
- Whose time to market matters

**Who is it NOT for?**

- Developers looking for a simple static hosting solution
- Projects that do not require AWS infrastructure
- Teams that prefer fully managed platforms like Vercel

## What’s the problem?

Deploying a production-ready Next.js application in AWS is not difficult — but doing it properly, consistently, and at scale is.

Most teams underestimate the complexity of aligning infrastructure, CI/CD, security, and application setup from day one.

### 1. Infrastructure Setup Is Repetitive and Error-Prone

**Each new project requires:**
- Creating repositories
- Configuring CI/CD
- Writing Terraform modules
- Setting up IAM, networking, environments etc

**Without automation, this leads to:**
- Inconsistent architectures
- Manual misconfigurations
- Security gaps
- Time wasted on boilerplate instead of product development

### 2. Lack of Standardization Across Projects

As organizations grow, every team builds infrastructure slightly differently.

**The result:**
- Snowflake environments
- Harder onboarding
- Complicated audits
- Increased operational risk
- Slower cross-team collaboration

There is no enforced baseline.

### 3. Production Readiness Is an Afterthought

Many projects start simple and “fix infrastructure later.”

**But retrofitting:**
- Proper CI/CD
- Environment isolation
- IAM boundaries
- Scalable architecture

is significantly more expensive than starting correctly.
Technical debt accumulates at the infrastructure level — where it is most costly.

## Architecture

![Architecture](arch-diagram.webp)

**AWS Cloud most important resources usage:**

- Scalable & secure setup using:
  - VPC
  - Elastic Container Service (ECS)
  - Elastic Container Registry (ECR)
  - Application Load Balancer
  - S3 + CloudFront for static assets
  - AWS WAF (Web Application Firewall)
  - Redis Cluster for caching
  - other

## Installation

To enable fully automated, production-grade deployments without manual infrastructure work, this project provides an Enterprise CLI.

The CLI handles repository setup, CI/CD configuration, and AWS infrastructure orchestration.

### Prerequisites

Before installing the Enterprise CLI, ensure you have the following:

#### 1. AWS Account

- An active AWS account
- An IAM user with programmatic access
- AWS CLI configured locally (`aws configure`)
- Sufficient permissions to provision infrastructure (IAM, networking, compute, etc.)

You can verify configuration with:

```bash
aws sts get-caller-identity
```

#### 2. GitHub Access

- Access to a GitHub account or organization
- Permission to create repositories
- Permission to manage GitHub Actions workflows

#### 3. GitHub CLI (gh)

The Enterprise CLI depends on GitHub CLI.

**Install (macOS):**

```bash
brew install gh
```

**Other platforms:**

Use official Github CLI documentation https://cli.github.com/

--- 

**Verify installation:**

```bash
gh --version
```

**Authenticate:**

```bash
gh auth login
```

#### 4. Go (Golang)

The CLI requires Go to be installed locally.

Install Go: https://go.dev/dl/

Verify installation:

```bash
go version
```

If you see:

```bash
✗ Error: go is not installed.
```

Install Go and ensure it is available in your system PATH.

### Install the Enterprise CLI

Open your terminal and run:

```bash
curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/sdasd/install.sh | sh
```

After installation, verify that the Enterprise CLI is available:

```bash
enterprise --help

Enterprise CLI for infrastructure management

Available Commands:
  completion  Generate the autocompletion script for the specified shell
  help        Help about any command
  prepare     Prepare infrastructure for enterprise deployment

Use "enterprise [command] --help" for more information about a command.
```

## Setup and Deployment

After installing and verifying the Enterprise CLI, follow the steps below to provision and deploy your infrastructure.

### 1. Prepare AWS Infrastructure

Run the following command inside your project directory:

```bash
enterprise prepare aws
```

Note: __CLI supports AWS Cloud provider only. We plan to support Azure, and GCP in near future__

Follow the interactive instructions displayed in the terminal.

**This step will:**

-   Configure AWS integration
-   Generate and prepare Terraform configuration
-   Configure CI/CD integration
-   Bootstrap the required infrastructure components

------------------------------------------------------------------------

### 2. Deploy the Stack

**Once the preparation step completes:**

1.  Open the newly created GitHub repository.
2.  Navigate to **Actions**.
3.  Locate and run (or monitor) the **Deploy Stack** workflow.

**The GitHub Actions pipeline will:**

-   Provision AWS infrastructure using Terraform
-   Configure required cloud resources
-   Deploy the Next.js application

Deployment is fully automated and requires no manual infrastructure changes.


## CLI

### CLI Command: `enterprise completion`

Generates a shell autocompletion script for the specified shell.

Autocompletion enables tab-completion for commands, subcommands, and flags, improving usability and developer productivity.

---

#### Usage

``` bash
enterprise completion [shell]
```

------------------------------------------------------------------------

### Available Subcommands

#### bash or zsh

Generate the autocompletion script for e.g. **bash**:

``` bash
enterprise completion bash
```

To enable it temporarily:

``` bash
source <(enterprise completion bash)
```
------------------------------------------------------------------------

#### fish

Generate the autocompletion script for **fish**:

``` bash
enterprise completion fish
```

------------------------------------------------------------------------

#### powershell

Generate the autocompletion script for **PowerShell**:

``` powershell
enterprise completion powershell
```

------------------------------------------------------------------------

### Why Use Autocompletion?

-   Faster command execution
-   Fewer typos
-   Discoverable subcommands
-   Improved developer experience

For more details on a specific shell integration, run:

``` bash
enterprise completion [shell] --help
```

### CLI Command: `enterprise help`

Displays help information about the Enterprise CLI or a specific command.

This command provides usage instructions, available subcommands, flags, and additional details required to operate the CLI effectively.

---

#### Usage

``` bash
enterprise help
```

or

``` bash
enterprise [command] --help
```

Displays general help information, including available commands.


### CLI Command: `enterprise prepare`

Prepares infrastructure configuration for enterprise deployment.

This command initializes cloud provider configuration, generates the
required Infrastructure as Code (Terraform) setup, and prepares CI/CD
integration for automated deployment.

---

#### Usage

``` bash
enterprise prepare [provider]
```

---

### Available Providers

Currently supported:

#### AWS

``` bash
enterprise prepare aws
```

This command will:

-   Initialize AWS configuration
-   Generate Terraform infrastructure templates
-   Configure Github creadentials
-   Prepare GitHub Actions integration
-   Bootstrap deployment configuration

The process is interactive and will guide you through required inputs
such as AWS region, project naming, etc.

------------------------------------------------------------------------

### Important Notes

-   **Only the AWS provider is supported at this time.**
-   Ensure all prerequisites are met before running the command.
-   Avoid manual changes to generated Terraform files unless you understand the architecture implications.

For detailed options:

``` bash
enterprise prepare aws --help
```


## Troubleshooting

If you encounter issues during installation or deployment, use the
guidance below.

---

#### 1. `gh` is not installed

Error:

    ✗ Error: gh is not installed.

Solution:

Install GitHub CLI: Verify instalation with the steps in section [GitHub CLI (gh)](#3-github-cli-gh)

---

#### 2. `go` is not installed

Error:

    ✗ Error: go is not installed.

Solution: Verify instalation with the steps in section [Go (Golang)](#4-go-golang)

---

#### 3. AWS Authentication Issues

If you see permission or authentication errors during `enterprise prepare aws`:

**Verify AWS CLI configuration:**

``` bash
aws sts get-caller-identity
```

**If it fails, reconfigure:**

``` bash
aws configure
```

Ensure your IAM user has sufficient permissions to provision infrastructure.

---

#### 4. Enterprise Command Not Found

If running:

``` bash
enterprise --help
```

Returns "command not found":

-   Ensure installation completed successfully
-   Confirm the binary is in your system `PATH`
-   Restart your terminal session

------------------------------------------------------------------------

#### 5. GitHub Actions Deployment Fails

If the **Deploy Stack** workflow fails:

1.  Open the GitHub repository
2.  Navigate to **Actions**
3.  Review logs for the failing step

**Common causes:**

-   Missing repository permissions
-   Incorrect AWS credentials
-   Terraform permission errors
-   Missing required secrets

---

If issues persist, verify all prerequisites are correctly installed and configured before re-running the deployment.

## Active maintainers

- Tomasz Czechowski ([tomaszczechowski](https://github.com/tomaszczechowski)) (original creator of the project) - Solutions Architect & DevOps
- Igor Klepacki ([neg4n](https://github.com/neg4n)) - Open Source Software Developer

## License

[MIT](./LICENSE)

## Made with ❤️ at Blazity

**next-enterprise-terraform** is backed and maintained by [Blazity](https://blazity.com), providing up to date security features and integrated feature updates.

[next-enterprise]: https://github.com/Blazity/next-enterprise/