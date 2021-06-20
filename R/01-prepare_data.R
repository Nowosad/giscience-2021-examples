# nlcd --------------------------------------------------------------------
library(sf)
library(terra)
library(AOI)
library(FedData)

AOI = aoi_get(state = "OH")
AOI_proj = st_transform(AOI, "EPSG:32617")
nlcd = get_nlcd(
  template = as(AOI_proj, "Spatial"),
  label = "ohio"
)
nlcd = rast(nlcd)
AOI_proj2 = st_transform(AOI_proj, crs(nlcd))
nlcd_oh = crop(nlcd, vect(AOI_proj2))
nlcd_oh = mask(nlcd_oh, vect(AOI_proj2))
plot(nlcd_oh)

dir.create("data")
writeRaster(nlcd_oh, "data/nlcd_oh.tif", overwrite = TRUE, datatype = "INT1U")
