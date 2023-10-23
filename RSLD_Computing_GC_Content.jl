function calc_gc_percent(x::Vector{Char})
    count = 0
    for base in x
        if(base == 'G' || base == 'C')
            count += 1
        end
    end
    gc_percent = count / length(x) * 100
    return gc_percent
end

function find_max_element_index(vector)
    if isempty(vector)
        throw(ArgumentError("Vector is empty"))
    end

    max_value = vector[1]
    max_index = 1

    for (index, value) in enumerate(vector)
        if value > max_value
            max_value = value
            max_index = index
        end
    end

    return max_index
end

function find_max_element(vector)
    if isempty(vector)
        throw(ArgumentError("Vector is empty"))
    end

    max_value = vector[1]
    max_index = 1

    for (index, value) in enumerate(vector)
        if value > max_value
            max_value = value
            max_index = index
        end
    end

    return max_value
end

# Leitura do arquivo input

if !isfile("rosalind_gc.txt")
    error("'rosalind_gc.txt' não é um arquivo")
end

input = open("rosalind_gc.txt", "r")

global seqs = Vector{Vector{Char}}()
global seq = Vector{Char}()
global seq_descr = Vector{String}()

for line in eachline(input)
    if startswith(line, '>')
        if !isempty(seq)
            push!(seqs, seq)    
        end
        push!(seq_descr, line[2:end]) # Store the description (excluding '>')
        global seq = Vector{Char}()
    else 
        seq = vcat(seq, collect(line)) # Concatenate discontinuated sequences
    end
end

if !isempty(seq)
    push!(seqs, seq)
end

close(input)

major_seq = Vector{Float64}(undef, length(seqs))

for (i, seq) in enumerate(seqs)
    major_seq[i] = calc_gc_percent(seq)
end

println(seq_descr[find_max_element_index(major_seq)])
println(find_max_element(major_seq))
