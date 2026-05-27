# Deployment Guide

## Prerequisites

- Ubuntu 20.04 LTS or CentOS 8+
- 2+ vCPU, 8GB RAM per component
- Root/sudo access
- Network connectivity between all nodes

## Security Onion Installation

### Manager Node

```bash
# Download and run installer
wget https://github.com/Security-Onion-Solutions/security-onion/releases/download/v2.4.0/securityonion-2.4.0.iso

# Boot from ISO and follow setup wizard
# Select "Manager" role
# Configure network interfaces
# Set admin credentials
```

### Sensor Nodes

```bash
# Follow same process as manager
# Select "Sensor" role during setup
# Point to manager IP address
# Configure network interface for traffic mirroring
```

### Verification

```bash
# SSH to manager
ssh admin@security-onion-manager

# Check manager status
sudo so-status

# Verify sensors are connected
sudo so-node-status
```

## Wazuh Installation

### Manager Node

```bash
# Install dependencies
sudo apt-get update
sudo apt-get install curl gnupg -y

# Add Wazuh repository
curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | apt-key add -
echo "deb https://packages.wazuh.com/4.x/apt/ stable main" > /etc/apt/sources.list.d/wazuh.list

# Install Wazuh manager
sudo apt-get update
sudo apt-get install wazuh-manager wazuh-agent -y

# Start services
sudo systemctl restart wazuh-manager
sudo systemctl restart wazuh-agent
```

### Indexer Node

```bash
# Install Elasticsearch/Wazuh Indexer
sudo apt-get install wazuh-indexer -y

# Configure clustering
# Edit /etc/wazuh-indexer/opensearch.yml
sudo systemctl restart wazuh-indexer
```

### Dashboard Node

```bash
# Install Wazuh Dashboard
sudo apt-get install wazuh-dashboard -y

# Configure dashboard
# Edit /etc/wazuh-dashboard/opensearch_dashboards.yml
sudo systemctl restart wazuh-dashboard
```

## Agent Installation

### Linux Agents

```bash
# Download agent
wget https://packages.wazuh.com/4.x/apt/pool/main/w/wazuh-agent/wazuh-agent_4.x.x-1_amd64.deb

# Install
sudo dpkg -i wazuh-agent_4.x.x-1_amd64.deb

# Enroll with manager
sudo /var/ossec/bin/wazuh-control start

# Verify connectivity
sudo /var/ossec/bin/agent-auth -m <manager-ip>
```

### Windows Agents

```powershell
# Download installer
Invoke-WebRequest -Uri "https://packages.wazuh.com/4.x/windows/wazuh-agent-4.x.x-1.msi" -OutFile "$env:USERPROFILE\Downloads\wazuh-agent.msi"

# Install with manager IP
msiexec.exe /i "$env:USERPROFILE\Downloads\wazuh-agent.msi" /quiet WAZUH_MANAGER_IP="<manager-ip>"

# Start agent service
Start-Service -Name WazuhSvc
```

## Integration

### Forward Security Onion Logs to Wazuh

Edit `/etc/rsyslog.d/99-wazuh.conf`:

```
*.* @@<wazuh-manager-ip>:514
```

Restart rsyslog:

```bash
sudo systemctl restart rsyslog
```

### Verify Integration

```bash
# Check Wazuh dashboard
# Navigate to: https://<wazuh-dashboard-ip>:443

# Verify alerts
# Go to: Modules > Security Events
```

---

**For detailed instructions, refer to official vendor documentation.**
