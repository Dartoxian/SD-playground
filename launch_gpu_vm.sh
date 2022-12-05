#!/bin/bash

# Launching a VM with a GPU is a PITA

set -x

for zone in `cat t4_zones.txt`; do
  gcloud compute instances create imaginairy-instance \
      --project=imaginairy-testing \
      --zone=$zone \
      --machine-type=n1-highmem-4 \
      --network-interface=network-tier=PREMIUM,subnet=default \
      --maintenance-policy=TERMINATE \
      --provisioning-model=STANDARD \
      --service-account=810302403673-compute@developer.gserviceaccount.com \
      --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append \
      --accelerator=count=1,type=nvidia-tesla-t4 \
      --create-disk=auto-delete=yes,boot=yes,device-name=instance-1,image=projects/ml-images/global/images/c0-deeplearning-common-cu110-v20221107-debian-10,mode=rw,size=100,type=projects/imaginairy-testing/zones/us-central1-a/diskTypes/pd-balanced \
      --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --reservation-affinity=any

done;