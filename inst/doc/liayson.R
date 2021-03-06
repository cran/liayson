### R code from vignette source 'liayson.Rnw'

###################################################
### code chunk number 1: liayson.Rnw:30-48
###################################################
library(liayson)
## Load data and map genes onto segments
data(epg)
data(segments)
X=aggregateSegmentExpression(epg, segments, mingps=20, GRCh=38)
if(is.null(X)){
	print("BiomaRt Web service for annotation of gene locations is not available. Using pre-calculated matrix of copy number states")
	data(cnps)
}else{
	head(X$eps[,1:3]); ##Aggregate expression of first three cells
	## Calculate number of expressed genes per cell
	data(epg)
	gpc = apply(epg>0, 2, sum)
	## Calculate copy number from expression
	cn=segments[rownames(X$eps),"CN_Estimate"]
	cnps = segmentExpression2CopyNumber(X$eps, gpc, cn, nCores=1)
}
head(cnps[,1:3]); ##Copy number of first three cells


###################################################
### code chunk number 2: liayson.Rnw:53-54
###################################################
outc = clusterCells(cnps, h=0.05)


