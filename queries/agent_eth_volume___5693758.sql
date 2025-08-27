-- part of a query repo
-- query name: Agent ETH Volume
-- query link: https://dune.com/queries/5693758


SELECT
    0x999FB21A651cFbB4059C5d0c2fA561E9A6354999 as address,
    SUM(CASE WHEN "from" = 0x999FB21A651cFbB4059C5d0c2fA561E9A6354999 THEN value_decimal ELSE 0 END) as eth_sent,
    SUM(CASE WHEN "to" = 0x999FB21A651cFbB4059C5d0c2fA561E9A6354999 THEN value_decimal ELSE 0 END) as eth_received,
    SUM(value_decimal) as total_eth_volume,
    COUNT(*) as total_transactions
FROM transfers_base.eth 
WHERE ("from" = 0x999FB21A651cFbB4059C5d0c2fA561E9A6354999 OR "to" = 0x999FB21A651cFbB4059C5d0c2fA561E9A6354999)
    AND tx_block_time >= NOW() - INTERVAL '12' MONTH