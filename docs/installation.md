# Installation Guide

This guide covers the installation and setup of the SOC Platform Integrated.

## Prerequisites

### System Requirements

- **OS**: Ubuntu 20.04 LTS or later (tested), CentOS 8+, or similar Linux distribution
- **CPU**: Minimum 4 cores (8+ recommended for production)
- **RAM**: Minimum 8GB (16GB+ recommended for production)
- **Disk**: Minimum 50GB (200GB+ recommended for production)
- **Network**: Stable internet connection for package downloads

### Software Requirements

- Docker 20.10+
- Docker Compose 1.29+
- Git
- curl
- Python 3.9+ (for API development)

### Verify Installation

```bash
docker --version
docker-compose --version
git --version
```

## Installation Steps

### 1. Clone the Repository

```bash
git clone https://github.com/MSDLA/soc-platform-integrated.git
cd soc-platform-integrated
```

### 2. Configure Environment

```bash
# Copy the example environment file
cp .env.example .env

# Edit with your settings
nano .env
```

**Important environment variables to configure:**

```env
# Security
SECURITY_ONION_ADMIN_PASSWORD=YourSecurePassword123!
WAZUH_MANAGER_ADMIN_PASSWORD=YourSecurePassword123!
ELASTIC_PASSWORD=YourSecurePassword123!
DATABASE_PASSWORD=YourSecurePassword123!

# Network (adjust for your environment)
NETWORK_INTERFACE=eth0
ALLOWED_CIDR=192.168.0.0/16

# Email (optional but recommended)
SMTP_SERVER=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your-email@gmail.com
SMTP_PASSWORD=your-app-password
```

### 3. Build Docker Images

```bash
make build
# or
docker-compose build
```

### 4. Start Services

```bash
make up
# or
docker-compose up -d
```

Verify all services are running:

```bash
docker-compose ps
```

Expected output:
```
CONTAINER ID   IMAGE                    STATUS            PORTS
...
postgres       postgres:15-alpine       Up (healthy)      5432
elasticsearch  docker.elastic.co/...    Up (healthy)      9200, 9300
kibana         docker.elastic.co/...    Up (healthy)      0.0.0.0:5601->5601/tcp
wazuh-manager  wazuh/wazuh:4.7.0        Up (healthy)      0.0.0.0:1514->1514/tcp, 0.0.0.0:55000->55000/tcp
wazuh-dashboard wazuh/wazuh-dashboard   Up                0.0.0.0:443->443/tcp
api            soc-platform/api         Up                0.0.0.0:8000->8000/tcp
compliance     soc-platform/compliance  Up                
redis          redis:7-alpine           Up (healthy)      0.0.0.0:6379->6379/tcp
```

### 5. Access Services

Once all services are running:

- **Kibana Dashboard**: https://localhost:5601
  - Username: `elastic`
  - Password: (from `ELASTIC_PASSWORD` in .env)

- **Wazuh Manager**: https://localhost:443
  - Username: (from `WAZUH_MANAGER_ADMIN_USER`)
  - Password: (from `WAZUH_MANAGER_ADMIN_PASSWORD`)

- **API**: http://localhost:8000
  - API docs: http://localhost:8000/docs

- **Redis**: localhost:6379

## Initial Configuration

### 1. Security Onion Setup

Access Security Onion through Kibana and configure:

```bash
# SSH into Security Onion container
docker-compose exec security-onion bash

# Complete Security Onion initialization
so-setup
```

### 2. Wazuh Agent Deployment

To add endpoints to Wazuh:

```bash
# Get agent installation instructions
docker-compose exec wazuh-manager bash

# Inside the container, generate agent key
/var/ossec/bin/manage_agents -a -n endpoint-name -i ip-address

# Deploy agent script
./scripts/deploy-agent.sh <endpoint-ip> <agent-config>
```

### 3. Compliance Framework Initialization

```bash
# Initialize ISO 27001 framework
docker-compose exec compliance python manage.py init-compliance --framework ISO27001
```

### 4. Create Admin User

```bash
# Create API admin user
docker-compose exec api python manage.py create-user \
  --username admin \
  --email admin@example.com \
  --role admin
```

## Verification

Run verification checks:

```bash
# Check service health
docker-compose ps

# Check logs for errors
docker-compose logs --tail=50

# Test API connectivity
curl -X GET http://localhost:8000/health

# Test Elasticsearch
curl -u elastic:${ELASTIC_PASSWORD} https://localhost:9200

# Test Wazuh API
curl -u admin:${WAZUH_MANAGER_ADMIN_PASSWORD} https://localhost:55000/ping
```

## Troubleshooting

### Port Conflicts

If ports are already in use:

```bash
# Find process using port
lsof -i :5601

# Or change ports in .env
KIBANA_PORT=5602
```

### Insufficient Resources

If services crash due to memory:

```bash
# Check resource usage
docker stats

# Increase Docker memory limit
# Edit docker daemon.json or docker-compose resource limits
```

### Container Startup Failures

```bash
# View detailed logs
docker-compose logs <service-name>

# Rebuild specific service
docker-compose build --no-cache <service-name>

# Remove and recreate
docker-compose down -v
docker-compose up -d
```

### Connectivity Issues

```bash
# Check network
docker network ls
docker inspect soc-network

# Test service discovery
docker-compose exec api ping elasticsearch
docker-compose exec api ping postgres
```

## Post-Installation

### 1. Change Default Passwords

**CRITICAL**: Change all default credentials in production!

```bash
# Update in .env and restart
cp .env .env.backup
nano .env
docker-compose restart
```

### 2. Enable SSL/TLS

Generate certificates:

```bash
./scripts/generate-certificates.sh
```

Update docker-compose.yml:

```yaml
environment:
  - SSL_ENABLED=true
  - SSL_CERT_PATH=/etc/ssl/certs/server.crt
  - SSL_KEY_PATH=/etc/ssl/private/server.key
```

### 3. Configure Backups

```bash
# Enable automated backups
export BACKUP_ENABLED=true
export BACKUP_SCHEDULE="0 2 * * *"  # 2 AM daily

# Manual backup
./scripts/backup.sh
```

### 4. Set Up Monitoring

```bash
# Enable Prometheus metrics
export METRICS_ENABLED=true

# Access Prometheus
# http://localhost:9090
```

## Next Steps

- [User Guide](./user-guide.md) - Learn how to use the platform
- [Security Best Practices](./security-best-practices.md) - Harden your deployment
- [Production Deployment](./deployment/production.md) - Deploy to production
- [API Documentation](./api.md) - Integrate with your systems

## Support

- Check [Troubleshooting](./troubleshooting.md) for common issues
- Review logs: `docker-compose logs`
- Open an issue on [GitHub](https://github.com/MSDLA/soc-platform-integrated/issues)