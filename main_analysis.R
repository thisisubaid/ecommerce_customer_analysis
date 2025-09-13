# =============================================================================
# BRAZILIAN E-COMMERCE ANALYSIS: DATA VISUALIZATION SCRIPT
# =============================================================================

# ----------------------------
# 1. SETUP: INSTALL & LOAD PACKAGES
# ----------------------------

# Install required packages (run once, then comment out)
# install.packages(c("tidyverse", "viridis", "ggrepel"))

# Load all required libraries
library(tidyverse)  # Includes ggplot2, dplyr, etc.
library(viridis)    # For colorblind-friendly color scales
library(ggrepel)    # For intelligent plot labeling

# ----------------------------
# 2. DATA IMPORT
# ----------------------------

# Load analysis datasets from CSV files
delivery_data <- read.csv("data/fast_slow_avg_delivery_q3.csv")
revenue_data <- read.csv("data/total_revenue_q1.csv")
average_order_data <- read.csv("data/top_aov_q2.csv")
payment_data <- read.csv("data/payment_method_breakdown.csv")  # Added payment data

# ----------------------------
# 3. DATA VALIDATION
# ----------------------------

# Quick inspection of loaded data
cat("Delivery Data Structure:\n")
glimpse(delivery_data)

cat("\nRevenue Data Structure:\n")
glimpse(revenue_data)

cat("\nAverage Order Value Data Structure:\n")
glimpse(average_order_data)

# ----------------------------
# 4. VISUALIZATION 1: DELIVERY TIME ANALYSIS
# ----------------------------

# Business Question: Which states have the longest delivery times?
delivery_plot <- ggplot(data = delivery_data, 
                        aes(x = reorder(customer_state, -avg_delivery_days), 
                            y = avg_delivery_days,
                            fill = avg_delivery_days)) +
  geom_col() +
  scale_fill_viridis_c(option = "plasma", 
                       name = "Days") +
  labs(title = "Average Delivery Time by Brazilian State",
       subtitle = "Northern states (RR, AP, AM) experience significantly longer delays",
       x = "State Code",
       y = "Average Delivery Time (Days)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 75, hjust = 1),
        plot.title = element_text(face = "bold", size = 14))

print(delivery_plot)

# Save the plot
ggsave("visuals/delivery_times_by_state.png", plot = delivery_plot, 
       width = 10, height = 6, dpi = 300)

# ----------------------------
# 5. VISUALIZATION 2: STRATEGIC SCATTER PLOT
# ----------------------------

# Business Question: Relationship between delivery time and customer value?
strategic_data <- delivery_data %>%
  inner_join(revenue_data, by = "customer_state") %>%
  inner_join(average_order_data, by = "customer_state")

scatter_plot <- ggplot(strategic_data,
                       aes(x = avg_delivery_days,
                           y = avg_order_value,
                           size = total_revenue,
                           label = customer_state)) +
  geom_point(color = 'darkorange', alpha = 0.7) +
  geom_text_repel(size = 3, max.overlaps = 15) +
  scale_size_continuous(range = c(3, 10),
                        name = "Total Revenue (R$)") +
  labs(title = "Strategic Analysis: Delivery Time vs. Customer Value",
       subtitle = "States with long delays and low spending (bottom-right) are key opportunities",
       x = "Average Delivery Time (Days)",
       y = "Average Order Value (R$)") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold", size = 14))

print(scatter_plot)

# Save the plot
ggsave("visuals/strategy_scatter_plot.png", plot = scatter_plot,
       width = 10, height = 7, dpi = 300)

# ----------------------------
# 6. VISUALIZATION 3: PAYMENT METHOD ANALYSIS
# ----------------------------

# Business Question: How do customers prefer to pay?
payment_plot <- ggplot(payment_data, 
                       aes(x = reorder(payment_type, first_time_orders), 
                           y = first_time_orders)) +
  geom_segment(aes(xend = payment_type, yend = 0), 
               color = "grey70", 
               linewidth = 1.5) +
  geom_point(size = 5, color = "darkorange") +
  coord_flip() +
  labs(title = "Credit Cards Dominate Payment Methods",
       subtitle = "Optimizing credit card checkout should be the highest priority",
       x = "",
       y = "Number of First-Time Orders") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold", size = 14))

print(payment_plot)

# Save the plot
ggsave("visuals/payment_methods.png", plot = payment_plot,
       width = 9, height = 5, dpi = 300)

# ----------------------------
# 7. SESSION INFO (FOR REPRODUCIBILITY)
# ----------------------------

# Display package versions for reproducibility
cat("\nSession Information for Reproducibility:\n")
sessionInfo()