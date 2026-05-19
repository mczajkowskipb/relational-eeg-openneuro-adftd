# v2.1 hotfix

Fixes `R/lib/collectors.R` regex patterns that failed on some R versions with:

```text
Error: '\.' is an unrecognized escape in character string
```

The collector now uses `[.]csv` regex patterns instead of escaped-dot strings.
