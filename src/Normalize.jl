using Statistics


using StatsBase


function _normalize(n_::Vector{Float64}, method::String)::Vector{Float64}


    if method == "-0-"


        normalized_ = (n_ .- mean(n_)) / std(n_)


    elseif method == "0-1"


        m = minimum(n_)


        normalized_ = (n_ .- m) / (maximum(n_) - m)


    elseif method == "sum"


        if any(n_ .< 0.0)


            error(
                "method=sum can not normalize a vector containing any negative number.",
            )


        end


        normalized_ = n_ / sum(n_)


    elseif method == "1234"


        normalized_ = ordinalrank(n_)


    elseif method == "1224"


        normalized_ = competerank(n_)


    elseif method == "1223"


        normalized_ = denserank(n_)


    elseif method == "1 2.5 2.5 4"


        normalized_ = tiedrank(n_)


    else


        error("method is not -0-, 0-1, sum, 1234, 1224, 1223, or 1 2.5 2.5 4.")


    end


    return normalized_

end


function normalize(n_nan_::Vector{Float64}, method::String)::Vector{Float64}


    n_nan_ = copy(n_nan_)


    is_n_ = .!isnan.(n_nan_)


    if any(is_n_)


        n_nan_[is_n_] .= _normalize(n_nan_[is_n_], method)


    end


    return n_nan_


end


export normalize
