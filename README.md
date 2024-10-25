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

## Prerequisites

- Google Cloud SDK installed and configured
- Terraform >= 1.0
- kubectl installed
- Helm v3.x
- Domain name for the application

## Quick Start

1. Clone the repository:
```bash
git clone https://github.com/your-org/voice-app-gcp-infrastructure
cd voice-app-gcp-infrastructure
```

2. Initialize Terraform:
```bash
terraform init
```

3. Configure your `terraform.tfvars`:
```hcl
project_id         = "your-project-id"
region            = "us-central1"
environment       = "production"
domain_name       = "voicesapp.net"
cluster_name      = "voice-app-cluster"
node_machine_type = "e2-medium"
```

4. Deploy the infrastructure:
```bash
terraform apply
```

5. Configure kubectl:
```bash
gcloud container clusters get-credentials voice-app-cluster --region us-central1
```

## Module Structure

```
.
├── modules/
│   ├── gke/                 # GKE cluster configuration
│   ├── vpc/                 # VPC and networking
│   ├── storage/            # Persistent Disk configuration
│   ├── k8s_resources/      # Kubernetes resources
│   ├── voice_app/          # Voice application deployment
│   └── dns/                # Cloud DNS configuration
├── main.tf                 # Main configuration file
├── variables.tf            # Variable definitions
├── outputs.tf             # Output definitions
└── README.md              # This file
```

## Configuration

### Required Variables

| Name | Description | Type | Default |
|------|-------------|------|---------|
| project_id | GCP Project ID | string | - |
| region | GCP region | string | us-central1 |
| domain_name | Domain name | string | - |
| environment | Environment name | string | production |

### Optional Variables

| Name | Description | Type | Default |
|------|-------------|------|---------|
| node_machine_type | GKE node machine type | string | e2-medium |
| node_count | Number of GKE nodes | number | 2 |
| disk_size_gb | Size of boot disk | number | 100 |

## Security Features

- Private GKE cluster deployment
- Workload Identity for pod authentication
- Cloud IAM integration
- SSL/TLS termination at load balancer
- Network policies enabled
- Binary Authorization (optional)

## Monitoring and Maintenance

1. Access GKE Dashboard:
```bash
kubectl proxy
```

2. View Cloud Monitoring:
```bash
gcloud monitoring dashboards list
```

3. Check application logs:
```bash
kubectl logs -n default deployment/voice-app
```

## Cost Optimization

- Use Preemptible VMs for non-critical workloads
- Implement GKE cluster autoscaling
- Monitor Persistent Disk usage
- Use appropriate machine types
- Enable sustained use discounts

## Troubleshooting

Common issues and solutions:

1. **Cluster Creation Issues**
   - Check IAM permissions
   - Verify network configuration
   - Ensure quota availability

2. **Storage Problems**
   - Check Persistent Disk mounting
   - Verify storage class configuration

3. **Load Balancer Issues**
   - Check firewall rules
   - Verify health checks
   - Review SSL certificate configuration

## Support and Contributing

### Support the Project
If you find this project helpful, consider supporting its development:

[![Support via PayPal](https://img.shields.io/badge/Support%20via-PayPal-blue.svg)](https://paypal.me/abhikghosh87)

Every contribution helps maintain and improve the service! Your support enables:
- 🚀 Regular updates and improvements
- 📚 Better documentation
- 🛠️ New features development
- 🐛 Faster bug fixes
- 💬 Responsive support

### Connect & Contribute

- 🌟 Star this repository if you find it helpful
- 🔗 Follow on [LinkedIn](https://www.linkedin.com/in/abhik-ghosh-msc/) for updates
- 💬 Join our [My website](https://abhikghosh87.wixsite.com/website)
- 📝 Check out my [Blog Posts](https://medium.com/@abhikghosh_46536)

### Support the Project

If you find this project helpful, consider supporting its development:

- 💖 PayPal: [paypal.me/abhikghosh87](https://paypal.me/abhikghosh87)
- ⭐ Star this repository
- 📣 Share with others

### Technical Support
For technical questions and issues:
- Open an issue in the repository
- Contact the cloud infrastructure team

## License

MIT License - see the [LICENSE](LICENSE) file for details

---
Made with ❤️ by the community. Special thanks to all our supporters!

