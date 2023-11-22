#=
The following code is proposed to complete the Rosalind activity "Open Reading Frames".
Given any DNA sequence, the algorithm should be capable to identify protein sequences that starts in an start codon and finishes at stop codon.
It should be achieved by navigating through the original and complementary sequences and accessing the 3 reading frames in each.
If the start codon is identifyed, the code should insert a 'M' into the sequence and consequently add the amino acids that corresponds to each codon.
Finally, the Protein vector of Strings should contain all possibilities of proteins.
=#

#Function to get the complementary strand given the DNA sequence
function reverse_complement(x::String)
	comp = Vector{Char}()
	for i in x
		if i == 'A'
			push!(comp, 'T')
		elseif i == 'T'
			push!(comp, 'A')
		elseif i == 'C'
			push!(comp, 'G')
		elseif i == 'G'
			push!(comp, 'C')
		end
	end
	return join(reverse(comp))
end

function find_orfs(sequence::String)

	#Creation of Codon dictionary
	codon_table = Dict(
        "TTT" => "F", "TTC" => "F",
        "TTA" => "L", "TTG" => "L", "CTT" => "L", "CTC" => "L", "CTA" => "L", "CTG" => "L",
        "ATT" => "I", "ATC" => "I", "ATA" => "I",
        "ATG" => "M",
        "GTT" => "V", "GTC" => "V", "GTA" => "V", "GTG" => "V",
        "TCT" => "S", "TCC" => "S", "TCA" => "S", "TCG" => "S", "AGT" => "S", "AGC" => "S",
        "CCT" => "P", "CCC" => "P", "CCA" => "P", "CCG" => "P",
        "ACT" => "T", "ACC" => "T", "ACA" => "T", "ACG" => "T",
        "GCT" => "A", "GCC" => "A", "GCA" => "A", "GCG" => "A",
        "TAT" => "Y", "TAC" => "Y",
        "TAA" => "STOP", "TAG" => "STOP", "TGA" => "STOP",
        "CAT" => "H", "CAC" => "H",
        "CAA" => "Q", "CAG" => "Q",
        "AAT" => "N", "AAC" => "N",
        "AAA" => "K", "AAG" => "K",
        "GAT" => "D", "GAC" => "D",
        "GAA" => "E", "GAG" => "E",
        "TGT" => "C", "TGC" => "C",
        "TGG" => "W",
        "CGT" => "R", "CGC" => "R", "CGA" => "R", "CGG" => "R", "AGA" => "R", "AGG" => "R",
        "GGT" => "G", "GGC" => "G", "GGA" => "G", "GGG" => "G"
	)  
   
   	Proteins = Vector{String}()


   	#Consider all three forward reading frames
    	for start_pos in 1:3
        orf = ""
        i = start_pos

        while i <= length(sequence) - 2
            codon = sequence[i:i+2]

            if haskey(codon_table, codon)
                amino_acid = codon_table[codon]
                if amino_acid == "M"
                    last_start_pos = i 
                    orf = amino_acid
                    i += 3  # Move to the next codon
                    while i <= length(sequence) - 2
                        codon = sequence[i:i+2]
                        if haskey(codon_table, codon)
                            amino_acid = codon_table[codon]
                            if amino_acid == "STOP"
                                push!(Proteins, orf)
                                i += 3  # Move past the STOP codon
                                break
                            else
                                orf *= amino_acid
                                i += 3  # Move to the next codon
                            end
                        else
                            error("Invalid codon: $codon")
                        end
                    end
                    i = last_start_pos + 3
                else
                    i += 3# Move to the next codon
                end
            else
                error("Invalid codon: $codon")
            end
        end
        end
        
        #Consider all three backward reading frames
        for start_pos in 1:3
        orf = ""
        i = start_pos
        
    	while i <= length(comp_seq) - 2
            codon = comp_seq[i:i+2]

            if haskey(codon_table, codon)
                amino_acid = codon_table[codon]
                if amino_acid == "M"
                    last_start_pos = i 
                    orf = amino_acid
                    i += 3  # Move to the next codon
                    while i <= length(comp_seq) - 2
                        codon = comp_seq[i:i+2]
                        if haskey(codon_table, codon)
                            amino_acid = codon_table[codon]
                            if amino_acid == "STOP"
                                push!(Proteins, orf)
                                i += 3  # Move past the STOP codon
                                break
                            else
                                orf *= amino_acid
                                i += 3  # Move to the next codon
                            end
                        else
                            error("Invalid codon: $codon")
                        end
                    end
                    i = last_start_pos + 3
                else
                    i += 3# Move to the next codon
                end
            else
                error("Invalid codon: $codon")
            end
        end
        end
        
        Proteins = Set(Proteins)
        Proteins = collect(Proteins)
        
    	return Proteins
end


sequence = "TGTATTTCCAGATCTAGTATACTGATGAACACAAACTAGTACCGTTTGGTCGGCGGTCCTGCCAGACATGGCTTTAGTAGGACGCCGCAGACGCCAGGTAGCCCGTCGTAGCCATTAGCCGCGCTGGCCTAGTGGTATAATCCGAGATGAAGTGCAGATCCATCTCTTGCTCCTAGTACATGCTCAATGGCCCTAACGAGTCAATTAACTCCCTTTAAAGTACAACGATGGTTTTGCGACGCACGAATCCTATGCACTTATCTAAGTGTCTCGGGACAGGAACAAGGTTGGGGTGAATTATACTCCTCCTAGAGGAATGCTTAACCGGTCCAGTATGTCAAAGGGGTTCTTCACTGGACTTCCACACAGAACTAAGTTCACTCAAGGCCAGAGGCGGGGGCGCTTTCCCCATGGATCCGTATGGTAGCTGTCTTCTACCCTAGCTAGGGTAGAAGACAGCTACCATACGGATCCATAAAAGGAAAGAGTCATGTCCCCGCCGAATACCGTAATAGCAGACGATTTCCACGGAGGAATTGCGACGAGTGCAAACCCATAAAAGCGCGCGTTGTGAGTCTACACCAACCCGCACGCGGGGGTTGCGATTACCGTAAAACGATCCGAACTAACTATGTCACACGTCGCGCCCCAGTGGGAACTATCAAGCCCACGTTTATCCGAGCGTGCGTATTTACTCGTAAACTTCGCGGTTTTGCGGACAAGAGAACTTGGACATTTTCCGCGTACGCTAAATACAACGGGAAAGGCACTATTCACCCGCACCAGTGAACTATTTAACCTTGGCAGGGGTAGGACGCCACTTCTGTCGAAGAAGGGATTCACGGACCCTTTTAACAGAACATAAAGGGCGTATCCGATACTTCAA"
comp_seq = reverse_complement(sequence)
result = find_orfs(sequence)
println(result)
