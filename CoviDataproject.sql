select * from coviddeaths
where continent is not null
order by 3,4


select location,date,total_cases,new_cases,total_deaths,population
from coviddeaths
order by 1,2;

-- looking at total cases vs total deaths
-- shows likelihood of dying if you contract covid in your country
select location,date,total_cases,total_deaths,round((total_deaths/total_cases)*100 ,2)as Deathpercentage
from coviddeaths
where location like '%states%'
order by 1,2

-- Looking at Total cases vs Population
select location,date,population,total_cases,round((total_cases/population)*100 ,2)as casepercentage
from coviddeaths
where location like '%germany%'
order by 1,2;

-- Looking at countries with highest infection rate compared to population
select location,population,max(total_cases) as Highestinfectioncount,round(max((total_cases/population))*100 ,2)as casepercentage
from coviddeaths
group by location,population
order by casepercentage desc 

-- Showing countries with Highest Death Count per Population
select location,max(total_deaths) Highestdeathcounts from coviddeaths
where continent is not null
group by location
order by highestdeathcounts desc 

 -- Let's Break Down by Continent with the highest death count per population
 select continent,max(total_deaths) Highestdeathcounts from coviddeaths
where continent is not null
group by continent
order by highestdeathcounts desc 

-- Global Numbers
select sum(new_cases) as total_cases, sum(new_deaths) as total_deaths,round(sum(new_deaths)/sum(new_cases)*100,2) as deathpercentage
from coviddeaths
where continent is not null
order by 1,2

-- Looking at Total Population vs Vaccination

select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations ,
sum(vac.new_vaccinations) over (partition by dea.location order by dea.location,dea.date ) as rollingpeoplevaccinated
 from coviddeaths  dea
JOIN covidvaccinations vac ON
vac.location = dea.location
and vac.date = dea.date
where dea.continent is not null 
order by 2,3

-- USE CTE
with popvsvac (continent,location,Date,Population,New_vaccination,RollingpeopleVaccinated)
as(select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations ,
sum(vac.new_vaccinations) over (partition by dea.location order by dea.location,dea.date ) as rollingpeoplevaccinated
 from coviddeaths  dea
JOIN covidvaccinations vac ON
vac.location = dea.location
and vac.date = dea.date
where dea.continent is not null 
 )
 
select *, round((RollingpeopleVaccinated/population)*100,2) from popvsvac

-- Temp Table
-- Create the table
Drop Table if exists PercentPopulationVaccinated;
CREATE TABLE PercentPopulationVaccinated (
    continent NVARCHAR(255),
    location NVARCHAR(255),
    date DATETIME,
    population NUMERIC,
    new_vaccinations NUMERIC,
    rollingpeoplevaccinated NUMERIC
);

-- Insert data
INSERT INTO PercentPopulationVaccinated (
    continent, location, date, population, new_vaccinations, rollingpeoplevaccinated
)
SELECT 
    dea.continent,
    dea.location,
    dea.date,
    dea.population,
    vac.new_vaccinations,
    SUM(vac.new_vaccinations) OVER (
        PARTITION BY dea.location 
        ORDER BY dea.date
    ) AS rollingpeoplevaccinated
FROM coviddeaths dea
JOIN covidvaccinations vac 
    ON vac.location = dea.location
   AND vac.date = dea.date
;

-- Final query: show % of population vaccinated
SELECT 
    *,
    ROUND((rollingpeoplevaccinated / population) * 100, 2) AS PercentPopulationVaccinated
FROM PercentPopulationVaccinated;

-- creating view to store data for later visualizations
-- Drop the view if it already exists
DROP VIEW IF EXISTS PercentPopulationVaccinated;

-- Create the view
CREATE VIEW PercentPopVaccinated AS
SELECT 
    dea.continent,
    dea.location,
    dea.date,
    dea.population,
    vac.new_vaccinations,
    SUM(vac.new_vaccinations) OVER (
        PARTITION BY dea.location 
        ORDER BY dea.date
    ) AS rollingpeoplevaccinated
FROM coviddeaths dea
JOIN covidvaccinations vac 
    ON vac.location = dea.location
   AND vac.date = dea.date
WHERE dea.continent IS NOT NULL;

