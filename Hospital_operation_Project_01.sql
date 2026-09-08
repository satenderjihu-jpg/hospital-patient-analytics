-- hospital_operation_analysis--
use hospital_operation_01;
select*from hos_op;
select count(*) as total_rows from hos_op;
select distinct Patient_id from hos_op;
select* from hos_op
    where patient_ID is null
    and
    patient_Name is null
    and
    age is null
    and
    gender is null
    and
    City is null
    and
    Admission_Date is null
    and
    Discharge_Date is null
    and
    Department is null
    and
    Doctor is null
    and
    Diagnosis is null
    and
    Treatment_Type is null
    and 
    payment_Method is null
    and 
    Payment_Method is null
    and 
    Readmitted is null;

select patient_id, 
count(*) as dublicate_values
from hos_op
group by patient_id
 having count(*) >2;
 
 -- Q1 Hospital me total kitne patients registered hain.?
 select 
 count(*) as total_patient 
 from hos_op;
 
 
-- Q3 Kaunse city se sabse zyada patients hospital me aaye hain.?

select city , count(*) as total_city
 from hos_op
 group by city
 order by Total_city desc;
 
 -- Q4 Kaunsa department sabse zyada patients handle kar raha hai.?
 
 select Department ,
      count(*) as total_patient
      from hos_op
      group by department
      order by total_patient desc
      limit 1;
-- Q5 Hospital me sabse common diagnosis kaunsi hai.?

 select
      diagnosis, count(*) as comman_diagnosis
      from hos_op
      group by diagnosis
      order by comman_diagnosis desc;
      
-- Q6 Hospital me patients ki average age kya hai.?
 
  select 
      round(avg(age), 2) as avg_age 
      from hos_op;
      
-- Q7 Hospital me kaunsa admission type sabse zyada common hai — Emergency, Routine ya Referral.?alter

 select 
   Admission_type, count(*) as total_Admission
   from hos_op
   group by Admission_type
   order by total_admission desc;
   
-- Q8 Kaunse department ka average treatment cost sabse zyada hai.?
SELECT department, 
       AVG(CAST(Treatment_Cost AS DECIMAL(10,2))) AS avg_cost
FROM hos_op
GROUP BY department
ORDER BY avg_cost DESC
LIMIT 1;

SELECT 
    Treatment_Cost,
    REPLACE(REPLACE(Treatment_Cost, '₹', ''), ',', '') AS cleaned_cost
FROM hos_op
LIMIT 10;

SELECT 
    Treatment_Cost,
    REPLACE(Treatment_Cost, '?', '') AS cleaned_cost
FROM hos_op
LIMIT 10;

SELECT department, 
       AVG(
    CAST(
        REPLACE(REPLACE(Treatment_Cost, '?', ''), ',', '')
        AS DECIMAL(10,2)
    )
) AS avg_cost
FROM hos_op
GROUP BY department
ORDER BY avg_cost DESC
LIMIT 1;

-- Q9 Hospital ka total treatment cost kitna hai, aur department-wise total treatment cost kya hai?

select 
  department,   
  sum(
    CAST(
        REPLACE(REPLACE(Treatment_Cost, '?', ''), ',', '')
        AS DECIMAL(10,2)
    )
)as total_cost
from hos_op
group by department;

-- Hospital mein sabhi patients ka total treatment cost kitna hai.?
select 
  sum(
    CAST(
        REPLACE(REPLACE(Treatment_Cost, '?', ''), ',', '')
        AS DECIMAL(10,2)
    )
)as total_cost
from hos_op;

-- Hospital mein kitne patients readmitted hue hain, aur total patients mein readmission rate kitna hai.?

select count(Readmitted) as total_Readmit
from hos_op
where readmitted = 'yes';


SELECT 
    (COUNT(*) / 1980) * 100 AS readmission_rate
FROM hos_op
WHERE Readmitted = 'Yes';

-- Q11Kaunse department mein sabse zyada patients readmitted hue hain.?

select department,
 count(readmitted) as total_readmitted
from hos_op 
where Readmitted = 'yes'
group by department
order  by total_readmitted desc
limit 1;

-- Q12 Kya zyada din hospital mein rehne wale patients mein readmission zyada hai?

select readmitted,  avg(Length_of_Stay) as total_stay
from hos_op
group by readmitted;

-- Q13 Kaunsa department total treatment cost ke hisaab se hospital ke liye sabse zyada costly hai?

select   department,
  sum(
    CAST(
        REPLACE(REPLACE(Treatment_Cost, '?', ''), ',', '')
        AS DECIMAL(10,2)
    )
)as total_cost
from hos_op
group by department
order by Total_cost desc
limit 1;

-- Q14 Kaunse department mein patients ki average rating sabse zyada hai?

select department, avg(Patient_Rating) as total_rating 
from hos_op
group by department 
order by total_rating desc
limit 1;

