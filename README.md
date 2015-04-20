Redis BOSH deployment pipeline
==============================

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
