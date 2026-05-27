# SOC Platform Integrated

A professional Security Operations Center (SOC) platform integrating **Security Onion**, **Wazuh**, and **ISO/IEC 27001** compliance standards.

## Overview

This project provides an integrated SOC platform that combines multiple security tools and frameworks to deliver comprehensive security monitoring, threat detection, and compliance management.

### Key Features

- **Security Onion Integration**: Network-based intrusion detection and log management
- **Wazuh Integration**: Endpoint protection, log analysis, and threat intelligence
- **ISO/IEC 27001 Compliance**: Built-in compliance framework and audit capabilities
- **Centralized Dashboard**: Unified monitoring and alerting interface
- **Automated Response**: Incident response and threat mitigation automation

## Architecture

```
┌─────────────────────────────────────────────────┐
│         SOC Platform Integrated                 │
├─────────────────────────────────────────────────┤
│                                                 │
│  ┌──────────────┐  ┌──────────────┐            │
│  │ Security     │  │   Wazuh      │            │
│  │   Onion      │  │   Agent      │            │
│  └──────┬───────┘  └──────┬───────┘            │
│         │                 │                     │
│         └────────┬────────┘                     │
│                  │                              │
│         ┌────────▼────────┐                    │
│         │   Aggregation   │                    │
│         │    & Analytics  │                    │
│         └────────┬────────┘                    │
│                  │                              │
│    ┌─────────────┼─────────────┐               │
│    │             │             │               │
│  ┌─▼──┐    ┌─────▼────┐   ┌──▼───┐            │
│  │ UI │    │Compliance│   │ API  │            │
│  └────┘    │ Engine   │   └──────┘            │
│            └──────────┘                        │
│                                                 │
└─────────────────────────────────────────────────┘
```

## Quick Start

### Prerequisites

- Docker & Docker Compose (recommended)
- Linux-based system (Ubuntu 20.04 LTS or later)
- Minimum 8GB RAM, 4 CPU cores
- 50GB available disk space

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/MSDLA/soc-platform-integrated.git
   cd soc-platform-integrated
   ```

2. **Configure environment**
   ```bash
   cp .env.example .env
   # Edit .env with your settings
   nano .env
   ```

3. **Deploy with Docker Compose**
   ```bash
   docker-compose up -d
   ```

4. **Verify deployment**
   ```bash
   docker-compose ps
   ```

### Default Access Points

- **Dashboard**: http://localhost:5601
- **Wazuh Manager**: https://localhost:443
- **Security Onion**: http://localhost:8080
- **API**: http://localhost:8000

**Default Credentials**: See `CREDENTIALS.md` (change immediately in production)

## Components

### Security Onion
- Network Intrusion Detection System (NIDS)
- Log management and analysis
- Configuration: `config/security-onion/`

### Wazuh
- Endpoint Detection and Response (EDR)
- SIEM capabilities
- Configuration: `config/wazuh/`

### Compliance Engine
- ISO/IEC 27001 framework
- Audit logging and reporting
- Configuration: `config/compliance/`

## Configuration

Detailed configuration guides for each component:

- [Security Onion Setup](./docs/setup/security-onion.md)
- [Wazuh Configuration](./docs/setup/wazuh.md)
- [Compliance Framework](./docs/compliance/iso27001-implementation.md)
- [Network Configuration](./docs/network/networking.md)

## Usage

### Basic Operations

```bash
# Start all services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down

# Restart a specific service
docker-compose restart wazuh
```

### Adding Endpoints

```bash
# Deploy Wazuh agent to endpoint
./scripts/deploy-agent.sh <endpoint-ip> <agent-config>
```

### Running Reports

```bash
# Generate compliance report
./scripts/generate-compliance-report.sh --format pdf --period monthly

# Generate security incident report
./scripts/generate-incident-report.sh --date <YYYY-MM-DD>
```

## Documentation

- [Installation Guide](./docs/installation.md)
- [User Guide](./docs/user-guide.md)
- [API Documentation](./docs/api.md)
- [Troubleshooting](./docs/troubleshooting.md)
- [Security Best Practices](./docs/security-best-practices.md)

## Compliance

This project implements ISO/IEC 27001 controls including:

- Access control and authentication
- Encryption (in transit and at rest)
- Audit logging and monitoring
- Incident response procedures
- Regular security assessments

See [ISO/IEC 27001 Mapping](./docs/compliance/iso27001-mapping.md) for detailed control mapping.

## Deployment

### Production Deployment

For production environments, see:
- [Production Deployment Guide](./docs/deployment/production.md)
- [Kubernetes Deployment](./docs/deployment/kubernetes.md)
- [High Availability Setup](./docs/deployment/high-availability.md)

### Development Environment

```bash
# Start dev environment with debug logging
docker-compose -f docker-compose.dev.yml up -d
```

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](./CONTRIBUTING.md) for guidelines.

## Support

- **Documentation**: See `/docs` directory
- **Issues**: [GitHub Issues](https://github.com/MSDLA/soc-platform-integrated/issues)
- **Discussions**: [GitHub Discussions](https://github.com/MSDLA/soc-platform-integrated/discussions)

## License

This project is licensed under the MIT License - see [LICENSE](./LICENSE) file for details.

## Roadmap

- [ ] Multi-tenant support
- [ ] Advanced ML-based anomaly detection
- [ ] SOAR integration
- [ ] Additional compliance frameworks (HIPAA, PCI-DSS)
- [ ] Mobile app for incident management
- [ ] Extended threat intelligence feeds

## Security Notice

⚠️ **This is a security platform in active development.** Please report security vulnerabilities responsibly:

- **DO NOT** open public GitHub issues for security vulnerabilities
- Email security concerns to: `security@example.com` (configure your contact)

---

**Last Updated**: May 27, 2026  
**Status**: Alpha/Early Development