-- Q15 Hospital mein sabse zyada patients ko kaunsa Treatment Type diya gaya hai

select treatment_type, count(Treatment_Type) as total_type 
from hos_op 
group by treatment_type
order by total_type  desc
limit 1;

-- Q16 Kaunsi insurance type ke patients hospital mein sabse zyada hain?

select insurance, count(*) as type_insurance
from hos_op
group by insurance;

-- Q17  Patients mein sabse zyada kaunsa payment method use hua hai?

select 
    Payment_Method, count(*) as total_payment_M
    from hos_op
    group by Payment_Method 
    order by total_payment_M desc
    limit 1;
    
-- Q18 Kaunse admission type (Emergency, Routine, Referral) mein readmission sabse zyada hai.?

select Admission_Type, count(*) as total_type
 from hos_op
  where readmitted = 'yes'
 group by Admission_Type
 order by total_type desc;

-- Q19 Kaunse department mein treatment cost high hai aur us department ka readmission rate bhi high hai?

SELECT 
    Department,
    ROUND(AVG(
        CAST(REPLACE(REPLACE(Treatment_Cost, '?', ''), ',', '') AS DECIMAL(10,2))
    ), 2) AS avg_treatment_cost,

    ROUND(
        SUM(CASE WHEN Readmitted = 'Yes' THEN 1 ELSE 0 END) 
        / COUNT(*) * 100,
        2
    ) AS readmission_rate

FROM hos_op
GROUP BY Department
ORDER BY readmission_rate DESC;

-- Q20 Kaunse department mein patients ki average length of stay sabse zyada hai,
 -- aur kya us department ka average treatment cost bhi high hai?
 
 select department, avg(Length_of_Stay) as avg_Stay,
      ROUND(AVG(
        CAST(REPLACE(REPLACE(Treatment_Cost, '?', ''), ',', '') AS DECIMAL(10,2))
    ), 2) AS avg_treatment_cost
    
  from hos_op
  group by department
  order by avg_stay desc;
  
-- Q21 “Kya Emergency admission wale patients ka average treatment cost, Planned aur Referral admission wale patients se zyada hai?

select Admission_Type,      
     ROUND(AVG(
        CAST(REPLACE(REPLACE(Treatment_Cost, '?', ''), ',', '') AS DECIMAL(10,2))
    ), 2)  as avg_treat_cost
    from hos_op
    group by Admission_type;
    
-- Q22 “Kya age group ke hisaab se readmission rate mein difference hai?

SELECT
    CASE 
        WHEN Age BETWEEN 0 AND 18 THEN '0-18'
        WHEN Age BETWEEN 19 AND 35 THEN '19-35'
        WHEN Age BETWEEN 36 AND 50 THEN '36-50'
        WHEN Age BETWEEN 51 AND 65 THEN '51-65'
        ELSE '66+'
    END AS age_group,
    ROUND(
        SUM(CASE WHEN Readmitted = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*) * 100,
        2
    ) AS readmission_rate

FROM hos_op
GROUP BY age_group;

-- Q23 Kaunsa treatment type sabse zyada patients ko diya gaya, aur us treatment type ka average treatment cost kya hai

select Treatment_type ,
 ROUND(AVG(
        CAST(REPLACE(REPLACE(Treatment_Cost, '?', ''), ',', '') AS DECIMAL(10,2))
    ), 2)  as avg_treat_cost
    from hos_op
    group by treatment_type
    order by avg_treat_cost desc;
    
-- Q24 Har department ka readmission rate calculate karo, aur sirf un 
-- departments ko identify karo jinka readmission rate overall hospital ke readmission rate se zyada hai.

select department,
SUM(case when readmitted = 'yes' then 1 else 0 end)/count(*)*100 as total_rate
from hos_op 
group by department
having total_rate >50
order by total_rate desc;

-- Q25 Har department ke andar identify karo ki kaunsa Treatment_Type ka average treatment cost sabse zyada hai

WITH treatment_avg AS (
    SELECT
        Department,
        Treatment_Type,
        ROUND(
            AVG(
                CAST(
                    REPLACE(REPLACE(Treatment_Cost, '?', ''), ',', '')
                    AS DECIMAL(10,2)
                )
            ), 2
        ) AS avg_treat_cost
    FROM hos_op
    GROUP BY Department, Treatment_Type
),

ranked_treatments AS (
    SELECT
        Department,
        Treatment_Type,
        avg_treat_cost,
        ROW_NUMBER() OVER (
            PARTITION BY Department
            ORDER BY avg_treat_cost DESC
        ) AS rn
    FROM treatment_avg
)

SELECT
    Department,
    Treatment_Type,
    avg_treat_cost
FROM ranked_treatments
WHERE rn = 1
ORDER BY avg_treat_cost DESC;
   
 