#!/usr/bin/env bash
set -u

missing=0

required_files=(
  "AGENTS.md"
  "README.md"
  "STATUS.md"
  "PUBLIC_BOUNDARY.md"
  "CLAIMS.md"
  "VALIDATION.md"
  "ARTIFACT_REGISTER.md"
  "REVIEW_LOG.md"
  "requirements.txt"
  "civic-boundary/README.md"
  "civic-boundary/personal-engineering-civic-production-boundary.md"
  "recycling-automation-lines/README.md"
  "recycling-automation-lines/synthetic-recycling-line-study-template.md"
  "3d-print-production-workflows/README.md"
  "3d-print-production-workflows/public-safe-3d-print-workflow-notes.md"
  "recycled-material-parts/README.md"
  "recycled-material-parts/recycled-material-part-study-template.md"
  "civic-node-hardware-context/README.md"
  "civic-node-hardware-context/civic-node-hardware-boundary.md"
  "school-infrastructure-systems/README.md"
  "school-infrastructure-systems/school-infrastructure-boundary.md"
  "disaster-resilient-production/README.md"
  "disaster-resilient-production/disaster-production-boundary.md"
  "throughput-material-flow/README.md"
  "throughput-material-flow/synthetic-throughput-assumptions.csv"
  "throughput-material-flow/material-flow-study-template.md"
  "qa-checklists/README.md"
  "qa-checklists/public-safe-qa-checklist.md"
  "safety-assumptions/README.md"
  "safety-assumptions/process-safety-assumptions.md"
  "public-safe-renders/README.md"
  "public-safe-renders/render-publication-policy.md"
  "dashboard-notes/README.md"
  "dashboard-notes/generic-dashboard-boundary.md"
  "workflow-notes/README.md"
  "workflow-notes/generic-n8n-workflow-boundary.md"
  "data-logging-notes/README.md"
  "data-logging-notes/postgres-qdrant-minio-boundary.md"
  "diagrams/README.md"
  "diagrams/civic-production-boundary-map.mmd"
  "scripts/validate-public-boundary.sh"
  "scripts/run-synthetic-throughput-template.py"
  "templates/civic-production-study-template.md"
  "templates/civic-boundary-review-template.md"
  "templates/qa-review-template.md"
)

for file in "${required_files[@]}"; do
  if [ -f "$file" ]; then
    printf "PASS %s\n" "$file"
  else
    printf "FAIL %s\n" "$file"
    missing=$((missing + 1))
  fi
done

required_terms=(
  "planned"
  "scaffolded"
  "published"
  "released"
  "private/not-public"
  "Foundation-private"
  "donor data"
  "student data"
  "volunteer data"
  "school deployment"
  "production recycling line"
  "live civic node"
  "manufacturing readiness"
  "certified safety"
  "production CAD"
  "production schematics"
  "BOMs"
  "Gerbers"
  "exact dimensions"
  "private facility"
  "sealed geometry"
  "validation"
  "review"
)

for term in "${required_terms[@]}"; do
  if rg -q "$term" .; then
    printf "PASS term: %s\n" "$term"
  else
    printf "FAIL term: %s\n" "$term"
    missing=$((missing + 1))
  fi
done

blocked_files="$(find . -path ./.git -prune -o \( -iname '*.f3d' -o -iname '*.step' -o -iname '*.stp' -o -iname '*.stl' -o -iname '*.kicad_pcb' -o -iname '*.sch' -o -iname '*.brd' -o -iname '*.gbr' -o -iname '*bom*' \) -print)"
if [ -z "$blocked_files" ]; then
  printf "PASS blocked production artifact scan\n"
else
  printf "FAIL blocked production artifact scan\n%s\n" "$blocked_files"
  missing=$((missing + 1))
fi

if [ "$missing" -eq 0 ]; then
  printf "Result: PASS - civic production public boundary scaffold is complete.\n"
else
  printf "Result: FAIL - %s required checks failed.\n" "$missing"
fi

exit "$missing"
