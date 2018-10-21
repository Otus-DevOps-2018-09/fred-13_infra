#!/bin/bash
gcloud beta compute --project=second-casing-218612 instances create reddit-full\
 --zone=europe-west1-d \
 --machine-type=g1-small \
 --subnet=default \
 --network-tier=PREMIUM \
 --maintenance-policy=MIGRATE \
 --service-account=437800943692-compute@developer.gserviceaccount.com \
 --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append \
 --tags=puma-server \
 --image=reddit-full-1540130800 \
 --image-project=second-casing-218612 \
 --boot-disk-size=10GB \
 --boot-disk-type=pd-standard \
 --boot-disk-device-name=reddit-full
