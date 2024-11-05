SELECT * FROM a
WHERE NOT EXISTS(
				SELECT * FROM  `low colostrum high` WHERE a.uid=`low colostrum high`.uid AND a.time=`low colostrum high`.time)
