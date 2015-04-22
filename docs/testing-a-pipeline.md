Testing a pipeline
==================

This document is some thoughts on why/how to test a pipeline and therefore how to TDD a pipeline.

Why?
----

A pipeline for Concourse of any complexity is a computer program. It has inputs (files, docker images, semver, git repos, BOSH assets), sequential and parallel steps, success and failure handling, and outputs (files, docker images, BOSH deployments, Cloud Foundry app deployments, git repos).

A pipeline for Concourse is not easily readable for comprehension of what it does, nor readable for verification that it will do the right thing. It is described as a YAML file of resources (inputs/outputs), and tasks performed within a job.

Each job is triggered based on external events (inputs changing) or the events from other jobs (outputs that are passed as inputs to another job). Whilst an individual job will only be running once at any time, it might be that multiple jobs within a pipeline are running concurrently. As of v0.46.0 of Concourse, it is not immediately obvious from the pipeline dashboard view that caused each Job to run and/or recently fail.

For the reasons it is desirable to describe the behavior of a pipeline with tests and to run the tests to confirm that the pipeline behaves as expected. This testing could itself be done by a pipeline. That is, changes to a pipeline could be discovered, tested, and promoted into production by another pipeline. Awesome.

How
---

One of the benefits of Concourse is that it is configurable and re-configurable by simple YAML files referencing simple external resources (git repo, github releases, s3 assets). The configuration can be stored in source control. This means we can programmatically take a proposed pipeline description (referenced as `pipeline.yml`), apply it to Concourse and test it.

With a pipeline uploaded we have the ability to:

-	trigger a job to start via Concourse ATC API
-	change an input resource
-	simulate the behavior of resource inputs with "simulated resources"

We can then wait for jobs to finish via the Concourse ATC API and/or wait for output resources to be updated.

Simulated resources
-------------------

**Simulated resources don't yet exist afaik** - they would take the same `source` and `params` as their real counterparts but perhaps be faster to use, easier to setup for tests.

A simulated resource would need to be installed into Concourse in tandem with normal resources - distributed by upstream Docker images or an additional BOSH release with one package per simulated resource.
