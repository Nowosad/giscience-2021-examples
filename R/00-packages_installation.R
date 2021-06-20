install.packages("remotes")
pkgs = c("stars", "sf", "tmap",
         "terra")
remotes::install_cran(pkgs)
remotes::install_github("ropensci/FedData")
remotes::install_github("mikejohnson51/AOI")
remotes::install_github("nowosad/motif@multidim_output")
remotes::install_github("nowosad/supercells@dafbb90")
