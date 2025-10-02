#!/bin/bash
# Health Check Script

echo "=== Hybrid Anomaly Detection SOC Health Check ==="

# Check Splunk
curl -k -u admin:password https://localhost:8089/services/server/info > /dev/null 2>&1
if [ \True -eq 0 ]; then
    echo "[OK] Splunk Management API (8089)"
else
    echo "[FAIL] Splunk Management API"
fi

# Check HEC
curl -k https://localhost:8088/services/collector/health > /dev/null 2>&1
if [ \True -eq 0 ]; then
    echo "[OK] Splunk HEC (8088)"
else
    echo "[FAIL] Splunk HEC"
fi

# Check TheHive
curl -s http://localhost:9000/api/v1/health > /dev/null 2>&1
if [ \True -eq 0 ]; then
    echo "[OK] TheHive (9000)"
else
    echo "[FAIL] TheHive"
fi

echo "=== Health Check Complete ==="
