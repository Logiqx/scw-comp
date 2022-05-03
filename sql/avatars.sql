-- List of WCA IDs is just people who have not already got an avatar in the SCW results
-- This script does not support replacement avatars (yet)

select id, wca_id, name, avatar, concat('https://avatars.worldcubeassociation.org/uploads/user/avatar/', wca_id, '/', avatar)
from wca_dev.users
where wca_id in
(
	'2013COPP01',
	'2016HOUG03',
	'2020BURC01',
	'2021DODS01',
	'2022SIMM01',
	'2021DOYL01',
	'2019NGUY29',
	'2016BERK01',
	'2022STAN01',
	'2019RIEG02',
	'2019GOKE01',
	'2019KUCA01',
	'2015ADAM03',
	'2017CHAR16',
	'2021DOYL02',
	'2019GARD02',
	'2018LAMB02',
	'2010POLJ01',
	'2020CHEN34',
	'2012HAMA02',
	'2019BEHZ01')
and avatar is not null
ORDER BY name;