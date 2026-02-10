.PHONY: site clean

site:
	python3 scripts/generate_quarto_variables.py --course-yml overleaf/course.yml --output _variables.yml --check-quarto _quarto.yml
	python3 scripts/update_materials_from_course_yml.py --course-yml overleaf/course.yml --materials materials.qmd
	python3 scripts/generate_schedule_qmd.py --course-yml overleaf/course.yml --output schedule.qmd
	quarto render --no-execute

clean:
	rm -rf public build
