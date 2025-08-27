-- part of a query repo
-- query name: Agent DEX Volume
-- query link: https://dune.com/queries/5693808


WITH trade_data AS (
    SELECT
        MIN((CASE
            WHEN token_bought_symbol IN ('WETH','USDC','USDT','ETH','DAI') THEN token_sold_symbol
            WHEN token_bought_symbol IS NULL OR token_bought_symbol = '' OR LENGTH(token_bought_symbol) = 0 THEN cast(token_bought_address as varchar)
            ELSE token_bought_symbol
        END)) AS token,
        project_contract_address AS contract,
        COUNT(DISTINCT tx_hash) AS txs,
        SUM(amount_usd) AS volume
    FROM dex.trades
    WHERE 
        YEAR(block_date) >= 2025
        AND blockchain = 'base'
        AND amount_usd > 0 
        AND (token_bought_amount > 0 OR token_sold_amount > 0)
        AND tx_from = 0x999FB21A651cFbB4059C5d0c2fA561E9A6354999
    GROUP BY project_contract_address
)
SELECT token, contract, txs, volume
FROM trade_data
UNION ALL
SELECT 'Total' AS token, NULL AS contract, SUM(txs) AS txs, SUM(volume) AS volume
FROM trade_data
ORDER BY volume DESC;