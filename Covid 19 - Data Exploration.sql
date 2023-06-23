select * from CovidDeaths;

--select * from CovidVaccinations order by 3,4;

--select Data that we are going to be using

select location, date, total_cases, new_cases, total_deaths, population
from CovidDeaths
order by 1,2;

--Looking at Total Cases vs Total Deaths

--Below had to update table to change null values to 0. 
--Also had to alter tables to convert datatype to floats.

UPDATE [CovidDeaths] 
SET [population] = 0
where [population] is NULL;

select population from CovidDeaths
where [population] is NULL;

select population from CovidDeaths;

UPDATE [CovidDeaths] 
SET [total_cases] = 0
where [total_cases] is NULL;

ALTER TABLE CovidDeaths
ALter column total_cases float;

select total_cases from CovidDeaths
where [total_cases] is NULL;

select total_cases from CovidDeaths;



UPDATE [CovidDeaths] 
SET [total_deaths] = 0
where [total_deaths] is NULL;

ALTER TABLE CovidDeaths
ALter column total_deaths float;

select total_deaths from CovidDeaths
where [total_deaths] is NULL;

select total_deaths from CovidDeaths;



--Shows the likelihood of dying if you contract covid in your country. (Rough Estimates)

select location, date, total_cases, total_deaths, (total_deaths/(NULLIF(total_cases,0))) * 100 as DeathPercentage
from CovidDeaths
where location like '%states%'
order by 1,2;

--Looking at Total Cases vs Population
--Shows what percentage of population got Covid

select location, date, total_cases, population, (total_cases/population) * 100 as PercentPopulationInfected
from CovidDeaths
--where location like '%states%'
where continent is not null
order by 1,2;

--Looking at countries with Highest Infection Rate compared to Population

select location, MAX(total_cases) as HighestInfectionCount, population, MAX((total_cases/population)) * 100 as PercentPopulationInfected
from CovidDeaths
--where location like '%states%'
where continent is not null
group by location, population
order by PercentPopulationInfected desc;

--Showing countries with the highest death count per population

select location, MAX(total_deaths) as TotalDeathCount
from CovidDeaths
--where location like '%states%'
where continent is not null
group by location
order by TotalDeathCount desc;



--LET'S BREAK THINGS DOWN BY CONTINENT

select continent, max(total_deaths) as TotalDeathCount
from CovidDeaths
where continent is not null
group by continent
order by TotalDeathCount desc;

select location, max(total_deaths) as TotalDeathCount
from CovidDeaths
where continent is null
group by location
order by TotalDeathCount desc;

--Showing continents with the highest death count per population

select continent, max(total_deaths) as TotalDeathCount
from CovidDeaths
where continent is not null
group by continent
order by TotalDeathCount desc;


--Global Numbers

select location, date, total_cases, total_deaths, (total_deaths/(NULLIF(total_cases,0))) * 100 as DeathPercentage
from CovidDeaths
where location like '%states%' and continent is not null
order by 1,2;