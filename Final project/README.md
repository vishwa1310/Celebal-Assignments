# Cross-System Data Drift & Trust Monitoring Platform

The idea came from a pretty common real-world problem: companies have data spread across CRM, Billing, and Analytics systems, and these systems don't always agree with each other. A customer might exist in the CRM but never show up in Billing, or the revenue number in Billing might not match what Analytics is reporting. Usually nobody notices until it's already caused a problem.

So I built a small pipeline in Databricks that ingests data from all three systems, cleans it, compares it, checks for "drift" (basically, is something changing or breaking that shouldn't be), and finally boils everything down into one number — a **Trust Score** — that tells you how reliable the data is right now.

## What it actually does

At a high level, the pipeline follows a Bronze → Silver → Gold (Medallion) architecture:

- **Bronze** – raw data straight from the source tables, no changes
- **Silver** – cleaned data (duplicates and nulls removed)
- **Gold** – the actual analysis: comparison reports, drift reports, and the trust score

Everything is stored as Delta tables so I get versioning/history for free (`DESCRIBE HISTORY` on any table shows you the write history).

## Notebooks

I split the work into 6 notebooks, each one building on the previous:

**`01_Data_Ingestion.ipynb`** – Reads CRM, Billing, Analytics source tables and writes them as Bronze Delta tables

**`02_Data_Cleaning.ipynb`** – Checks for nulls and duplicates, drops them, writes the Silver tables

**`03_Data_Comparison.ipynb`** – Cross-checks CRM vs Billing (missing customers both ways), and compares revenue reported by Billing vs Analytics

**`04_Drift_detection.ipynb`** – Checks volume drift, schema drift, and distribution drift, each against a threshold

**`05_Trust_Score.ipynb`** – Combines missing-value % and volume drift into a single Trust Score (0–100)

**`06_SQL_Analysis.ipynb`** – Runs SQL queries on the Silver/Gold tables for reporting — this feeds the dashboard

There's also a Databricks dashboard built on top of the Gold tables, so you don't need to open notebooks to see the current status.

## Some actual results

Running this on the sample data I generated, here's what came out:

- CRM had 10,710 raw records, Billing had 11,914, Analytics had 912
- After cleaning: 194 duplicate CRM rows removed, 222 duplicate Billing rows removed, plus some nulls (mostly missing emails in CRM and missing amounts in Billing)
- ~3,969 customers exist in CRM but have no record in Billing at all
- Billing and Analytics disagreed on total revenue by about ₹16 lakh
- Volume drift between CRM and Billing came out to ~11–12%, which triggered an alert (threshold is 10%)
- Final Trust Score: **87.65 / 100 → "Good"**

(Note: since the datasets are synthetically generated, the exact counts shift a little each time you regenerate the data — but the overall pattern, like the ~12% volume drift and "Good" trust level, stays consistent.)

## How the Trust Score works

Nothing fancy, just:

```
Trust Score = 100 − Missing Value % − Volume Drift %
```

Capped at a minimum of 0. Then mapped to a label:
- 90+ → Excellent
- 75–89 → Good
- 60–74 → Average
- below 60 → Poor

I kept it simple on purpose — the goal was to have something interpretable, not a black-box score. It can definitely get more sophisticated later (see below).

## Known limitations / things I'd improve

- The schema drift check right now literally compares CRM's schema to Billing's schema — but those are different systems with different columns by design, so it basically always flags a "difference." A better version would track one table's schema over time (Delta Lake's time travel makes this easy) instead of comparing two unrelated tables.
- Drift thresholds (10% for volume, ₹500 for average transaction) are hardcoded for now. In a real setup these should probably be configurable or based on historical baselines instead of a fixed number I picked.
- Everything here runs in batch. The proposal mentions streaming, but I haven't gotten to that part yet.
- Trust Score formula is intentionally basic — no weighting between different types of drift, no ML involved.

## Tech stack

- PySpark (all the transformations)
- SQL (aggregation + the queries powering the dashboard)
- Delta Lake (storage format, gives versioning for free)
- Databricks (notebooks + dashboard)

## Possible next steps

- Real-time/streaming version using Structured Streaming
- Replace fixed thresholds with statistical/ML-based anomaly detection
- Auto-correction for common mismatch patterns instead of just flagging them
- Scheduled Databricks jobs + alerting (email/Slack) so this actually runs on its own

---

The notebooks are numbered in the order they're meant to be run (01 through 06), since each one reads the Delta tables written by the previous one.
