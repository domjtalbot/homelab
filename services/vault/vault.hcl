ui = true

disable_mlock = true

cluster_addr = "http://vault:8201"

listener "tcp" {
  address = "0.0.0.0:8200"
  cluster_address = "0.0.0.0:8201"
  tls_disable = "true"
}

storage "raft" {
  path = "/vault/raft"
}

audit "file" {
  file_path = "/vault/audit/vault_audit.log"
}
