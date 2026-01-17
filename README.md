# ECON1550 International Finance — Spring 2026

Private instructor repository for ECON1550.

## Quick links

- [Course configuration](course.yml)
- [Architecture and design](docs/PRD.md)
- [Instantiation checklist](docs/INSTANTIATION_CHECKLIST.md)
- [Secrets and permissions](docs/SECRETS_AND_PERMISSIONS.md)

## Workflow

Push to `main` triggers the orchestrator workflow which:

1. Validates `course.yml`
2. Computes release stages based on current time
3. Builds the Quarto site and LaTeX PDFs
4. Runs guardrail scans
5. Publishes to the student repo (if publishing is enabled)

Manual publishing: **Actions → course-orchestrator → Run workflow**

## File structure

- `course.yml` — course metadata and release schedules
- `psets/` — problem sets and solutions
- `lectures/` — lecture notes
- `slides/` — presentation slides
- `scripts/` — build and validation scripts
- `student_repo/` — files synced to student repo `main` branch
