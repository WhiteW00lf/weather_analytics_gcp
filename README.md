# Weather Analytics Warehouse (GCP + dbt)

## Overview
This project demonstrates how to build a reliable, warehouse-first data platform on Google Cloud Platform using BigQuery and dbt.

The focus is on data engineering fundamentals:
- Clear data ownership boundaries
- Deterministic transformations
- Data quality contracts
- Reproducibility and trust

This is not a dashboard or BI project.

---

## Problem Statement
Raw data ingested into data warehouses is often:
- Untyped
- Inconsistent
- Prone to silent corruption

Downstream users (analysts, data scientists, applications) need:
- Stable schemas
- Clear guarantees
- One authoritative source of truth

This project solves that by building a contract-driven analytics warehouse.

---

## Architecture (High Level)

Cloud Storage  
→ BigQuery (Raw Table)  
→ dbt Staging (Typed, Validated)  
→ dbt Canonical Fact Table

Each layer has a single responsibility and explicit ownership.

---

## Data Layers

### 1. Raw Layer (BigQuery)
- Dataset: weather_analytics
- Table: weather
- Characteristics:
  - Append-only
  - No transformations
  - Immutable historical record

Raw data is treated as untrusted input.

---

### 2. Source Contracts (dbt)
Raw data is declared using sources.yml with:
- Explicit dataset and table mapping
- Freshness checks
- Ownership boundaries

This allows early detection of ingestion failures before downstream processing.

---

### 3. Staging Layer (stg_weather)
Purpose:
- Explicit typing
- Canonical column naming
- Structural validation

What staging does:
- Casts data to correct types
- Renames columns consistently

What staging does not do:
- No aggregations
- No business logic
- No assumptions

---

### 4. Canonical Fact Table (fct_daily_weather)
Grain:
- One row per city per day

Purpose:
- Provide a stable, analytics-ready dataset
- Serve as the single source of truth for daily weather data
- Absorb upstream schema or ingestion changes safely

---

## Data Quality and Contracts
Data quality is enforced using dbt tests at every layer:
- not_null checks on critical columns
- Source freshness monitoring
- Layer-specific ownership of tests

If a test fails:
- The pipeline fails
- Downstream consumers are protected
- Bad data does not propagate silently

---

## How This Runs in Production
Daily execution flow:
1. Raw data is ingested into BigQuery
2. dbt source freshness validates ingestion health
3. dbt run builds staging and fact models
4. dbt test enforces data contracts
5. Canonical fact table is published for consumption

dbt is used as a reliability and transformation layer, not as an orchestrator.

---

## What This Project Does Not Cover
This project intentionally does not include:
- Incremental models
- Late-arriving data handling
- Streaming ingestion
- Orchestration (Airflow or Scheduler)
- Dashboards or BI tools

These topics are deferred to subsequent projects.

---

## Key Engineering Principles Demonstrated
- Warehouse-first design
- Clear data ownership boundaries
- Contract-driven transformations
- Deterministic and reproducible builds
- Separation of ingestion, transformation, and consumption

---

## Tech Stack
- Google BigQuery
- dbt (BigQuery adapter)
- Python (virtual environment)
- Git for version control

---

## Outcome
This project delivers a trustworthy analytics warehouse that downstream teams can rely on without re-implementing logic or validation.

It represents foundational Data Engineering work, not exploratory analytics.
