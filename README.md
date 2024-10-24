# GCP Voice Application Infrastructure

This repository contains Terraform configurations for deploying a scalable voice application infrastructure on Google Cloud Platform (GCP). The infrastructure includes GKE (Google Kubernetes Engine) cluster, VPC networking, Persistent Disk storage, and all necessary components for running a containerized voice processing application.

[![Support the Project](https://img.shields.io/badge/Support%20via-PayPal-blue.svg)](https://paypal.me/abhikghosh87)

## Documentation & Demo

### Architecture Diagrams
- [Infrastructure Architecture Overview](videos/architecture.png)
- [Application Architecture Overview](videos/app.png)

### Demo
[![Watch the Demo](videos/demo-thumbnail.png)](videos/Linkedin.mp4)

## Architecture Overview

The infrastructure consists of:

- **GKE Cluster:**
  - 2 nodes (e2-medium instances)
  - Regional deployment for high availability
  - Auto-scaling capabilities
- **Storage:**
  - Persistent Disk SSD for:
    - Uploads (5GB)
    - Output (5GB)
    - Redis Data (5GB)
- **Networking:**
  - VPC Network
  - GCP Load Balancer
  - Cloud DNS integration
  - Ingress Controller
- **Application Components:**
  - Web Service (Node.js)
  - Worker Service (Node.js)
  - Redis Cluster (1 master, 2 replicas)

[Rest of the README remains the same...]

## Connect & Contribute

- 🌟 Star this repository if you find it helpful
- 🔗 Follow on [LinkedIn](https://www.linkedin.com/in/abhik-ghosh-msc/) for updates
- 💬 Join our [My website](https://abhikghosh87.wixsite.com/website)
- 📝 Check out my [Blog Posts](https://medium.com/@abhikghosh_46536)

## Support the Project

If you find this project helpful, consider supporting its development:

- 💖 PayPal: [paypal.me/abhikghosh87](https://paypal.me/abhikghosh87)
- ⭐ Star this repository
- 📣 Share with others

---
Made with ❤️ by the community. Special thanks to all our supporters!