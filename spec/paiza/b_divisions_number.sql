select d.division_name, count(d.division_name)
from dice_test.members as m
left outer join dice_test.divisions as d on m.division_id = d.division_id
group by d.division_name, d.division_id
order by d.division_id
