SELECT a.uid,a.time,a.yield,k.births,k.frequency FROM a,k
    WHERE a.uid=k.uid AND 
		a.time BETWEEN k.`begin`
		AND k.`end`