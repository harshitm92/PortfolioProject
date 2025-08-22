COVID-19 Data Exploration (SQL)

This project explores global COVID-19 data using SQL queries. The goal is to analyze cases, deaths, and vaccination progress to gain insights into the pandemic’s impact across different countries and continents.

📊 Dataset

The project uses two datasets:

coviddeaths – contains details on cases, deaths, population, and location.

covidvaccinations – contains vaccination records by country and date.

(Datasets were sourced from publicly available COVID-19 data, e.g., Our World in Data.)

🔍 Key Analyses

The SQL script (CoviDataproject.sql) includes:

Cases vs Deaths – Analyzing the likelihood of dying if infected (case fatality rate).

Cases vs Population – Measuring infection rates as a percentage of population.

Highest Infection Rates – Identifying countries with the largest share of population infected.

Death Counts – Countries and continents with the highest total deaths.

Global Numbers – Summarizing worldwide cases, deaths, and fatality percentage.

Vaccination Progress

Population vs Vaccination rollout

Rolling count of vaccinations using WINDOW FUNCTIONS

Use of CTEs, Temp Tables, and Views to structure results and prepare data for visualizations.

🛠️ SQL Concepts Used

Joins

Aggregations (SUM, MAX, ROUND)

Window functions (OVER PARTITION BY)

Common Table Expressions (CTEs)

Temp tables

Views

📈 Insights

Fatality rates vary significantly by country.

Infection rates are highest in certain countries relative to population size.

Vaccination rollout can be tracked over time as a percentage of population.

Using views and temp tables helps prepare the data for BI tools like Power BI or Tableau.
