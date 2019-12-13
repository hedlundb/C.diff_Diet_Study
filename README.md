# A high-fat/high-protein, Atkins-type diet exacerbates *Clostridioides (Clostridium) difficile* infection in mice, whereas a high-carbohydrate diet protects

**Overview**

Clostridioides difficile (formerly Clostridium difficile) infection (CDI) can result from the disruption of the resident gut microbiota. Western diets and popular weight-loss diets drive large changes in the gut microbiome; however, the literature is conflicted with regard to the effect of diet on CDI. Using the hypervirulent strain C. difficile R20291 (RT027) in a mouse model of antibiotic-induced CDI, we assessed disease outcome and microbial community dynamics in mice fed two high-fat diets in comparison with a high-carbohydrate diet and a standard rodent diet. The two high-fat diets exacerbated CDI, with a high-fat/high-protein, Atkins-like diet leading to severe CDI and 100% mortality, and a high-fat/low-protein, medium-chain triglyceride (MCT)-like diet inducing highly variable CDI outcomes. In contrast, mice fed a high-carbohydrate diet were protected from CDI, despite high refined carbohydrate and low fiber content. 28 members of the Lachnospiraceae and Ruminococcaceae decreased in abundance due to diet and/or antibiotic treatment; these organisms may compete with C. difficile for amino acids and protect healthy animals from CDI in the absence of antibiotics. Together, these data suggest that antibiotic treatment might lead to loss of C. difficile competitors and create a favorable environment for C. difficile proliferation and virulence that is intensified by high-fat/high-protein diets; in contrast, high-carbohydrate diets might be protective regardless of the source of carbohydrate or antibiotic-driven loss of C. difficile competitors.


This repository contains following folders - 

- data                                 # raw data generated using QIIME2-2018.6

  - filtered-final-table.qza           # OTU table
  - final-taxonomy.qza                 # OTU taxonomy
  - metadata.txt                       # metadata file
  - rooted-tree.qza                    # OTU tree

- code/                               # QIIME commands and phyloseq scripts
  - QIIME2-2018.6-Analysis            # Steps for sequence analysis in QIIME2-2018.6
  - Figure 3 Alpha Diversity Plots.R  # Figure 3
  - Figure 4 Diet NMDS.RMD            # Figure 4
  - Figure 5 NMDS.RMD                 # Figure 5
  - Figure 6 simperheatmap.R          # Figure 6
