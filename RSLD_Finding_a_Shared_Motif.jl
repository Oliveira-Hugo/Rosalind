function read_fasta(filename)
    lines = readlines(filename)
    sequences = Dict{String, String}()

    current_label = ""
    current_sequence = ""

    for line in lines
        if startswith(line, '>')
            # A new sequence label is found
            current_label = chop(line, head=1)  # Remove the '>' character
            current_sequence = ""
        else
            # Append the current line to the current sequence
            current_sequence *= strip(line)
        end

        # Store the current sequence in the dictionary
        sequences[current_label] = current_sequence
    end

    return sequences
end

function longest_common_substring_multi(sequences)
    n = length(sequences)
    overall_max_length = 0
    overall_common_substring = "No common substring"

    for i in 1:length(sequences[1])
        for j in (i + overall_max_length):length(sequences[1])
            substring_candidate = sequences[1][i:j]

            if all(x -> contains(x, substring_candidate), sequences[2:end])
                overall_max_length = length(substring_candidate)
                overall_common_substring = substring_candidate
            end
        end
    end

    return overall_common_substring
end

# Read sequences from the file
filename = "i.txt"
sequences = read_fasta(filename)

# Extract sequence contents
sequence_contents = collect(values(sequences))

# Find the longest common substring among all sequences
result = longest_common_substring_multi(sequence_contents)

# Print the overall longest common substring
println("Longest common substring among all sequences: $result")
