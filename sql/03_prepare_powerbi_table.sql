-- Power BIでの分析に使用する最終テーブルを作成
--
-- 主な処理:
-- 1. 売上の有無からユーザーを buyer / non_buyer に分類
-- 2. 複数格納されている event_actions を分割
-- 3. UNNESTを使用してイベントを行単位に展開

CREATE OR REPLACE TABLE `project-e18aaec6-9973-46fe-978.gacrp2.gas_portfolio2` AS

WITH user_flag AS (
  SELECT
    fullVisitorId,
    CASE
      WHEN MAX(total_revenue) > 0 THEN "buyer"
      ELSE "non_buyer"
    END AS user_type
  FROM `project-e18aaec6-9973-46fe-978.gacrp2.gas_portfolio`
  GROUP BY fullVisitorId
),

base AS (
  SELECT
    g.*,
    SPLIT(COALESCE(g.event_actions, ''), ',') AS action_array
  FROM `project-e18aaec6-9973-46fe-978.gacrp2.gas_portfolio` AS g
)

SELECT
  g.fullVisitorId,
  g.visitId,
  g.visitNumber,
  g.date,
  g.device,
  g.channel,
  g.country,
  g.pageviews,
  g.time_on_site,
  g.total_sessions,
  g.total_revenue,
  g.revenue,

  NULLIF(TRIM(action), '') AS event_actions,

  g.event_categories,

  g.event_count,
  g.bounces,
  u.user_type

FROM base AS g

JOIN user_flag AS u
  ON g.fullVisitorId = u.fullVisitorId

CROSS JOIN UNNEST(g.action_array) AS action;