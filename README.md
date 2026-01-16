# Course Repo Template

This repository is a course-agnostic template for running a modern course with automated build and publish workflows.

Design goal.
Keep instructor-only sources private while continuously publishing student-facing outputs to a separate public student repository, with guardrails that make it hard to accidentally publish solutions.

What you get in this template

- `course.yml` as the single source of truth for course metadata, staff logistics, and release schedules.
- A documented architecture spec (`PRD.md`) that explains the two-repo model (private instructor repo -> public student repo).
- A concrete `course.yml` schema (JSON Schema + validator) so configuration mistakes fail fast.
- A working GitHub Actions orchestrator (`.github/workflows/orchestrator.yml`) implementing:
  - hourly scheduled runs for time-based releases,
  - a daily full rebuild to catch latent build breakage,
  - a dry-run-first governance model (`workflow_dispatch` is always dry-run),
  - explicit publishing gates via repo variables,
  - layered leak prevention (blocked paths + marker scans + optional PDF text tripwires).
- Minimal example content so the pipeline can succeed out of the box:
  - a Quarto website (`_quarto.yml`, `index.qmd`) that renders into `public/`,
  - example LaTeX problem sets + solutions under `psets/`,
  - example LaTeX lecture notes + slides under `lectures/` and `slides/`.

## Folder map

- `PRD.md`
  - End-to-end architecture, workflow contracts, and guardrails.
- `COURSE_CONFIG.md`
  - `course.yml` schema, derived identifiers, and rendering rules (including null handling).
- `INSTANTIATION_CHECKLIST.md`
  - New-course checklist.
- `SECRETS_AND_PERMISSIONS.md`
  - Secret inventory and least-privilege guidance.
- `course.template.yml`
  - Copy this to `course.yml` when instantiating a new term.
- `course.example.yml`
  - A filled example `course.yml` you can adapt.
- `schemas/course.schema.json`
  - JSON Schema for `course.yml`.
- `scripts/`
  - Config validation, release-stage computation, staging, guardrail scans, and helper scripts.
- `resources/`
  - Allowlist/denylist patterns and tripwire configuration.
- `student_repo/`
  - Files that should live in the public student repo `main` branch.
  - Most importantly: `.github/workflows/deploy-pages.yml` for GitHub Pages (Actions-based deploy).

## Quickstart

1) Copy `course.template.yml` to `course.yml` and fill in values.
2) Validate config locally:

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r scripts/requirements.txt
python scripts/validate_course_yml.py course.yml schemas/course.schema.json
```

3) Create the public student repo, set Pages Source to `GitHub Actions`, and ensure branches `main` and `gh-pages` exist.
4) In the instructor repo, add secret `STUDENT_REPO_TOKEN` (fine-grained PAT) and set repo variables (see `INSTANTIATION_CHECKLIST.md`).
5) Trigger the orchestrator via `workflow_dispatch` (dry-run).
6) Enable scheduled publishing by setting `SCHEDULED_PUBLISH_ENABLED=true`.

## Build conventions used by this template

- Quarto site output directory: `public/`.
- LaTeX builds run inside `texlive/texlive:TL2024-historic` and use `latexmk -pdf -shell-escape`.
- Naming conventions:
  - Problem sets: `psets/<id>/<id>.tex` and `psets/<id>/<id>_solutions.tex`.
  - Lecture notes: `lectures/<id>/<id>.tex`.
  - Slides: `slides/<id>/<id>.tex`.

You can change conventions by editing the scripts in `scripts/` and/or the orchestrator workflow.
