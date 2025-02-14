-- Data Cleaning / Preprocessing

SELECT *
FROM cybersecurity_intrusion_data;

-- 1.Remove duplicates
-- 2.Standardizing data
-- 3.Null values and Missing values
-- 4.Remove columns and rows


CREATE TABLE `cybersecurity_intrusion_staging` (
  `session_id` text,
  `network_packet_size` int DEFAULT NULL,
  `protocol_type` text,
  `login_attempts` int DEFAULT NULL,
  `session_duration` double DEFAULT NULL,
  `encryption_used` text,
  `ip_reputation_score` double DEFAULT NULL,
  `failed_logins` int DEFAULT NULL,
  `browser_type` text,
  `unusual_time_access` int DEFAULT NULL,
  `attack_detected` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO cybersecurity_intrusion_staging
SELECT *,
ROW_NUMBER() OVER(PARTITION BY session_id, network_packet_size, protocol_type, login_attempts, session_duration, 
encryption_used, ip_reputation_score, failed_logins, browser_type,unusual_time_access, attack_detected) as row_num
FROM cybersecurity_intrusion_data;

SELECT *
FROM cybersecurity_intrusion_staging;

-- 1.Remove duplicates

SELECT *,
ROW_NUMBER() OVER(PARTITION BY session_id, network_packet_size, protocol_type, login_attempts, session_duration, 
encryption_used, ip_reputation_score, failed_logins, browser_type,unusual_time_access, attack_detected) as row_num
FROM cybersecurity_intrusion_data;

WITH duplicates AS (
    SELECT *,
        ROW_NUMBER() OVER(PARTITION BY session_id, network_packet_size, protocol_type, login_attempts, session_duration, 
        encryption_used, ip_reputation_score, failed_logins, browser_type, unusual_time_access, attack_detected) AS row_num
    FROM cybersecurity_intrusion_data
)
SELECT * 
FROM duplicates 
WHERE row_num > 1;

-- 2.Standardizing data
SELECT *
FROM cybersecurity_intrusion_staging;

SELECT session_id, CAST(ip_reputation_score AS DECIMAL(10,2)) AS formatted_score
FROM cybersecurity_intrusion_staging;

UPDATE cybersecurity_intrusion_staging
SET ip_reputation_score = CAST(ip_reputation_score AS DECIMAL(10,2));

SELECT session_id, ip_reputation_score FROM cybersecurity_intrusion_staging;

ALTER TABLE cybersecurity_intrusion_staging
MODIFY COLUMN ip_reputation_score DECIMAL(10,2);

SELECT session_id, CAST(session_duration AS DECIMAL(10,2)) AS formatted_score
FROM cybersecurity_intrusion_staging;

UPDATE cybersecurity_intrusion_staging
SET session_duration = CAST(session_duration AS DECIMAL(10,2));

ALTER TABLE cybersecurity_intrusion_staging
MODIFY COLUMN session_duration DECIMAL(10,2);


-- 3.Null values and Missing values
SELECT * 
FROM cybersecurity_intrusion_staging
WHERE session_id IS NULL 
   OR network_packet_size IS NULL
   OR protocol_type IS NULL
   OR login_attempts IS NULL
   OR session_duration IS NULL
   OR encryption_used IS NULL
   OR ip_reputation_score IS NULL
   OR failed_logins IS NULL
   OR browser_type IS NULL
   OR unusual_time_access IS NULL
   OR attack_detected IS NULL;

SELECT COUNT(*) AS null_count
FROM cybersecurity_intrusion_staging
WHERE encryption_used IS NULL;

UPDATE cybersecurity_intrusion_staging
SET encryption_used = "N/A"
WHERE encryption_used = "None";
   
-- 4.Remove columns and rows
SELECT *
FROM cybersecurity_intrusion_staging;

ALTER TABLE cybersecurity_intrusion_staging
DROP COLUMN row_num;

