.PHONY: run

src = *.v

run:
	iverilog -o pit $(src)
	vvp pit