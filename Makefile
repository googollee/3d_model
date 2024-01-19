src = $(wildcard *.scad)
obj = $(patsubst %.scad, %.stl, $(src))

main: $(obj)

%.stl: %.scad
	openscad "$<" -o "$@"

clean:
	rm *.stl
