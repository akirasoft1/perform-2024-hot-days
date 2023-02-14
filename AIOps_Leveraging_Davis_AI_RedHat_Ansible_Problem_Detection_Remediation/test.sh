
cat > ./tagging.json << EOF
    {
            "name": "{{ .name }}",
            "rules": [
                {
                    "type": "PROCESS_GROUP",
                    "enabled": true,
                    "valueFormat": null,
                    "propagationTypes": [
                        "PROCESS_GROUP_TO_SERVICE"
                    ],
                    "conditions": [
                        {
                            "key": {
                                "attribute": "PROCESS_GROUP_PREDEFINED_METADATA",
                                "dynamicKey": "KUBERNETES_NAMESPACE",
                                "type": "PROCESS_PREDEFINED_METADATA_KEY"
                            },
                            "comparisonInfo": {
                                "type": "STRING",
                                "operator": "EQUALS",
                                "value": "{{ .namespace }}",
                                "negate": false,
                                "caseSensitive": true
                            }
                        }
                    ]
                },
                {
                    "type": "APPLICATION",
                    "enabled": true,
                    "valueFormat": null,
                    "normalization": "LEAVE_TEXT_AS_IS",
                    "propagationTypes": [],
                    "conditions": [
                        {
                            "key": {
                                "attribute": "WEB_APPLICATION_NAME",
                                "type": "STATIC"
                            },
                            "comparisonInfo": {
                                "type": "STRING",
                                "operator": "EQUALS",
                                "value": "{{ .applicationName }}",
                                "negate": false,
                                "caseSensitive": true
                            }
                        }
                    ]
                }
            ]
    }
EOF