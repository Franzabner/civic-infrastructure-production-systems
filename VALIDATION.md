# Validation

Run from the repository root:

```bash
test -f README.md
test -f PUBLIC_BOUNDARY.md
test -f scripts/validate-public-boundary.sh
bash scripts/validate-public-boundary.sh
rg -n "planned|scaffolded|published|released|private/not-public|Foundation-private|donor data|student data|volunteer data|school deployment|production recycling line|live civic node|manufacturing readiness|certified safety|production CAD|production schematics|BOMs|Gerbers|exact dimensions|private facility|sealed geometry|validation|review" .
git diff --check
git status --short
```

Validation confirms file presence and boundary language. It does not certify safety, deployment, production readiness, or Foundation program status.
