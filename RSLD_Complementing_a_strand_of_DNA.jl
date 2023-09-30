#=
Problem

In DNA strings, symbols 'A' and 'T' are complements of each other, as are 'C' and 'G'.

The reverse complement of a DNA string s
is the string sc formed by reversing the symbols of s

, then taking the complement of each symbol (e.g., the reverse complement of "GTCA" is "TGAC").

Given: A DNA string s

of length at most 1000 bp.

Return: The reverse complement sc
of s.
=#

x = "AAAACCCGGT"

#= Invertendo o retorno da função =#

function complement1(x)
    y = ""
    for i in 1:length(x)
        if x[i] == 'A'
            y = y * "T"
        elseif x[i] == 'T'
            y = y * "A"
        elseif x[i] == 'C'
            y = y * "G"
        elseif x[i] == 'G'
            y = y * "C"
        end
    end
    return reverse(y)
end

#= Percorrendo string x do final ao início =#

function complement2(x)
           y = ""
           for char in reverse(x)
               if char == 'A'
                   y *= "T"
               elseif char == 'T'
                   y *= "A"
               elseif char == 'C'
                   y *= "G"
               elseif char == 'G'
                   y *= "C"
               end
           end
           return y
       end

println(complement1(x))
println(complement2(x))
