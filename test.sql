WITH daily_session_duration AS (
SELECT load.user_id,
DATE (load.timestamp) AS date,
MIN (exit.timestamp) - MAX (load.timestamp) AS session_duration
FROM facebook_web_log AS load
INNER JOIN facebook_web_log AS exit
ON load.user_id = exit.user_id
WHERE load.action = 'page_load'
AND exit.action = 'page_exit'
AND exit.timestamp > load.timestamp
GROUP BY load.user_id, date
)
SELECT user_id,
AVG (session_duration)
FROM daily_session_duration
GROUP BY user_id