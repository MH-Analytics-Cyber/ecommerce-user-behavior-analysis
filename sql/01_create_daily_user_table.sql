CREATE OR REPLACE TABLE `project-e18aaec6-9973-46fe-978.gacrp2.session_summary1` AS
SELECT
  fullVisitorId,
  visitId,
  visitNumber,
  date,
  totals.pageviews AS pageviews,
  totals.timeOnSite AS time_on_site,
  totals.bounces AS bounces,
  totals.transactionRevenue AS revenue,
  device.deviceCategory AS device,
  geoNetwork.country AS country,
  NULLIF(trafficSource.medium, '(none)') AS channel
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_20160801`;


CREATE OR REPLACE TABLE `project-e18aaec6-9973-46fe-978.gacrp2.events_summary1` AS
SELECT
  fullVisitorId,
  COUNT(*) AS event_count,
  STRING_AGG(DISTINCT hits.eventInfo.eventCategory, ',') AS event_categories,
  STRING_AGG(DISTINCT hits.eventInfo.eventAction, ',') AS event_actions
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_20160801`,
     UNNEST(hits) AS hits
WHERE hits.type = 'EVENT'
GROUP BY fullVisitorId;


CREATE OR REPLACE TABLE `project-e18aaec6-9973-46fe-978.gacrp2.user_summary1` AS
SELECT
  fullVisitorId,
  SUM(totals.transactionRevenue) AS total_revenue,
  COUNT(visitId) AS total_sessions
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_20160801`
GROUP BY fullVisitorId;


CREATE OR REPLACE TABLE `project-e18aaec6-9973-46fe-978.gacrp2.final_user_table1` AS
SELECT
  s.fullVisitorId,
  s.visitId,
  s.visitNumber,
  s.date,
  s.time_on_site,
  s.pageviews,
  s.bounces,
  s.device,
  s.country,
  s.channel,
  s.revenue,
  e.event_count,
  e.event_categories,
  e.event_actions,
  u.total_revenue,
  u.total_sessions
FROM `project-e18aaec6-9973-46fe-978.gacrp2.session_summary1` AS s
LEFT JOIN `project-e18aaec6-9973-46fe-978.gacrp2.events_summary1` AS e
  ON s.fullVisitorId = e.fullVisitorId
LEFT JOIN `project-e18aaec6-9973-46fe-978.gacrp2.user_summary1` AS u
  ON s.fullVisitorId = u.fullVisitorId;

