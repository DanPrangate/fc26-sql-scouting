-- FC26 Young Players Analysis
-- Project by: Dan Prangate
-- Date: June 2026

-- STEP 1: Create database and table

CREATE DATABASE fc26_project;
USE fc26_project;

CREATE TABLE players (
    player_id INT PRIMARY KEY,
    short_name VARCHAR(100),
    player_positions VARCHAR(100),
    overall INT,
    potential INT,
    value_eur BIGINT,
    age INT
);

-- STEP 2: Verify data imported correctly

SELECT COUNT(*) FROM players;
SELECT * FROM players LIMIT 10;

-- STEP 3: Explore young players (under 21)

SELECT * 
FROM players
WHERE age <= 21
ORDER BY potential DESC
LIMIT 50;
 
-- STEP 4: Top 20 under-21 by overall

SELECT player_id, short_name, player_positions, age, overall, potential
FROM players
WHERE age <= 21
ORDER BY overall DESC
LIMIT 20;
 
-- STEP 5: Top 20 under-21 by potential

SELECT player_id, short_name, player_positions, age, overall, potential
FROM players
WHERE age <= 21
ORDER BY potential DESC
LIMIT 20;

-- STEP 6: Top 20 under-21 by value_eur

SELECT player_id, short_name, player_positions, age, overall, potential, value_eur
FROM players
WHERE age <= 21
ORDER BY value_eur DESC
LIMIT 20;

-- STEP 7: Calculate potential score for all under-21 players

SELECT player_id,short_name,player_positions,age,overall,potential,value_eur,
(potential * 0.55) + ((potential - overall) * 0.45) AS potential_score
FROM players
WHERE age <= 21
ORDER BY potential_score DESC
LIMIT 50;

-- STEP 8a: Top 5 ST candidates by potential score

SELECT player_id,short_name,player_positions,age,overall,potential,value_eur,
(potential * 0.55) + ((potential - overall) * 0.45) AS potential_score
FROM players
WHERE age <= 21
    AND player_positions LIKE '%ST%'
ORDER BY potential_score DESC
LIMIT 10;

-- Analyst note: Endrick preferred for higher budget teams (potential 91, value 24.5M)
-- Camarda preferred for budget teams (potential 87, value 2.3M - outstanding value)

-- STEP 8b: Top 5 CAM candidates by potential score

SELECT player_id,short_name,player_positions,age,overall,potential,value_eur,
(potential * 0.55) + ((potential - overall) * 0.45) AS potential_score
FROM players
WHERE age <= 21
    AND player_positions LIKE '%CAM%'
ORDER BY potential_score DESC
LIMIT 10;

-- STEP 8c: Top 5 LW candidates by potential score

SELECT player_id,short_name,player_positions,age,overall,potential,value_eur,
(potential * 0.55) + ((potential - overall) * 0.45) AS potential_score
FROM players
WHERE age <= 21
    AND player_positions LIKE '%LW%'
ORDER BY potential_score DESC
LIMIT 10;

-- STEP 8d: Top 5 RW candidates by potential score

SELECT player_id,short_name,player_positions,age,overall,potential,value_eur,
(potential * 0.55) + ((potential - overall) * 0.45) AS potential_score
FROM players
WHERE age <= 21
    AND player_positions LIKE '%RW%'
ORDER BY potential_score DESC
LIMIT 10;

-- STEP 8e: Top 5 CDM candidates by potential score

SELECT player_id,short_name,player_positions,age,overall,potential,value_eur,
(potential * 0.55) + ((potential - overall) * 0.45) AS potential_score
FROM players
WHERE age <= 21
    AND player_positions LIKE '%CDM%'
ORDER BY potential_score DESC
LIMIT 10;

-- STEP 8f: Top 5 LB candidates by potential score

SELECT player_id,short_name,player_positions,age,overall,potential,value_eur,
(potential * 0.55) + ((potential - overall) * 0.45) AS potential_score
FROM players
WHERE age <= 21
    AND player_positions LIKE '%LB%'
ORDER BY potential_score DESC
LIMIT 10;

-- STEP 8g: Top 5 RB candidates by potential score

SELECT player_id,short_name,player_positions,age,overall,potential,value_eur,
(potential * 0.55) + ((potential - overall) * 0.45) AS potential_score
FROM players
WHERE age <= 21
    AND player_positions LIKE '%RB%'
ORDER BY potential_score DESC
LIMIT 10;

-- STEP 8h: Top 5 CB candidates by potential score

