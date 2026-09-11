/* Quais são os empregos mais bem remunerados de Analistas de Dados, Cientistas de Dados e Analistas de Negócios no ano de 2023? */

SELECT
    job_id,
    job_title,
    job_title_short,
    job_country,
    CASE 
        WHEN job_location = 'Anywhere' THEN 'Remote'
        ELSE job_location
    END AS job_location,
    name AS company_name,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    salary_year_avg IS NOT NULL AND
    job_title_short IN ('Data Analyst', 'Business Analyst', 'Data Scientist')
ORDER BY
    salary_year_avg DESC
LIMIT 10

/* Os cargos de Data Scientist dominam as maiores remunerações de 2023, ocupando 7 das 10 posições do ranking. 
Além da maior remuneração registrada, de US$ 960 mil anuais, a categoria concentra diversas vagas acima de US$ 400 mil, indicando que posições mais especializadas e de maior senioridade em Data Science alcançaram os maiores salários entre os três perfis analisados. */