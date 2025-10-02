# AI/ML Pipeline

## Overview
Isolation Forest-based anomaly detection for security events.

## Architecture

### Feature Engineering (21 Features)

**Temporal (5)**:
- hour_of_day
- day_of_week
- is_weekend
- is_business_hours
- minute_of_hour

**Categorical (4)** - MD5 hashed:
- user_hash
- action_hash
- process_hash
- logsrc_hash

**Network (4)**:
- src_ip_int (IPv4 to integer)
- dest_port
- bytes_in
- bytes_out

**Behavioral (8)**:
- user_event_count
- user_unique_ips
- user_unique_actions
- user_avg_hour
- user_hour_std
- ip_unique_users
- ip_unique_actions
- ip_event_count

## Model Configuration

\\\python
Algorithm: Isolation Forest
Contamination: 0.1 (10% anomaly assumption)
Trees: 100
Max Samples: 256
Training Window: 7 days rolling
Performance: 0.92 AUC-ROC, 85% TPR
\\\

## Severity Classification

- **Critical (5)**: Score > p99.7
- **High (4)**: Score p99 - p99.7
- **Medium (3)**: Score < p99

## Workflow

\\\
Splunk Export (last 15min) ?
Feature Engineering ?
Deduplication (by minute|user|action|host) ?
Isolation Forest Scoring ?
Severity Classification ?
HEC Write to ai_anomalies ?
Promotion to incidents_summary (sev=4) ?
TheHive Alert (webhook)
\\\

## Execution Schedule
Cron: \*/5 * * * *\ (every 5 minutes)
