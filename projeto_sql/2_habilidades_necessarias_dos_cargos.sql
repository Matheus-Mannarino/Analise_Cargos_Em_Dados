/* Quais habilidades são exigidas para os empregos de Analista de Dados, Analista de Negócios e Cientista de Dados? */

WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        job_title_short,
        name AS company_name,
        salary_year_avg
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        salary_year_avg IS NOT NULL AND
        job_title_short IN ('Data Analyst', 'Business Analyst', 'Data Scientist')
    ORDER BY
        salary_year_avg DESC
) 

SELECT
    top_paying_jobs.*,
    skills
FROM 
    top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC

/* SQL e Python lideram a demanda por competências, aparecendo em 61,5% e 59,1% das vagas analisadas. 
Entretanto, a importância das ferramentas varia de acordo com o cargo: Python está presente em 81,7% das vagas de Data Scientist, enquanto Excel aparece em 44,1% das oportunidades de Data Analyst e Business Analyst. 
SQL se destaca como a habilidade mais transversal, mantendo presença próxima ou superior a 60% nos três cargos analisados. */