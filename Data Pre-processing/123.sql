SELECT z.uid,z.time,z.yield,k.`begin`,k.births,k.frequency FROM z,k
    WHERE z.uid=k.uid AND 
		z.time BETWEEN k.`begin`
		AND k.`end`