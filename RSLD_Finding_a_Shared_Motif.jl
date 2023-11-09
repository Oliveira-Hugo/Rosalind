# Leitura do arquivo input

if !isfile("i.txt")
    error("'i.txt' não é um arquivo")
end

input = open("i.txt", "r")

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

function longest_sequence(seqs)
    longest_seq = seqs[1]
    for seq in seqs
        if length(seq) > length(longest_seq)
            longest_seq = seq
        end
    end
    return longest_seq
end

major = longest_sequence(seqs)

function all_possible_substrings(x)
    results = String[]
    for n in 5:200     #O correto seria de 2:95:length(x)-1 
        for i in 1:n-1
            sub = x[i:n]
            push!(results, join(sub))
        end
    end
    return results
end

motifs = all_possible_substrings(major)

sorted_substrings = sort(motifs, by=x->length(x), rev=true)
#println(sorted_substrings)

function find_common_motif(seqs)
    for motif in sorted_substrings
        temp = []
        for seq in seqs
            if occursin(motif, join(seq))
                push!(temp, 1)
            end
        end
        if sum(temp) == length(seqs)
            return motif
        else
            continue
        end
    end
end

common_motif = find_common_motif(seqs)
println(common_motif)

close(input)