SELECT player_id,short_name,player_positions,age,overall,potential,value_eur,
(potential * 0.55) + ((potential - overall) * 0.45) AS potential_score
FROM players
WHERE age <= 21
    AND player_positions LIKE '%CB%'
ORDER BY potential_score DESC
LIMIT 10;

SELECT player_id, short_name, player_positions, age, overall, potential, value_eur,
    (potential * 0.55) + ((potential - overall) * 0.45) AS potential_score
FROM players
WHERE short_name LIKE '%Cubbar%'
    OR short_name LIKE '%Cubbasi%'
    OR short_name LIKE '%Cubar%';
    
-- Analyst note: Formula limitation  players who developed early (e.g. Pau Cubarsí, 
-- overall 82 at age 18) score lower despite being elite prospects, because 
-- room to grow (potential - overall) is small. For budget teams this is less 
-- relevant but for best XI selection Cubarsí deserves manual consideration.

-- STEP 8i: Top 5 GK candidates by potential score

SELECT player_id,short_name,player_positions,age,overall,potential,value_eur,
(potential * 0.55) + ((potential - overall) * 0.45) AS potential_score
FROM players
WHERE age <= 21
    AND player_positions LIKE '%GK%'
ORDER BY potential_score DESC
LIMIT 10;

-- Analyst note: Using flexible position matching (%position%) 
-- to capture players who can play a position even if not their primary role
-- Position conflicts to resolve in final XI selection:
-- Endrick listed in both ST and RW candidates
-- Pablo García listed in both RW and ST candidates
-- GK position: D. Seimen retained across all budget teams
-- No better U21 GK candidate available with higher potential score
-- Seimen represents best value at position regardless of budget
  
-- STEP 9: Final Dream Team XI - Best Potential
-- (No budget limit)

SELECT
    player_id,
    short_name,
    player_positions,
    age,
    overall,
    potential,
    value_eur,
    (potential * 0.55) + ((potential - overall) * 0.45) AS potential_score
FROM players
WHERE player_id IN (
    271114,  -- D. Seimen  GK
    271266,  -- G. Read    RB
	278780,  -- F. Jeltsch CB
    275192,  -- L. Vukovic CB
    272978,  -- J. Hato    LB
    71351,   -- J. Mokio   CDM
    275411,  -- T. Land    CDM
    80376,   -- R. Ngumoha LW
    72997,  -- Rodrigo Mora CAM
    277643,  -- Lamine Yamal RW
    272505   -- Endrick    ST
)
ORDER BY potential_score DESC;

-- Team selected based on potential score formula:
-- (potential * 0.55) + ((potential - overall) * 0.45)
-- Priority: future development over current ability
-- Notable picks: Ngumoha (16yo), Mokio (17yo)  highest development ceiling
-- Formula limitation acknowledged: early developers like Cubarsí  score lower despite elite current ability


-- STEP 10: Dream Team XI - Budget 100-150M

-- Total cost: 145,400,000€
-- Change from best XI: Yamal (147M) → Pablo García 'Yamal from Temu' (3.1M)
-- Saves 143.9M while maintaining 87 potential at RW

SELECT player_id,short_name,player_positions,age,overall,potential,value_eur,
(potential * 0.55) + ((potential - overall) * 0.45) AS potential_score
FROM players
WHERE player_id IN (
    271114,  -- D. Seimen     GK
    271266,  -- G. Read       RB
    278780,  -- F. Jeltsch    CB
    275192,  -- L. Vukovic    CB
    272978,  -- J. Hato       LB
    71351,   -- J. Mokio      CDM
    275411,  -- T. Land       CDM
    80376,   -- R. Ngumoha    LW
    72997,   -- Rodrigo Mora  CAM
    76739,   -- Pablo García  RW
    272505   -- Endrick       ST
)
ORDER BY potential_score DESC;

-- Note: Some player names display without accents (e.g. 'Pablo Garca' = Pablo García)
-- due to special character encoding during CSV import

-- STEP 11: Dream Team XI - Budget 50-100M

-- Total cost: 99,500,000€
-- Changes from 150M team:
-- Hato (29M) → J. Seys (7M) at LB
-- G. Read (13M) → João Costa (4.5M) at RB
-- Jeltsch (5M) → Pau Navarro (3.6M) at CB
-- Rodrigo Mora (17.5M) → S. Nypan (3.5M) at CAM

