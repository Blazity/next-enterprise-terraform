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

## Features

- Automated provisioning of AWS infrastructure
- Scalable & secure setup using:
  - VPC
  - Elastic Container Service (ECS)
  - Elastic Container Registry (ECR)
  - Application Load Balancer
  - S3 + CloudFront for static assets
  - AWS WAF (Web Application Firewall)
  - Redis Cluster for caching
- CI/CD (GitHub Actions) ready
  - Deploying the `next-enterprise` application
  - Deploying the Storybook
  - Destroying the stack

## Documentation

There is a separate documentation that explains functionality of the project and comprehensively describes the installation process along with visual assets.

We __strongly encourage you__ to [visit our docs page describing deployments (docs.blazity.com)](https://docs.blazity.com/deployments/enterprise-cli)  
and the [docs regarding the description of an AWS provider (docs.blazity.com)](https://docs.blazity.com/next-enterprise/deployments/amazon-web-services) to learn more.


### Installation

In order to make deployments possible without manual work and attention needed - we've created an Enterprise CLI

1. Open the terminal of your choice
2. Install the CLI
  ```sh
  curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/Blazity/enterprise-cli/main/install.sh | sh
  ```
3. Make sure you're in the [next-enterprise][next-enterprise] as current working directory
4. Execute `enterprise prepare aws` and follow the instructions in the terminal.
5. Open the freshly created GitHub repository -> Actions -> Deploy Stack

### Team & maintenance

**next-enterprise-terraform** is backed and maintained by [Blazity](https://blazity.com), providing up to date security features and integrated feature updates.

#### Active maintainers
- Tomasz Czechowski ([tomaszczechowski](https://github.com/tomaszczechowski)) (original creator of the project) - Solutions Architect & DevOps
- Igor Klepacki ([neg4n](https://github.com/neg4n)) - Open Source Software Developer

### Architecture

![Architecture](arch-diagram.webp)

## License

MIT

[next-enterprise]: https://github.com/Blazity/next-enterprise/
