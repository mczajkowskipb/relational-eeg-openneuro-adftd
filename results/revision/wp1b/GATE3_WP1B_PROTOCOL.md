# Frozen protocol: Gate 3 WP1B

## Scope lock

WP1B jest sensitivity analysis dla liniowej, addytywnej korekty wieku i płci.
Jednostką jest dokładnie jeden z 4000 zaakceptowanych primary k-TSP replay
records Gate 2C. Nie wykonuje się ponownie wariantu original; jego predykcje i
relacje są czytane z zamrożonego Gate 2C.

Dozwolone reprezentacje:

1. `RAW_DECILES` (P0),
2. `DERIVED_DECILES_ALL` (P0),
3. `REGION_AGGREGATES_ALL` (P0),
4. `PSD_ABSOLUTE_CHANNEL_BAND` (P1),
5. `PSD_REGION_ABSOLUTE` (P1).

Każda reprezentacja obejmuje osiem task-condition settings, 20 powtórzeń i
pięć outer foldów. P0 i P1 mają odrębne rodziny splitów i nie są parowane.

## Residualizacja

Dla każdego outer-training foldu i każdego deskryptora `j`:

```
age_c = age - mean(age_train)
sex_c = female01 - mean(female01_train)
x_j = intercept_j + beta_age_j * age_c + beta_sex_j * sex_c + error_j
x_j_adjusted = x_j - beta_age_j * age_c - beta_sex_j * sex_c
```

Parametry centrowania i współczynniki OLS są wyznaczane wyłącznie z
outer-training fold. Te same parametry są stosowane do outer-test. Intercept
nie jest odejmowany, dlatego treningowa średnia deskryptora zostaje zachowana.

Kodowanie: `female=1`, `male=0`. Model jest wspólny dla obu klas. Diagnoza,
interakcje, splajny, modele nieliniowe, skalowanie i standaryzacja nie są
używane. Residualizacja następuje przed `SWAP.Filter.Wilcoxon` oraz k-TSP.

## k-TSP lock

Runner adjusted jest tworzony przez deterministyczną, audytowaną modyfikację
kopii zaakceptowanego runnera Gate 2C o SHA-256
`c64ab42fbcb13e3664eab8f0ad6c638bd4661c5d778fb4f1091fe486a346e25a`.
Zachowane są: `switchBox`, `krange=c(1,3,5,9)`, `KbyTtest`, Wilcoxon,
`featureNo=100`, `disjoint=TRUE`, `handleTies=FALSE`, poziomy klas i obsługa
remisów. `KbyTtest` nie jest inner CV; WP1B nie dodaje inner resamplingu.

## Blokujący preflight

Pełny run nie startuje, dopóki każdy z 4000 rekordów nie potwierdzi:

- jednoznacznego odwzorowania na zamrożony rekord Gate 2C;
- pięciu oczekiwanych reprezentacji i wymaganych liczebności P0/P1;
- kompletnego joinu `subject_id` do właściwego `participants.tsv`;
- zgodności hashów obu `participants.tsv` ze źródłami zatwierdzonymi w WP1A;
- braku overlapu uczestników train/test;
- pełnej rangi `[1, age_c, sex_c]`;
- skończonych raw values, współczynników i adjusted values;
- identycznych uczestników i kolumn feature przed i po korekcie;
- zachowania treningowej średniej każdego feature z tolerancją
  `1e-10 * max(1, abs(mean_raw_train))`;
- `test_rows_used_for_residualizer_fit=0`;
- obecności i integralności zamrożonych predykcji oraz relacji Gate 2C.

Po pełnym metadata/residualization preflight wykonywany jest blokujący adjusted
smoke: jeden zaakceptowany rekord dla każdej z 40 kombinacji reprezentacja ×
task-condition. Joby smoke są częścią właściwych 4000, pozostają w output i są
pomijane podczas uruchamiania pozostałych rekordów.

## Raportowanie

Metryki są liczone po połączeniu pięciu OOF foldów w obrębie powtórzenia.
Raportowane są original i adjusted: macro-F1 z zero-division=0, balanced
accuracy, MCC, accuracy, precision/recall/F1/support obu klas, a także sparowane
`adjusted_minus_original`, odsetek zmian predykcji i przejścia
correct→incorrect / incorrect→correct.

Dla relacji raportowane są per job i per repeat: exact selected K, zmiana K,
direction-sensitive Jaccard, direction-insensitive Jaccard, oba warianty overlap
coefficient oraz reversal rate wśród wspólnych nieuporządkowanych par. Gdy nie
ma wspólnych par, reversal rate jest `NA`. Tie-rate oznacza częstość dokładnych
równości wartości lewej i prawej cechy w głosach wybranych relacji; train i OOF
test są raportowane osobno, przed i po korekcie.

Nie są liczone p-values, AUC ani permutation analysis. Nie wybiera się nowej
„najlepszej” reprezentacji.

## Główne artefakty

- `config/gate3_wp1b_4000.csv`
- `config/gate3_wp1b_gate2c_mapping.csv`
- `preflight/gate3_wp1b_preflight_audit.csv`
- `results/gate3_wp1b_oof_predictions.csv`
- `results/gate3_wp1b_repeat_metrics.csv`
- `results/gate3_wp1b_setting_summary.csv`
- `results/gate3_wp1b_exact_relations_original_vs_adjusted.csv`
- `results/gate3_wp1b_job_relation_comparison.csv`
- `results/gate3_wp1b_repeat_relation_summary.csv`
- `results/gate3_wp1b_residualization_audit.csv`
- `results/gate3_wp1b_vote_tie_audit.csv`
- `validation/gate3_wp1b_independent_metric_reproduction.csv`
- `validation/gate3_wp1b_independent_relation_reproduction.csv`
- `VALIDATION_REPORT.txt`, `VALIDATION_COMPLETE`, `WP1B_STOP.txt`
- `MANIFEST.sha256` oraz zewnętrzny SHA-256 archiwum.

## Interpretacja

WP1B nie ma arbitralnego progu równoważności. Stabilność wspiera odporność na
konkretną liniową, addytywną korektę wieku i płci, ale nie dowodzi braku
confoundingu. Stabilne metryki przy niskim Jaccard oznaczają niestabilność
interpretacji relacji. Spadek sugeruje demograficzną zależność części sygnału.
Wzrost może oznaczać usunięcie wariancji zakłócającej albo zmianę struktury
remisów i nie jest automatycznie „poprawą modelu”.
