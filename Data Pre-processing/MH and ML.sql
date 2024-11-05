SELECT i.uid,i.time,i.yield FROM i,`high low`
		WHERE i.uid=`high low`.uid AND 
		i.time BETWEEN `high low`.`begin` 
		AND `high low`.`end`