-- Exploratory Data Analysis

SELECT *
FROM cybersecurity_intrusion_staging;

-- Total Count of Sessions
SELECT COUNT(*) AS total_sessions 
FROM cybersecurity_intrusion_staging;

-- Basic Statistics of Session Duration
SELECT MIN(session_duration), 
	MAX(session_duration), 
    AVG(session_duration)
FROM cybersecurity_intrusion_staging;

-- Basic Statistics of IP Reputation Score
SELECT MIN(ip_reputation_score), 
	MAX(ip_reputation_score), 
	AVG(ip_reputation_score)
FROM cybersecurity_intrusion_staging;

-- Basic Statistics of Network Packet Size
SELECT MIN(network_packet_size), 
	MAX(network_packet_size), 
    AVG(network_packet_size)
FROM cybersecurity_intrusion_staging;


-- Most Common Browser
SELECT browser_type, 
	COUNT(*) AS count 
FROM cybersecurity_intrusion_staging
GROUP BY browser_type
ORDER BY count DESC;

-- Browser with the Most Failed Attempts
SELECT browser_type, 
	COUNT(attack_detected) AS count_attack
FROM cybersecurity_intrusion_staging
WHERE attack_detected = 1
GROUP BY browser_type
ORDER BY count_attack DESC;

-- Most Targeted Browser
SELECT browser_type, 
	COUNT(failed_logins) AS failed_logins
FROM cybersecurity_intrusion_staging
WHERE failed_logins > 0
GROUP BY browser_type
ORDER BY failed_logins DESC;

-- Browser with a High IP Reputation Score
SELECT browser_type, 
	AVG(ip_reputation_score) AS avg_ip_score
FROM cybersecurity_intrusion_staging
GROUP BY browser_type
ORDER BY avg_ip_score DESC;

-- Most Targeted Protocol Type
SELECT protocol_type, 
	COUNT(attack_detected) AS count_attack
FROM cybersecurity_intrusion_staging
WHERE attack_detected = 1
GROUP BY protocol_type
ORDER BY count_attack DESC;

-- Percentage of sessions that had an attack
SELECT COUNT(*) as count, 
	SUM(attack_detected) AS total_attack, 
    (SUM(attack_detected) * 100 / COUNT(*)) AS attack_percentage
FROM cybersecurity_intrusion_staging;


SELECT *
FROM cybersecurity_intrusion_staging;


--  Most Frequent Attack-Related Patterns
SELECT protocol_type, 
	encryption_used, 
    browser_type, 
    SUM(attack_detected) AS total_attacks
FROM cybersecurity_intrusion_staging
GROUP BY protocol_type, encryption_used, browser_type
ORDER BY total_attacks DESC
LIMIT 5;

-- Compare protocol types used in attacked vs. non-attacked sessions
SELECT protocol_type,
	SUM(attack_detected) AS total_attacks,
    (SUM(attack_detected) * 100 / COUNT(*)) AS attack_rate
FROM cybersecurity_intrusion_staging
GROUP BY protocol_type
ORDER BY attack_rate DESC;

-- Compare Session Durations Based on Failed Logins
WITH avg_session AS (
	SELECT AVG(session_duration) AS avg_duration
    FROM cybersecurity_intrusion_staging
)
SELECT 
	CASE
		WHEN c.session_duration < a.avg_duration THEN 'Below Average Session Duration'
        ELSE 'Above Average Session Duration'
	END AS session_category,
    COUNT(*) AS total_sessions,
    AVG(failed_logins) AS avg_failed_logins,
    SUM(attack_detected) AS total_attacks,
    (SUM(attack_detected) * 100 / COUNT(*)) AS attack_rate
FROM cybersecurity_intrusion_staging c
JOIN avg_session a ON 1=1
GROUP BY session_category
ORDER BY attack_rate DESC;

-- Analyzing Attack Rates Based on IP Reputation Scores
WITH avg_score AS (
	SELECT AVG(ip_reputation_score) AS avg_reputation_score
    FROM cybersecurity_intrusion_staging
)
SELECT 
	CASE
		WHEN c.ip_reputation_score < a.avg_reputation_score THEN 'Below Average IP Score'
        ELSE 'Above Average IP Score'
	END AS reputation_score,
    COUNT(*) AS total_sessions,
    AVG(ip_reputation_score) AS avg_reputation_score,
    SUM(attack_detected) AS total_attacks,
    (SUM(attack_detected) * 100 / COUNT(*)) AS attack_rate
FROM cybersecurity_intrusion_staging c
JOIN avg_score a ON 1=1
GROUP BY reputation_score
ORDER BY attack_rate DESC;

-- Detecting Suspiciously Long Sessions with Low Failed Logins
WITH avg_session AS (
	SELECT AVG(session_duration) AS avg_duration
    FROM cybersecurity_intrusion_staging
)
SELECT 
	CASE
		WHEN c.session_duration < a.avg_duration THEN 'Below Average Session Duration'
        ELSE 'Above Average Session Duration'
	END AS session_category,
    COUNT(*) AS total_sessions,
    AVG(failed_logins) AS avg_failed_logins,
    AVG(ip_reputation_score) AS avg_ip_score
FROM cybersecurity_intrusion_staging c 
JOIN avg_session a ON 1=1
WHERE failed_logins <= 1
GROUP BY session_category
ORDER BY avg_ip_score ASC;



