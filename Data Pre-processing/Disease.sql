SELECT i.uid,i.time,i.yield,ill.`day` FROM i,ill
		WHERE i.uid=ill.uid AND 
		i.time BETWEEN ill.`begin` 
		AND ill.`end`