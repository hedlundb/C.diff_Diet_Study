library(ComplexHeatmap)

# This script will create separate heatmap for each diet as represented in Figure 6.

set.seed(123)
relmap <- read.table("newhtmapsv50.txt", header = TRUE, sep = "\t")
relmap <- relmap[, -1]
#Color gradient to fill heatmap
col_fun = colorRamp2(c(0, 0.5, 1, 1.5, 2),
                     c("grey95", "beige", "darkgoldenrod1", "darkorange1", "brown4"))


# Standard(-CDI)

stn <- relmap %>% filter(Diet == "Standard(-CDI)") %>% droplevels()
stn1 <- stn %>% group_by(Day) %>% summarise_all(funs(mean)) %>% droplevels()


stn1 <- stn1[, -(1:3)]
stn1scaled <- scale(stn1, center = FALSE)
stn1scaled[is.na(stn1scaled)] <- 0
Heatmap(
  stn1scaled,
  cluster_rows = FALSE,
  col = col_fun,
  cluster_columns = FALSE,
  rect_gp = gpar(col = "white", lwd = 0.5)
)

# Standard
st <- relmap %>% filter(Diet == "Standard") %>% droplevels()
st1 <- st %>% group_by(Day) %>% summarise_all(funs(mean)) %>% droplevels()


st1 <- st1[, -(1:3)]
st1scaled <- scale(st1, center = FALSE)
st1scaled[is.na(st1scaled)] <- 0
Heatmap(
  st1scaled,
  cluster_rows = FALSE,
  col = col_fun,
  cluster_columns = FALSE,
  rect_gp = gpar(col = "white", lwd = 0.5)
)

# High Carb
hc <- relmap %>% filter(Diet == HighCarb) %>% droplevels()
hc1 <- hc %>% group_by(Day) %>% summarise_all(funs(mean)) %>% droplevels()


hc1 <- hc1[, -(1:3)]
hc1scaled <- scale(hc1, center = FALSE)
hc1scaled[is.na(hc1scaled)] <- 0
Heatmap(
  hc1scaled,
  cluster_rows = FALSE,
  col = col_fun,
  cluster_columns = FALSE,
  rect_gp = gpar(col = "white", lwd = 0.5)
)


# High Fat
hf <- relmap %>% filter(Diet == "HighFat") %>% droplevels()
hf1 <- hf %>% group_by(Day) %>% summarise_all(funs(mean)) %>% droplevels()


hf1 <- hf1[, -(1:3)]
hf1scaled <- scale(hf1, center = FALSE)
hf1scaled[is.na(hf1scaled)] <- 0
Heatmap(
  hf1scaled,
  cluster_rows = FALSE,
  col = col_fun,
  cluster_columns = FALSE,
  rect_gp = gpar(col = "white", lwd = 0.5)
)


# High Protein
hp <- relmap %>% filter(Diet == "HighProtein") %>% droplevels()
hp1 <- hp %>% group_by(Day) %>% summarise_all(funs(mean)) %>% droplevels()


hp1 <- hp1[, -(1:3)]
hp1scaled <- scale(hp1, center = FALSE)
hp1scaled[is.na(hp1scaled)] <- 0
Heatmap(
  hp1scaled,
  cluster_rows = FALSE,
  col = col_fun,
  cluster_columns = FALSE,
  rect_gp = gpar(col = "white", lwd = 0.5)
)
  
