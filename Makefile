.PHONY: site clean

site:
	python3 scripts/update_materials_from_course_yml.py --course-yml overleaf/course.yml --materials materials.qmd
	quarto render --no-execute

clean:
	rm -rf public build
