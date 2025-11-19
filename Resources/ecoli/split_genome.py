def split_genome_at_file():
	genome = open("ASM584v2_ecoli.txt", "r")

	offset = 0
	lines_of_current_file = 0
	current_file = ""

	current_line = genome.readline()
	while current_line != "":
		lines_of_current_file += 1
		current_file = current_file + current_line.rstrip()

		if lines_of_current_file >= 100:
			new_file = open(str(offset) + "_" + str(offset + 100) + ".txt", "w")
			new_file.write(current_file)
			new_file.close()

			current_file = ""
			lines_of_current_file = 0

			offset += 100
			
		current_line = genome.readline()

split_genome_at_file()