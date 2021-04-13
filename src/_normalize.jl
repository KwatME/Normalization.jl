using Statistics
using StatsBase

include("normalize_good.jl")


function normalize(f_::Vector{Float64}, method::String)::Vector{Float64}


    f_ = copy(f_)


    is_good_ = .!isnan.(f_)


    if any(is_good_)


        f_[is_good_] .= normalize_good(f_[is_good_], method)


    end


    return f_


end


export normalize
