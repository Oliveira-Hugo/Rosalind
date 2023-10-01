#= Leitura do arquivo input =#

input = open("i.txt", "r")

if !isfile("i.txt")
    error("'i.txt' não é um arquivo")
end

seqs = Vector{Vector{Char}}()

for line in eachline(input)
    seq = Vector{Char}(line)
    push!(seqs, seq)
end

close(input)

#= Printa cada seq criada =#
#= for (i, seq) in enumerate(seqs)
    println("seq $i: ", join(seq))
end =#

#= Algoritmo =#

count = 0
num_seqs = length(seqs)

for i in 1:length(seqs[1])
    for j in 1:num_seqs - 1
        seq1 = seqs[j]
        seq2 = seqs[j + 1]

        if seq1[i] != seq2[i]
            global count += 1
        end
    end
end
        
println(count)
