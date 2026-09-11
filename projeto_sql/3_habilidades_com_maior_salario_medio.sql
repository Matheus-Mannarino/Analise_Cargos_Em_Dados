/* Quais são as habilidades com maior salário para Analistas de Dados, Analistas de Negócios e Cientistas de Dados no ano de 2023? */

SELECT
    skills,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short IN ('Data Analyst', 'Business Analyst', 'Data Scientist') AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25

/* As habilidades associadas aos maiores salários médios em 2023 são predominantemente tecnologias especializadas. 
Red Hat lidera o ranking, com média de US$ 189,5 mil anuais, seguida por Elixir (US$ 170,8 mil) e Lua (US$ 170,5 mil). 
O Top 25 também inclui tecnologias ligadas a IA e Machine Learning, como Hugging Face, PyTorch e TensorFlow, indicando valorização de competências técnicas mais específicas. */