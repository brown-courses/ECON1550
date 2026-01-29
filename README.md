# ECON1550 International Finance - Spring 2026

Private instructor repository for ECON1550. LaTeX sources live in the `overleaf/` submodule; the public-facing site is built with Quarto.

## Quick links

- Course config: `overleaf/course.yml`
- Docs: `docs/README.md`, `docs/PRD.md`, `docs/COURSE_CONFIG.md`, `docs/SECRETS_AND_PERMISSIONS.md`, `docs/VSCODE_LATEX_SETUP.md`
- CI workflows: `.github/workflows/orchestrator.yml`, `.github/workflows/syllabus-lastmod.yml`

## Workflow (CI)

The orchestrator workflow:

1. Validates `overleaf/course.yml`
2. Computes release stages (`build/release_manifest.json`)
3. Builds the Quarto site into `public/`
4. Builds LaTeX PDFs from the Overleaf submodule in Docker
5. Stages student-facing outputs and runs guardrails
6. Publishes to the student repo (`main` + `gh-pages`) when publishing is enabled

Manual publishing: Actions -> course-orchestrator -> Run workflow.

## File structure

- `overleaf/` - LaTeX sources (Problem Sets, Notes, Slides, Exams, Syllabus) + `course.yml`
- `index.qmd`, `materials.qmd`, `schedule.qmd` - Quarto site pages
- `_quarto.yml` - site configuration (output to `public/`)
- `scripts/` - CI and build helper scripts
- `resources/` - allowlist/denylist and scan patterns
- `student_repo/` - bootstrap content for the public student repo `main` branch
- `src/` - allowlisted student-facing sources (currently empty)
- `build/` and `public/` - generated artifacts
