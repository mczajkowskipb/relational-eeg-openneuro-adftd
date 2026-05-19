# Reproducibility guide

Mode A is the default quick route and uses small/frozen CSV inputs. Mode B starts from public OpenNeuro derivative `.set` files and is enabled once the full extraction scripts are bound.

Recommended reviewer route:

```bash
make setup
make smoke
make collect
make stats
make figures
```
