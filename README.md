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
