library(supercells)
library(terra)
library(tmap)
library(motif)
library(stars)

# read the data -----------------------------------------------------------
r_nlcd = rast("data/nlcd_oh.tif")
tm5_1 = tm_shape(r_nlcd) +
  tm_raster(drop.levels = TRUE, title = "Land cover category:") +
  tm_layout(frame = FALSE, legend.outside = TRUE,
            scale = 0.65)
tm5_1

# extract info ------------------------------------------------------------
landcover = read_stars("data/nlcd_oh.tif")
composition = lsp_signature(landcover, type = "composition", window = 10,
                            normalization = "pdf")

# composition_borders = lsp_add_sf(composition)
composition_stars = lsp_add_stars(composition, version = 2)
composition_terra = rast(as(composition_stars, "Raster"))

# create superpixels ------------------------------------------------------
landcover_slic = supercells(composition_terra, k = 10000, compactness = 0.3, dist_fun = "jensen_shannon",
                             clean = TRUE)

tm5_3 = tm_shape(r_nlcd) +
  tm_raster(drop.levels = TRUE, title = "Land cover category:") +
  tm_shape(landcover_slic) +
  tm_borders(lwd = 0.5, col = "black") +
  tm_layout(frame = FALSE, legend.show = FALSE)
tm5_3

write_sf(landcover_slic, "data/superpixels.gpkg")
