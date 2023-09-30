#=
Problem

An RNA string is a string formed from the alphabet containing 'A', 'C', 'G', and 'U'.

Given a DNA string t
corresponding to a coding strand, its transcribed RNA string u is formed by replacing all occurrences of 'T' in t with 'U' in u

.

Given: A DNA string t

having length at most 1000 nt.

Return: The transcribed RNA string of t
#=#

x = "GATGGAACTTGACTACGTAAATT"

#=
Em Julia, esse exercício pode ser resolvido simplesmente com 

function transc(x)
    y = replace(x, 'T' => 'U')
    println(y)
end
=#

function transc(x)
         y = ""
         for i in 1:length(x)
           if x[i] == 'T'
             y = y * 'U'
           else
             y = y * x[i]
           end
         end
         return(y)
       end

println(transc(x))
