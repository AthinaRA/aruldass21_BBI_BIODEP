# Athina Aruldass - Aug 2021 - Aruldass et al. (2021) BBI
# R version 3.6.0 (2019-04-26)

####### FIG 1D (Chord diagram : also 2B, 3C) ######################################

install.packages("circlize")
library(circlize)

#yeo_name : read.delim Yeo_hcp.txt
#roi.hcp  : read.csv FCmatsROIorder_glasser.txt (header=T, sep = "")

##### Example with HC network

# get cor coef for NBS network from HC group mat
adj.subnet = read.table("adjHChiCRP_3p8.txt", header = F, sep = " ")  #adjacency matrix from NBS MATLAB

HC.mat = readRDS("HCmatfdreg.rds") # group averaged full FC matrix
dim(HC.mat)
HC.testdat = HC.mat
HC.testdat[adj.subnet == 0] = 0
write.table(HC.testdat,"adjNBSnet_HChiCRP3p8_HCgrpmat.txt", col.names = F, row.names = F, sep = " ")  ## to plot brainnet


# define obj for circos plot
mat = HC.testdat

colnames(mat) = roi.hcp$ROI_ID
rownames(mat) = roi.hcp$ROI_ID
mat.yeo = mat[as.character(yeo_name$ROI_ID), as.character(yeo_name$ROI_ID)] #do this to make sure the circle is ordered by module


# rename subcrotical regions
tmp = mat.yeo
colnames(tmp)[colnames(tmp) == "Left-Thalamus-Proper"] = "L_Thalamus"
colnames(tmp)[colnames(tmp) == "Right-Thalamus-Proper"] = "R_Thalamus"
colnames(tmp)[colnames(tmp) == "Left-Putamen"] = "L_Putamen"

rownames(tmp)[rownames(tmp) == "Left-Thalamus-Proper"] = "L_Thalamus"
rownames(tmp)[rownames(tmp) == "Right-Thalamus-Proper"] = "R_Thalamus"
rownames(tmp)[rownames(tmp) == "Left-Putamen"] = "L_Putamen"


# to retain negative edges only in network
neg_mat.yeo = tmp
neg_mat.yeo[tmp > 0] = 0

# set colour for negative edges (to only show negative edges)
neg_linkcol = colorRamp2(range(neg_mat.yeo), c("blue", "lightblue"), transparency = 0.1) 


# define DMN and VA sector colour for each Yeo module
DMNvATTN_chordcol = c("L_d23ab" = "darkorange1", "L_31pv" = "darkorange1", "R_8Ad" = "darkorange1", "R_PGs" = "darkorange1", "L_POS1" = "darkorange1", "R_d23ab" = "darkorange1", "L_STSvp" = "darkorange1", "R_RSC" = "darkorange1", 
                       "L_9a" = "darkorange1", "L_s32" = "darkorange1",
                       "L_6r" = "turquoise", "L_FOP4" = "turquoise", "L_FOP1" = "turquoise", "R_33pr" = "turquoise", "L_PF" = "turquoise", "L_MI" = "turquoise",
                       "R_A1" = "gray", "R_OP4" = "gray", "L_LBelt" = "gray", "L_PBelt" = "gray", "L_MBelt" = "gray", 
                       "L_PFm" = "gray" ,"R_IP1" = "gray", "L_IP2" = "gray","L_7Pm" = "gray",
                       "L_Thalamus" = "gray", "R_Thalamus" = "gray", "L_Putamen" = "gray", "R_H" = "gray", 
                       "L_MT" = "gray", "L_LO3" = "gray", "L_7PL" = "gray", "L_PGp" = "gray") 


# make pdf 

## 1 - make sure you have .testdat made, renamed subcort, and set to correct mat > tmp mat
## 2 - for this plot, you need DMNvATTN_chordcol2 and neg_linkcol

pdf("HCchord.pdf", height = 5, width = 5)
chordDiagram(tmp, symmetric = T, annotationTrack = "grid", grid.col = DMNvATTN_chordcol, 
             col = neg_linkcol, link.visible = tmp < 0,
             order = colnames(tmp), link.sort = T, link.decreasing = T, preAllocateTracks = 1)

# we go back to the first track and customize sector labels ie add the labels 
circos.track(track.index = 1, panel.fun = function(x, y) {
  circos.text(CELL_META$xcenter, CELL_META$ylim[1], CELL_META$sector.index, 
              facing = "clockwise", niceFacing = T, adj = c(0, 0.5), cex = 0.7)
}, bg.border = NA) # here set bg.border to NA is important
dev.off()















