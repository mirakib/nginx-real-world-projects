# Nginx monitoring and Logging

This project demonstrates how to set up monitoring and logging for an Nginx server using Prometheus and Grafana. It includes configurations for Prometheus to scrape metrics from Nginx and Grafana dashboards to visualize these metrics.

## Prerequisites
- Docker and Docker Compose installed on your machine.
- Basic knowledge of Nginx, Prometheus, and Grafana.
- Familiarity with Docker Compose files and YAML syntax.
- A running Nginx server to monitor.

## Setup Instructions

1. **Clone the Repository**: Start by cloning this repository to your local machine.

   ```bash
   git clone
    cd nginx-monitoring-logging
    ```
2. **Configure Nginx**: Ensure your Nginx server is configured to expose metrics for Prometheus. You may need to add the `nginx-prometheus-exporter` as a sidecar or configure Nginx to expose metrics directly.

3. **Update Prometheus Configuration**: Modify the `prometheus.yml` file to include your Nginx server as a scrape target.

4. **Start the Services**: Use Docker Compose to start the Nginx, Prometheus, and Grafana services.

   ```bash
   docker-compose up -d
   ```

5. **Access Grafana**: Open your web browser and navigate to `http://localhost:3000`. Log in with the default credentials (admin/admin) and change the password when prompted.
