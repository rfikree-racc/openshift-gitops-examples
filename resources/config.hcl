disable_mlock = true
ui = true
log_level = "Debug"

listener "tcp" {
    tls_disable = 1
    address = "[::]:8200"
    cluster_address = "[::]:8201"
    // Enable unauthenticated metrics access (necessary for Prometheus Operator)
    telemetry {
        unauthenticated_metrics_access = "true"
    }
}

storage "raft" {
    path = "/vault/data"
}

service_registration "kubernetes" {}
// Example configuration auto unseal with azure and awskms
seal "awskms" {
    region     = "AWS_REGION"
    access_key = "AWS_ACCESS_KEY"
    secret_key = "AWS_SECRET_KEY"
    kms_key_id = "AWS_KMS_KEY_ID"
    endpoint   = "AWS_ENDPOINT"
}

// Example configuration for enabling Prometheus metrics in your config.
telemetry {
    dogstatsd_addr = "localhost:8125"
    prometheus_retention_time = "30s"
    enable_hostname_label = true
}