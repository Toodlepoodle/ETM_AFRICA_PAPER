library(readxl)
library(ggplot2)
library(rnaturalearth)

setwd("C:/Users/Sayan/Desktop/ETM_AFRICA_PAPER/DATA")


# List of all African countries
african_countries <- c("Algeria", "Angola", "Benin", "Botswana", "Burkina Faso", "Burundi", 
                       "Cameroon", "Cape Verde", "Central African Republic", "Chad", "Comoros", 
                       "Congo", "Cote d'Ivoire", "Rep. Of the Congo", "Djibouti", 
                       "Egypt", "Equatorial Guinea", "Eritrea", "Eswatini", "Ethiopia", 
                       "Gabon", "Gambia", "Ghana", "Guinea", "Guinea-Bissau", "Kenya", "Lesotho", 
                       "Liberia", "Libya", "Madagascar", "Malawi", "Mali", "Mauritania", "Mauritius", 
                       "Mayotte", "Morocco", "Mozambique", "Namibia", "Niger", "Nigeria", "Réunion", 
                       "Rwanda", "Saint Helena", "São Tomé and Príncipe", "Senegal", "Seychelles", 
                       "Sierra Leone", "Somalia", "South Africa", "South Sudan", "Sudan", 
                       "United Republic of Tanzania", "Togo", "Tunisia", "Uganda", "Zambia", "Zimbabwe","Dem. Rep. Congo")

etm_data <- read_excel("etm_location_worldwide.xlsx")
etm_data <- as.data.frame(etm_data)

african_mines_data <- etm_data[etm_data$Country %in% african_countries, ]

# Rename columns to 'latitude' and 'longitude'
colnames(african_mines_data)[colnames(african_mines_data) == "Latitude (degrees)"] <- "Latitude"
colnames(african_mines_data)[colnames(african_mines_data) == "Longitude (degrees)"] <- "Longitude"

africa_map <- ne_countries(continent = "Africa", returnclass = "sf")

# Plot mines on Africa map
ggplot() +
  geom_sf(data = africa_map, fill = "lightblue", color = "black") +
  geom_point(data = african_mines_data, aes(x = Longitude, y = Latitude), color = "red", size = 2) +
  labs(title = "Mines in Africa",
       x = "Longitude", y = "Latitude") +
  theme_minimal()

custom_shapes <- c(0:25)  # Example: Use shapes 0 to 25 (or more if needed)

# Ensure `Primary commodity` is treated as a factor
african_mines_data$`Primary commodity` <- as.factor(african_mines_data$`Primary commodity`)

# Plot
ggplot() +
  geom_sf(data = africa_map, fill = "lightblue", color = "black") +
  geom_point(
    data = african_mines_data, 
    aes(x = Longitude, y = Latitude, shape = `Primary commodity`), 
    size = 0.5
  ) +
  scale_shape_manual(values = custom_shapes) +  # Assign custom shapes
  labs(
    title = "Mines in Africa",
    x = "Longitude", y = "Latitude",
    shape = "Primary Commodity"
  ) +
  theme_minimal() +
  theme(legend.position = "right")
