SELECT i.uid,i.time,i.yield FROM i,z
		WHERE i.uid=z.uid AND 
		i.time BETWEEN z.`begin` 
		AND z.`end`