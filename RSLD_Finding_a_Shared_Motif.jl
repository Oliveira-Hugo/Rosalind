function LCS(sequences) 	#Longest Common Substring
    n = length(sequences)
    overall_max_length = 0
    overall_common_substring = Vector{Char}()

    for i in 1:length(sequences[1])	#Iterates in the elements of first sequence in "sequences"
        for j in (i + overall_max_length):length(sequences[1])	#Limit the search for substrings longer than the current major LCS found
            substring_candidate = sequences[1][i:j]	

            if all(x -> occursin(join(substring_candidate), join(x)), sequences[2:end])	#Search for the presence of substring candidate in all sequences, except for the first one
                overall_max_length = length(substring_candidate) #Update the current LCS length
                overall_common_substring = substring_candidate #Update the current LCS content
            end
        end
    end

    return join(overall_common_substring)
end

function read_fasta(filename)
	if !isfile("$filename")
   	 error("'$filename' não é um arquivo")
	end

	input = open("$filename", "r")

	#Every sequence (seq) is stored in a vector of chars (seqs)
	global seqs = Vector{Vector{Char}}()
	global seq = Vector{Char}()
	global seq_descr = Vector{String}()

	for line in eachline(input)
    	if startswith(line, '>')
        	if !isempty(seq)
        	    push!(seqs, seq)    
        	end
        	push!(seq_descr, line[2:end])
        	global seq = Vector{Char}()
    	else 
        	seq = vcat(seq, collect(line))
    	end
	end

	if !isempty(seq)
    	push!(seqs, seq)
	end

	close(input)
	return seqs
end

filename = "i.txt"
seqs = read_fasta(filename)

result = LCS(seqs)

println("Longest common substring among all sequences: $result")
