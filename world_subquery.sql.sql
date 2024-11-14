desc city;
desc country;
desc countrylanguage;
select
    tx1.Name,
    tx1.Code,
    tx1.Population,
    cl.Language
from
(
    select c.Name,
           c.Code,
           c.Population,
            tx.totalcity_population
      from
          (
           select city.CountryCode,
                  sum(Population) as totalcity_population
            from city
            where Population > 100000
            group by city.CountryCode
            HAVING totalcity_population > 500000
            order by totalcity_population desc
           ) tx
     inner join country c on c.Code = tx.CountryCode
)tx1
    inner join countrylanguage cl on cl.CountryCode=tx1.Code where IsOfficial='T';
