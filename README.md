
# IBM Cloud Infra Terraform 🛠️☁️

Reusable **Terraform modules & blueprints** for building production‑grade
infrastructure on **IBM Cloud**—from VPC networks and container platforms to
databases, object storage, and Power Virtual Servers.
Author: Olavo Borges

---

## 📂 Repository structure

```
modules/
│
├─ network/
│   ├─ vpc/                  # Highly‑available VPC with 3 zones
│
├─ compute/
│   ├─ vsi/                  # Virtual Server for VPC
│   ├─ iks/                  # IBM Kubernetes Service (VPC)
│   ├─ roks/                 # OpenShift on IBM Cloud (VPC)
│   └─ powervs/              # Power Virtual Server (+ workspace / subnet / key)
│
├─ containers/
│   ├─ code_engine/          # Code Engine project + app
│   └─ container_registry/   # Cloud Container Registry
│
├─ databases/
│   ├─ postgres/             # Databases for PostgreSQL
│   ├─ edb/                  # Databases for EnterpriseDB
│   ├─ mysql/                # Databases for MySQL
│   ├─ mongodb/              # Databases for MongoDB
│   ├─ elasticsearch/        # Databases for Elasticsearch
│   ├─ redis/                # Databases for Redis
│   ├─ cloudant/             # Cloudant NoSQL
│   ├─ db2/                  # Db2 on Cloud (transactions)
│   └─ db2_warehouse/        # Db2 Warehouse on Cloud (analytics)
│
├─ storage/
│   ├─ cos/                  # Cloud Object Storage
│   └─ block_storage/        # VPC block volumes
│
└─ LICENSE, .gitignore, etc.
```

Each module is **self‑contained** (`main.tf` + `variables.tf` + `outputs.tf`)
and follows IBM Cloud Terraform best‑practices:

* provider pinned (`>= 1.12.0`)
* opinionated but overridable defaults
* creates prerequisites automatically (e.g. VPC subnets, SSH keys, PowerVS
  workspaces) when IDs are not supplied
* documents every variable & output

---

## 🚀 Quick start

> Prereqs – [Terraform ≥ 1.5](https://developer.hashicorp.com/terraform/downloads) and an IBM Cloud API key.

```bash
# 1. clone the repo
git clone https://github.com/oborges/ibmcloud-infra-terraform.git
cd ibmcloud-infra-terraform/envs/dev   # <- where you keep your stacks

# 2. export your API key
export IBMCLOUD_API_KEY="<your‑apikey>"

# 3. initialise & review
terraform init
terraform plan  -var='instance_name=my-vsi'  # example

# 4. apply
terraform apply
```

---

## 🧩 Module catalogue

| Category  | Module | Quick default |
|-----------|--------|---------------|
| **Network** | `vpc` | Tri‑zone VPC with subnets & routing |
| **Compute / Containers** | `vsi`, `iks`, `roks` | VSI, IKS, ROKS clusters |
| | `code_engine` | Project + hello‑world app |
| | `powervs` | AIX 7300 VM on e980 (PowerVS) |
| **Databases** | `postgres`, `edb`, `mysql`, `mongodb`, `elasticsearch`, `redis`, `cloudant`, `db2`, `db2_warehouse` | Single‑instance service with generated admin password |
| **Storage** | `cos` | COS instance (standard plan) |
| | `block_storage` | 100 GiB GP2 volume |
| **Registry** | `container_registry` | Global Container Registry |

---

## 📝 Contributing

* Fork → branch → PR.  
* Adhere to the three‑file layout (`main.tf`, `variables.tf`, `outputs.tf`).  
* Run `terraform fmt` and `terraform validate` before pushing.

### Road‑map ideas

* VPC load‑balancer module  
* Transit Gateway peerings  
* WatsonX integration  

---

## 🔗 Useful links

* **IBM Cloud Terraform provider**  
  <https://registry.terraform.io/providers/IBM-Cloud/ibm/latest>
* **IBM Cloud docs** – Terraform how‑tos  
  <https://cloud.ibm.com/docs/ibm-cloud-provider-for-terraform>
* **Power Virtual Server docs**  
  <https://cloud.ibm.com/docs/power-iaas>

---

### License

[MIT](LICENSE)

---

*Happy automating on IBM Cloud!*
