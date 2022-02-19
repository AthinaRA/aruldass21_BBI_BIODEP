# Athina Aruldass - Aug 2021 - Aruldass et al. (2021) BBI
# R version 3.6.0 (2019-04-26)

################### FIG. 3A (correlation matrix) #######################################

#yeo_name : read.delim Yeo_hcp.txt
#roi.hcp  : read.csv FCmatsROIorder_glasser.txt (header=T, sep = "")


install.packages("wesanderson")
library(wesanderson)
install.packages("pheatmap")
library(pheatmap)


### heatmap for cells, cyto, beh for N = 36 
dat1 = cells.allMDD36[ , 3:14]  #cells
head(dat1)
dat2 = dfCyto_andCells36AllMDD[ , c(3:19, 25:29)]  #cyto
head(dat2)
dat3 = behdemo36[ , 3:12]

# corr heatmap with all 3 variables 
cytocells36_beh = cbind(dat1, dat2, dat3)  #make full df
head(cytocells36_beh)
colnames(cytocells36_beh) = c("Basophils", "Eosinophils", "Neutrophils", "Mono (class)", "Mono (nonclass)",
                              "Mono (int)", "CD4+ T-cells", "CD8+ T-cells", "B-cells", "CD16_hi NK cells",
                              "CD56_hi NK cells", "NKT cells" ,"Eotaxin", "IL10", "IL12", "IL15", "IL16", "IL6", "IL7", "IL8",
                              "IP10", "MCP-1", "MCP-4", "MDC", "MIP-1b", "TARC", "TNFa", "VEGF-A", "CRP", "PC1",
                              "PC2","PC3", "PC4", "PC5", "HAM-D (17-items)",
                              "BDI-II", "SHAPS", "CFS", "S-STAI", "T-STAI", "CTQ", "PSS", "LEQ (score)", 
                              "LEQ (rating)")
col_order = c("CRP", "IL6", "Eotaxin", "IL10", "IL12", "IL15", "IL16", "IL7", "IL8",
              "IP10", "MCP-1", "MCP-4", "MDC", "MIP-1b", "TARC", "TNFa", "VEGF-A", "PC1",
              "PC2","PC3", "PC4", "PC5", "Basophils", "Eosinophils", 
              "Neutrophils", "Mono (class)", "Mono (nonclass)",
              "Mono (int)", "CD4+ T-cells", "CD8+ T-cells", "B-cells", "CD16_hi NK cells",
              "CD56_hi NK cells", "NKT cells" , "HAM-D (17-items)",
              "BDI-II", "SHAPS", "CFS", "S-STAI", "T-STAI", "CTQ", "PSS", "LEQ (score)", 
              "LEQ (rating)")
cytocells36_beh = cytocells36_beh[ , col_order]
tmp = cor(cytocells36_beh, method = "spearman", use = "complete.obs")


######### retain only thresholded pval from corr 

#function extract p-val from cor.test to make heatmap 

cor.mtest = function(mat, ...) {
  mat = as.matrix(mat) #mat is you data frame with element you want to correlate
  n = ncol(mat)
  p.mat = matrix(NA, n, n) #empty correlation matrix N x N eg. 4 x 4
  diag(p.mat) = 0 #set diagonal to zero 
  for (i in 1:(n - 1)) {      #first col : second last 
    for (j in (i + 1):n) {    #second col : last col eg. 1,2 1,3 1,4 // 2,3 2,4 // 3,4 (diags are skipped)
      tmp = cor.test(mat[, i], mat[, j], ...)  #na.action = na.omit default
      p.mat[i, j] = p.mat[j, i] = tmp$p.value  # here you are filling up both triangles of cor mat
    }
  }
  colnames(p.mat) = rownames(p.mat) = colnames(mat)
  p.mat
}

#use function
cytocells36_beh_pval = cor.mtest(cytocells36_beh, method = "spearman", na.action = na.omit, exact = F)
dim(cytocells36_beh_pval)


corr.cytocells36_beh.mod = tmp #modified heatmap ie pval thresholded what you want

# looping through all elements and setting values to NA when p-values is greater than 0.05
for(i in 1:nrow(corr.cytocells36_beh.mod)){
  for(j in 1:nrow(corr.cytocells36_beh.mod)){
    if(cytocells36_beh_pval[i,j] > 0.05){   #this is thresholded pmat 
      corr.cytocells36_beh.mod[i,j] <- NA
    }
  }
}



# plot heatmap
library(wesanderson)
names(wes_palettes)

cytocell.col = c(wes_palette("Cavalcanti1", n=5, type = c("discrete"))) 


cytocellsbeh=data.frame(Class=rep(c("Soluble proteins (primary immune variables)","Soluble proteins (cytokines)","Selected PC from cytokines PCA",
                                    "Cellular variables","Clinical & behavioral variables"),c(2,15,5,12,10)))  ##change last rep to 18
rownames(cytocellsbeh)=paste(rownames(corr.cytocells36_beh.mod))
cytocellsbeh_col=list(Class = c("Soluble proteins (primary immune variables)"=cytocell.col[[1]],"Soluble proteins (cytokines)"=cytocell.col[[2]],
                                "Selected PC from cytokines PCA"=cytocell.col[[3]], "Cellular variables"=cytocell.col[[4]],
                                "Clinical & behavioral variables"=cytocell.col[[5]]))
gaps=c(2,17,22,34)

pdf("XYZ.pdf", height = 5, width = 5)
pheatmap(corr.cytocells36_beh.mod, cluster_rows = F, cluster_cols = F, treeheight_row = 0, treeheight_col = 0,
         fontsize_row = 7, fontsize_col = 7, angle_col = 90, border_color = "NA", 
         annotation_names_row = F, annotation_names_col = F, gaps_row = gaps, gaps_col = gaps,
         annotation_colors = cytocellsbeh_col[1],
         annotation_row=cytocellsbeh, annotation_col=cytocellsbeh, show_colnames=T, 
         annotation_legend = F, legend = F) 
dev.off()


