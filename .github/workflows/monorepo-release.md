# Using the Monorepo Release Workflow

## Setup

Copy this workflow into your `.github/workflows` directory at the root of your project.

Actors should be created within an `actor` directory at the root of your project.

A GitHub repository or environment secret must be created for each actor in the format `WASH_$ACTORNAME_SECRET`.

## Initiation

The workflow is initiated by pushing a tag in the format `$actorname-vx.x.x` which must be the same version as the one in your actors cargo.toml file.

## Jobs

The Monorepo Workflow consists of 3 Jobs:

1. build_signed_actor - build your actor and uploads wasm files to github actions
2. github_release - downloads build, generates release notes, and releases to github
3. artifact_release (to github container repository) - uploads image to GHCR

github_release and artifact_release require build_signed_actor to complete before running.
