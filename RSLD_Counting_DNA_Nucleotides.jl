#=
Problem

A string is simply an ordered collection of symbols selected from some alphabet and formed into a word; the length of a string is the number of symbols that it contains.

An example of a length 21 DNA string (whose alphabet contains the symbols 'A', 'C', 'G', and 'T') is "ATGCTTCAGAAAGGTCTTACG."

Given: A DNA string s

of length at most 1000 nt.

Return: Four integers (separated by spaces) counting the respective number of times that the symbols 'A', 'C', 'G', and 'T' occur in s
=#

x = "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC"

function nuc_count(x)
	i = 1
	count_A = 0
	count_C = 0
	count_G = 0
	count_T = 0

	while i <= length(x)
		if x[i] == 'A'
			count_A += 1
		elseif x[i] == 'C'
			count_C += 1
		elseif x[i] == 'G'
			count_G += 1
		elseif x[i] == 'T'
			count_T += 1
		end

		i += 1

	end

	println("$count_A, $count_C, $count_G, $count_T")
        end

	nuc_count(x)
