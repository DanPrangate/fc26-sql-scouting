# FC26 Under-21 SQL Scouting Analysis

**Tool:** MySQL Workbench | **Language:** SQL | **Focus:** U21 Player Scouting & Squad Building

## Overview
An end-to-end SQL analytics project analysing FC26 player data to identify the highest-potential 
under-21 prospects across all positions. Built a custom potential scoring formula and produced 
four budget-tier Dream Team XIs with five-season development projections.

## Project Structure

| Step | Description |
|------|-------------|
| 1–2 | Database creation, table setup, data verification |
| 3–6 | Exploratory analysis — U21 players by overall, potential, and market value |
| 7 | Custom potential score formula applied across all U21 players |
| 8a–8i | Position-by-position candidate analysis (GK, CB, LB, RB, CDM, CAM, LW, RW, ST) |
| 9–12 | Four Dream Team XIs assembled across budget tiers |
| 13–16 | 5-season development projections (conservative & optimistic scenarios) |

## Potential Score Formula

```sql
(potential * 0.55) + ((potential - overall) * 0.45) AS potential_score
```

- **55% weight** on absolute potential ceiling
- **45% weight** on development room (gap between current and peak)
- Rewards both elite ceilings and high growth trajectories
- Limitation acknowledged: early developers (e.g. Pau Cubarsí, 82 overall at 18) 
  score lower despite being elite prospects — flagged in analyst notes

## Budget Tiers

| Team | Total Spend | Avg Season 5 Ceiling |
|------|-------------|----------------------|
| Best U21 XI (No Limit) | €289.9M | 88.5 |
| 100–150M Budget | €145.4M | 87.8 |
| 50–100M Budget | €99.5M | 87.0 |
| Moneyball 0–50M | €49.1M | 85.1 |

## Key Insight

> Spending 6x more (€289M vs €49M) only buys 3.4 extra overall points per player 
> at peak development. The U21 market heavily rewards smart scouting over financial power.

## Notable Picks

| Player | Position | Age | Potential | Cost | Why |
|--------|----------|-----|-----------|------|-----|
| R. Ngumoha | LW | 16 | 88 | €3.3M | Biggest development arc in dataset |
| J. Mokio | CDM | 17 | 89 | €3.8M | Best CDM development curve |
| F. Camarda | ST | 17 | 87 | €2.3M | Outstanding Moneyball value |
| Pablo García | RW | 16 | 87 | €3.1M | 'Yamal from Temu' — saves €143.9M vs Yamal |

## SQL Concepts Used
`WHERE` · `ORDER BY` · `LIMIT` · `LIKE` · `IN` · `LEAST()` · `Calculated columns` · 
`Multi-condition filtering` · `Position-based candidate ranking`

## Related Project
[This SQL analysis](https://github.com/DanPrangate/fc26-powerbi-dashboard)