SELECT player_id,short_name,player_positions,age,overall,potential,value_eur,
(potential * 0.55) + ((potential - overall) * 0.45) AS potential_score
FROM players
WHERE player_id IN (
    271114,  -- D. Seimen     GK
    278567,  -- João Costa    RB
    278659,  -- Pau Navarro   CB
    275192,  -- L. Vukovic    CB
    71305,   -- J. Seys       LB
    71351,   -- J. Mokio      CDM
    275411,  -- T. Land       CDM
    80376,   -- R. Ngumoha    LW
    268737,  -- S. Nypan      CAM
    76739,   -- Pablo García  RW
    272505   -- Endrick       ST
)
ORDER BY potential_score DESC;


-- STEP 12: Dream Team XI - Moneyball 25-50M

-- Total cost: 49,100,000€
-- Philosophy: maximum potential score, minimum spend
-- Average potential: 85 across all positions
-- True hidden gems - nobody over 70 overall today

SELECT
    player_id,
    short_name,
    player_positions,
    age,
    overall,
    potential,
    value_eur,
    (potential * 0.55) + ((potential - overall) * 0.45) AS potential_score
FROM players
WHERE player_id IN (
    271114,  -- D. Seimen     GK
    76125,   -- C. Donovan    RB
    71350,   -- J. Gadou      CB
    278659,  -- Pau Navarro   CB
    74142,   -- D. Len        LB
    71997,   -- K. Dyer       CDM
    73921,   -- N. De Cat     CDM
    72419,   -- J. Lerma      LW
    268737,  -- S. Nypan      CAM
    76739,   -- Pablo García  RW
    279202   -- F. Camarda    ST
)
ORDER BY potential_score DESC;


-- STEP 13: 5 Season Projection Conservative Approach (+4 per season)- Best XI

SELECT
    short_name,
    player_positions,
    age,
    overall AS current,
    LEAST(overall + 4,  potential) AS season_1,
    LEAST(overall + 8,  potential) AS season_2,
    LEAST(overall + 12, potential) AS season_3,
    LEAST(overall + 16, potential) AS season_4,
    LEAST(overall + 20, potential) AS season_5,
    potential AS ceiling
FROM players
WHERE player_id IN (
    271114,  -- D. Seimen     GK
    271266,  -- G. Read       RB
    278780,  -- F. Jeltsch    CB
    275192,  -- L. Vukovic    CB
    272978,  -- J. Hato       LB
    71351,   -- J. Mokio      CDM
    275411,  -- T. Land       CDM
    80376,   -- R. Ngumoha    LW
    72997,   -- Rodrigo Mora  CAM
    277643,  -- Lamine Yamal  RW
    272505   -- Endrick       ST
)
ORDER BY potential DESC;

-- Optimistic scenario (+5 per season)

SELECT
    short_name,
    overall AS current,
    LEAST(overall + 5,  potential) AS season_1,
    LEAST(overall + 10, potential) AS season_2,
    LEAST(overall + 15, potential) AS season_3,
    LEAST(overall + 20, potential) AS season_4,
    LEAST(overall + 25, potential) AS season_5,
    potential AS ceiling
FROM players
WHERE player_id IN (
    271114, 271266, 278780, 275192,
    272978, 71351,  275411, 80376,
    72997,  277643, 272505
)
ORDER BY potential DESC;

-- ================================================
-- STEP 13 ANALYST NOTES: 5 Season Projections
-- ================================================

-- CONSERVATIVE SCENARIO (+4 per season)
-- Assumes regular starts, good form, no injuries
-- Lamine Yamal: reaches ceiling (95) by season 2 - generational talent
--               already operating near peak level at just 17
-- Endrick: peaks at 91 by season 4 - slow burn but elite ceiling
--          most complete striker in the team long term
-- R. Ngumoha: biggest development arc in the team (68 → 88)
--             signed for just 3.3M - outstanding scouting value
-- J. Mokio: 70 → 89 over 5 seasons - best CDM development curve
--           cheapest elite midfielder in the dataset at 3.8M
-- D. Seimen: honest ceiling of 84 - solid but not world class
--            GK position weakness acknowledged in this XI

-- OPTIMISTIC SCENARIO (+5 per season)
-- Assumes Development Plan activated, elite training staff
-- consistent starting XI, high morale throughout
-- Key difference vs conservative:
-- Players hit their potential ceiling 1 season earlier
-- Ngumoha and Mokio reach near-elite status by season 4
-- instead of season 5
-- Endrick hits 91 ceiling in season 4 vs season 5 conservative

