Redis BOSH deployment pipeline
==============================

NOTE: this readme was written first, then the pipeline was developed and I haven't yet updated the README to reflect what I've actually implemented so far.

But here's a picture of the basic pipeline to deploy Redis three times in succession:

![pipeline](http://cl.ly/image/000Z2h041U3g/pipeline.png)

This repository is an example of a corporate pipeline for a BOSH deployment through to production.

There are 4 deployments described (`dev1`, `dev2`, `staging` and `production`) of the https://github.com/cloudfoundry-community/redis-boshrelease Redis BOSH release.

-	`dev1` & `dev2` are two independent deployments that are being used for development of the Redis release and/or other attributes of the deployment that might go through to `production`.
-	`staging` is a deployment that represents a near clone of what `production` will soon become.
-	`production` is the utlimate deployment - the cluster that is being used by a production system.

No changes are directly made to `production`. Rather, changes are first tested in `staging` and then promoted to `production`.

Similarly, `staging` is only for changes that have been dev/tested in either `dev1` or `dev2` first. It should also only be for staging candidates for `production`. As a corollary, only final releases of BOSH releases are to be considered by `staging`.

Therefore, final releases are to be developed and cut based on work in `dev1` and/or `dev2`.

After `production` is ever upgraded/resized/reconfigred it will be using the same deployment manifest as `staging`, with the expection of only the very minor differences - such as networking, public URLs, etc.

`staging` is only different from `production` when it is being changed into a test candidate for `production`.

The changes to be applied to `production` must be the same as those applied to `staging` for its candidate. As such, `staging` must be reset back to look like `production` prior to each candidate deployment.

Manifest templates
------------------

To create the BOSH deployment manifests for each deployment (`dev1`, `dev2`, `staging` and `production`), this project will use spiff templates.

-	some from the upstream https://github.com/cloudfoundry-community/redis-boshrelease repository
-	some that are dedicated to each deployment (networking, public hostnames, etc)
-	some that are in response to the runtime environment (scaling)

This project, including running Concourse pipeline, will control the set of templates used to construct deployment manifests. They will be composed together as a `tgz` tarball and stored in S3. These templates tarball are the candidates for deployment.

A deployment to `production` is only possible for templates tarballs that deployed successfully into `staging` (and passed any integration tests), and include final releases.

A deployment to `staging` is only possible for templates tarballs that deployed successfully into either `dev1` or `dev2`, and include final releases.

### dev1

The `dev` deployments are for humans to experiment with future change proposals to production.

They might use dev and/or final releases. They might use spiff templates from branches. They might be upgraded or destroyed/recreated.

For this Redis deployment there will be the following templates:

-	`deployment.yml` - from redis-boshrelease
-	`jobs.yml` - from redis-boshrelease
-	`infrastructure-warden.yml` - from redis-boshrelease
-	`networking-dev1.yml` - from `dev1/pipeline` folder
-	`scaling-dev1.yml` - from `dev1/pipeline` folder

The purpose of `networking-dev1.yml` is to ensure that the `dev1` deployment uses unique networking address ranges from the other deployments.

The purpose of `scaling-dev1.yml` is to document the size of the `dev1` Redis cluster.

Building/updating the base Docker image for tasks
-------------------------------------------------

Each task within all job build plans uses the same base Docker image for all dependencies. Using the same Docker image is a convenience. This section explains how to re-build and push it to Docker Hub.

All the resources used in the pipeline are shipped as independent Docker images and are outside the scope of this section.

```
./run-pipeline.sh redis-pipeline-image ci_image/pipeline.yml credentials.yml
```

This will ask your targeted Concourse to pull down this project repository, and build the `ci_image/Dockerfile`, and push it to a Docker image on Docker Hub.
