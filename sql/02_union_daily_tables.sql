-- 8/1～8/8の日別ユーザーテーブルを統合し、
-- 分析用のベーステーブルを作成する

CREATE OR REPLACE TABLE `project-e18aaec6-9973-46fe-978.gacrp2.gas_portfolio` AS
SELECT * FROM `project-e18aaec6-9973-46fe-978.gacrp2.final_user_table1`
UNION ALL
SELECT * FROM `project-e18aaec6-9973-46fe-978.gacrp2.final_user_table2`
UNION ALL
SELECT * FROM `project-e18aaec6-9973-46fe-978.gacrp2.final_user_table3`
UNION ALL
SELECT * FROM `project-e18aaec6-9973-46fe-978.gacrp2.final_user_table4`
UNION ALL
SELECT * FROM `project-e18aaec6-9973-46fe-978.gacrp2.final_user_table5`
UNION ALL
SELECT * FROM `project-e18aaec6-9973-46fe-978.gacrp2.final_user_table6`
UNION ALL
SELECT * FROM `project-e18aaec6-9973-46fe-978.gacrp2.final_user_table7`
UNION ALL
SELECT * FROM `project-e18aaec6-9973-46fe-978.gacrp2.final_user_table8`;