/* Quais habilidades tem as maiores demandas e um alto salário nos cargos de Analista de Dados, Analista de Negócios e Cientista de Dados no ano de 2023? */

WITH skill_stats AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(DISTINCT job_postings_fact.job_id) AS demand_count,
        ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact

    INNER JOIN skills_job_dim
        ON job_postings_fact.job_id = skills_job_dim.job_id

    INNER JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id

    WHERE
        job_title_short IN (
            'Data Analyst',
            'Business Analyst',
            'Data Scientist'
        )
        AND salary_year_avg IS NOT NULL
        AND EXTRACT(YEAR FROM job_posted_date) = 2023

    GROUP BY
        skills_dim.skill_id,
        skills_dim.skills
),

filtered_skills AS (
    SELECT
        skill_id,
        skills,
        demand_count,
        avg_salary
    FROM skill_stats
    WHERE demand_count > 10
),

skill_scores AS (
    SELECT
        skill_id,
        skills,
        demand_count,
        avg_salary,

        PERCENT_RANK() OVER (
            ORDER BY demand_count
        ) AS demand_score,

        PERCENT_RANK() OVER (
            ORDER BY avg_salary
        ) AS salary_score

    FROM filtered_skills
)

SELECT
    skill_id,
    skills,
    demand_count,
    avg_salary,

    ROUND(
        (
            demand_score * 0.5 +
            salary_score * 0.5
        )::NUMERIC,
        3
    ) AS opportunity_score

FROM skill_scores

ORDER BY
    opportunity_score DESC,
    demand_count DESC

LIMIT 25;

/* Spark apresenta o melhor equilíbrio entre demanda e remuneração, liderando o ranking com Opportunity Score de 0,910, 1.145 ocorrências e salário médio anual de US$ 138,8 mil. 
PyTorch e TensorFlow aparecem logo em seguida, evidenciando também a forte valorização de competências relacionadas a Machine Learning e IA. */