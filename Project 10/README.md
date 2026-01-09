# Nginx monitoring and Logging

This project demonstrates how to set up monitoring and logging for an Nginx server using Prometheus and Grafana. It includes configurations for Prometheus to scrape metrics from Nginx and Grafana dashboards to visualize these metrics.


With this stack, you can:

- Monitor Nginx metrics in real-time via Prometheus and Grafana.

- Collect and analyze web server logs with Filebeat → Logstash → Elasticsearch → Kibana.

- Quickly spin up the stack using one command, with no manual configuration.
Preload Grafana dashboards and configure Prometheus as a datasource automatically.

- Use lightweight containers (Alpine for Nginx) where possible, keeping the setup lightweight and efficient.

Ideal for DevOps learning, demonstrations, and interviews, this stack provides a reproducible and production-like environment without complex setup.

## Features

1. **Containerized Observability Stack**

- Nginx, Prometheus, Grafana, Elasticsearch, Logstash, Filebeat all running in Docker.

2. **Preconfigured Monitoring & Visualization**

- Grafana automatically loads Prometheus as a datasource.

- Preloaded Nginx dashboard for real-time metrics.

3. **Real-Time Logging & Analysis**
- Logs from Nginx are shipped via Filebeat → Logstash → Elasticsearch → Kibana.

- Easy visualization and analysis of access logs.

4. **Lightweight & Efficient**
- Uses Alpine-based image for Nginx.

- Official lightweight images for Prometheus and Grafana where possible.

5. **Fully Automated Setup**
- One docker compose up -d command to run the entire stack.

- No manual systemd service configuration or permission issues.

6. **Scalable & Extensible**

- Add Nginx exporters, custom dashboards, alerting, or integrate with Kubernetes easily.

7. **Learning & Demo Friendly**

- Ideal for DevOps/SRE learning, showcasing observability pipelines, and interview demonstrations.

## Folder Structure

```
.
├── docker-compose.yml
├── filebeat
│   └── filebeat.yml
├── grafana
│   └── provisioning
│       ├── dashboards
│       │   ├── dashboards.yml
│       │   └── nginx-dashboard.json
│       └── datasources
│           └── prometheus.yml
├── logstash
│   └── logstash.conf
├── nginx
│   └── nginx.conf
├── prometheus
│   └── prometheus.yml
└── README.md
```

## Prerequisites

- **Docker** 20.10+

- **Docker Compose** 2.0+

- **Git**

## Getting Started

**Clone the repository:**

```sh
git clone https://github.com/yourusername/docker-observability-stack.git
cd docker-observability-stack
```

**Start the stack:**

```sh
docker compose up -d
```

**Verify containers are running:**

```sh
docker compose ps
```

## Access URLs

| Service | URL |
|---------|-----|
| Nginx | http://localhost |
| Prometheus | http://localhost:9090 |
| Grafana | http://localhost:3000 |
| Elasticsearch | http://localhost:9200 |
| Kibana | http://localhost:5601 |