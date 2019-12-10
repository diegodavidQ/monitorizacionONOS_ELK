#! /bin/bash
curl -u elastic:pass -k -XPOST 'http://localhost:5601/api/kibana/dashboards/import' -H 'Content-Type: application/json' -H "kbn-xsrf: true" -d @dashboard/dashboardONOS.json





