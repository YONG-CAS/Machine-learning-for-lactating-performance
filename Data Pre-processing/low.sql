SELECT low.uid,low.`begin`,low.`end`,low.days,`dry milk`.time FROM low,`dry milk`
WHERE low.uid=`dry milk`.uid and 
`dry milk`.time BETWEEN low.`begin` AND low.`end`