-- OVERALL PROJECTION INSIGHT:
-- This XI transforms from average overall 74 today
-- to average overall 89 within 5 seasons
-- Total market value expected to increase 10-15x
-- Best value picks: Ngumoha (3.3M), Mokio (3.8M), Camarda (2.3M)
-- These three alone could be worth 50M+ at peak


-- STEP 14: 5 Season Projection - Budget 150-200M
-- Conservative (+4 per season)
-- NOTE: Only conservative scenario (+4 per season) used for budget teams
-- Optimistic scenario shown for Best XI as reference only
-- Conservative chosen as base case for realism:
-- accounts for injuries, suspensions, poor form periods
-- and inconsistent playing time across a full season

SELECT
    short_name,
    overall AS current,
    LEAST(overall + 4,  potential) AS season_1,
    LEAST(overall + 8,  potential) AS season_2,
    LEAST(overall + 12, potential) AS season_3,
    LEAST(overall + 16, potential) AS season_4,
    LEAST(overall + 20, potential) AS season_5,
    potential AS ceiling
FROM players
WHERE player_id IN (
    271114,  -- D. Seimen     GK
    271266,  -- G. Read       RB
    278780,  -- F. Jeltsch    CB
    275192,  -- L. Vukovic    CB
    272978,  -- J. Hato       LB
    71351,   -- J. Mokio      CDM
    275411,  -- T. Land       CDM
    80376,   -- R. Ngumoha    LW
    72997,   -- Rodrigo Mora  CAM
    76739,   -- Pablo García  RW
    272505   -- Endrick       ST
)
ORDER BY potential DESC;

-- ================================================
-- STEP 15: 5 Season Projection - Budget 50-100M
-- ================================================

-- Conservative (+4 per season)
SELECT
    short_name,
    overall AS current,
    LEAST(overall + 4,  potential) AS season_1,
    LEAST(overall + 8,  potential) AS season_2,
    LEAST(overall + 12, potential) AS season_3,
    LEAST(overall + 16, potential) AS season_4,
    LEAST(overall + 20, potential) AS season_5,
    potential AS ceiling
FROM players
WHERE player_id IN (
    271114,  -- D. Seimen     GK
    278567,  -- João Costa    RB
    278659,  -- Pau Navarro   CB
    275192,  -- L. Vukovic    CB
    71305,   -- J. Seys       LB
    71351,   -- J. Mokio      CDM
    275411,  -- T. Land       CDM
    80376,   -- R. Ngumoha    LW
    268737,  -- S. Nypan      CAM
    76739,   -- Pablo García  RW
    272505   -- Endrick       ST
)
ORDER BY potential DESC;

-- INSIGHT: 50-100M team develops almost identically to 150-200M team
-- Average ceiling difference of just 1 overall point
-- Suggests diminishing returns on spending for U21 players
-- Smart scouting > big budget at this age group

-- ================================================
-- STEP 16: 5 Season Projection - Moneyball 25-50M
-- ================================================

-- Conservative (+4 per season)
SELECT
    short_name,
    overall AS current,
    LEAST(overall + 4,  potential) AS season_1,
    LEAST(overall + 8,  potential) AS season_2,
    LEAST(overall + 12, potential) AS season_3,
    LEAST(overall + 16, potential) AS season_4,
    LEAST(overall + 20, potential) AS season_5,
    potential AS ceiling
FROM players
WHERE player_id IN (
    271114,  -- D. Seimen     GK
    76125,   -- C. Donovan    RB
    71350,   -- J. Gadou      CB
    278659,  -- Pau Navarro   CB
    74142,   -- D. Len        LB
    71997,   -- K. Dyer       CDM
    73921,   -- N. De Cat     CDM
    72419,   -- J. Lerma      LW
    268737,  -- S. Nypan      CAM
    76739,   -- Pablo García  RW
    279202   -- F. Camarda    ST
)
ORDER BY potential DESC;

ALTER TABLE players ADD PRIMARY KEY (player_id);

-- ================================================
-- FINAL PROJECT INSIGHT
-- ================================================
-- Total spend comparison vs average ceiling at season 5:
-- Best XI    289M → avg ceiling 88.5
-- 150-200M   145M → avg ceiling 87.8
-- 50-100M     99M → avg ceiling 87.0
-- Moneyball   49M → avg ceiling 85.1
--
-- Spending 6x more (289M vs 49M) only buys 3.4 extra
-- overall points per player at peak
-- Conclusion: U21 market heavily rewards smart scouting
-- over financial power
