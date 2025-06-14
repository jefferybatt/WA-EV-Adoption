Analyze EV adoption in WA counties using SQL to answer basic questions about total EVs, EV percentages, and trends.


-- Washington State EV Adoption Analysis
-- Dataset: Electric Vehicle Population Size History by County (data.wa.gov)

-- Query 1, Which WA counties have the most EVs?
-- Top 5 WA counties by total EVs
SELECT county, SUM(ev_total) AS total_evs
FROM ev_registration
WHERE state = 'WA'
GROUP BY county
ORDER BY total_evs DESC
LIMIT 5;

-- Query 2, Which WA counties have the highest percentage of EVs?
-- Top 5 WA counties by EV percentage
SELECT county, ROUND(AVG(percent_ev), 2) AS avg_percent_ev
FROM ev_registration
WHERE state = 'WA'
GROUP BY county
ORDER BY avg_percent_ev DESC
LIMIT 5;

-- Query 3, How has EV adoption in WA grown over time?
-- EV growth by year in WA
SELECT 
    EXTRACT(YEAR FROM registration_date) AS year,
    SUM(ev_total) AS total_evs,
    ROUND(AVG(percent_ev), 2) AS avg_percent_ev
FROM ev_registration
WHERE state = 'WA'
GROUP BY year
ORDER BY year;


-- Query 4, What is the breakdown of BEVs vs. PHEVs in WA?
-- BEV vs. PHEV breakdown in WA
SELECT 
    SUM(bev_count) AS total_bevs,
    SUM(phev_count) AS total_phevs,
    ROUND(SUM(bev_count) * 100.0 / SUM(ev_total), 2) AS bev_percent
FROM ev_registration
WHERE state = 'WA' AND ev_total > 0;

--Data Quality Check
-- Check for missing or zero values in WA data
SELECT 
    COUNT(*) AS total_wa_rows,
    COUNT(*) FILTER (WHERE ev_total = 0) AS zero_ev_rows,
    COUNT(*) FILTER (WHERE percent_ev IS NULL) AS null_percent_rows
FROM ev_registration
WHERE state = 'WA';

