-- part of a query repo
-- query name: Agent Contracts Deployed
-- query link: https://dune.com/queries/5693890


SELECT
    COUNT(*) AS total_count
FROM sepolia.traces AS t
WHERE block_time >= CAST(NOW() AS DATE) - INTERVAL '1' year
   AND block_time < DATE_TRUNC('month', NOW())
   AND type = 'create'
   AND tx_success = true
   AND tx_from = 0x999FB21A651cFbB4059C5d0c2fA561E9A6354999;