# 🔥 Weathering the Surge: Predicting & Managing Energy Demand in Extreme Heat

This project is part of the IST 687 course at Syracuse University and aims to support energy providers in forecasting and managing household electricity demand during extreme summer heat events.

**Date**: May 2025  
**Course**: IST 687 – Applied Data Science  
**Shiny App**: [Launch App](https://sumit-kharche.shinyapps.io/IDSFINALAPP/)

---

## 📌 Project Overview

The southeastern U.S. is experiencing hotter summers, putting strain on energy providers. Our goal was to:
- Predict residential energy consumption under extreme temperatures.
- Identify time-of-day and household factors contributing to peak load.
- Recommend cost-effective ways to reduce blackout risks.

We built an interactive forecasting tool using R Shiny and explored multiple modeling techniques to provide reliable, interpretable insights for utilities like **eSC**.

---

## 📊 Data Sources

- **Household Static Data**: HVAC type, square footage, etc.
- **Hourly Energy Consumption**: 5,710 homes (June–August 2018).
- **Weather Data**: Hourly temperature & humidity by county.

Final dataset: 12M+ records representing hourly usage across the summer season.

---

 🧰 #  Tools and Technologies

- **Language**: R
- **Modeling**: Generalized Additive Models (GAM), XGBoost, Linear Regression
- **Data Manipulation**: `dplyr`, `data.table`
- **Visualization**: `ggplot2`, `plotly`
- **Dashboard**: `Shiny`, `shinydashboard`
- **Others**: `lubridate`, `caret`, `mgcv`

---

## 🔍 Key Findings

- **Peak Usage Times**: 9–10 AM and 7–9 PM.
- **Top Energy Drivers**: Plug loads, cooling systems, lighting.
- **Temperature Threshold**: Energy use spikes above 27–28°C.
- **Big Homes, Big Loads**: Consumption scales non-linearly with square footage.
- **Scenario Impact**: 5°C rise → +26.48% avg usage / +34.6% peak demand.

---

## 🧠 Modeling Approaches

| Model             | R²        | RMSE      | Notes                                          |
|-------------------|-----------|-----------|------------------------------------------------|
| Linear Regression | 0.504     | 0.591     | Simple, interpretable baseline                 |
| XGBoost           | 0.513     | 0.576     | Better performance, less interpretability      |
| **GAM**           | **0.512** | **0.462** | Best trade-off between accuracy & transparency |

---

## 💡 Recommendations

- **Time-of-use pricing** to shift load.
- **Smart thermostat rebates**.
- **Public education** on unplugging idle devices.
- **Incentives for energy-efficient appliances and lighting**.

---

## 🛠️ Running the Shiny App

1. Install required R packages:
    ```r
    install.packages(c("shiny", "readxl", "ggplot2", "dplyr", "lubridate", "plotly", "mgcv", "xgboost"))
    ```

2. Run the app locally:
    ```r
    shiny::runApp("app_final_ready.R")
    ```

3. Alternatively, explore the live app:  
   👉 [https://sumit-kharche.shinyapps.io/IDSFINALAPP/](https://sumit-kharche.shinyapps.io/IDSFINALAPP/)

---

## 📂 Files Included

| File                               | Description                       |
|------------------------------------|-----------------------------------|
| `app_final_ready.R`                | Shiny application code            |
| `final_project_ids.Rmd`            | Full code & analysis in RMarkdown |
| `cleaned_df.xlsx`                  | Sample input data for app         |
| `data_dictionary.xlsx`             | Sample input data for app         |
| `energy_july_partial.xlsx`         | Sample input data for app         |
| `Weathering the Surge_Report.pdf`  | Full project report               |
| `Weathering the Surge.pdf`         | Full project presentation         |
| `README.md`                        | This file                         |

---

## 📢 License

This project is academic and shared for educational purposes only.

---

## 🙌 Acknowledgements

Special thanks to Professor Chritopher Dunham and J. Li and the IST 687 course at Syracuse University for the guidance and opportunity to explore real-world energy data science applications.

