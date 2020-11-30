module Normalize


using Statistics
using StatsBase


function normalize(v::Vector{<:Real}, method::String)

    v_float = Vector{Float64}(v)

    is_not_nan_ = .!isnan.(v_float)

    if !any(is_not_nan_)

        return v_float

    end

    v_good = v_float[is_not_nan_]

    if method == "-0-"

        v_good_normalize = (v_good .- mean(v_good)) / std(v_good)

    elseif method == "0-1"

        v_good_minimum = minimum(v_good)

        v_good_normalize = (v_good .- v_good_minimum) / (maximum(v_good) - v_good_minimum)

    elseif method == "sum"

        if any(v_good .< 0)

            error("can not normalize a vector containing a negative value with method sum.")

        end

        v_good_normalize = v_good / sum(v_good)

    elseif method == "1234"

        v_good_normalize = ordinalrank(v_good)

    elseif method == "1224"

        v_good_normalize = competerank(v_good)

    elseif method == "1223"

        v_good_normalize = denserank(v_good)

    elseif method == "1 2.5 2.5 4"

        v_good_normalize = tiedrank(v_good)

    else

        error("method $method is not -0-, 0-1, sum, 1234, 1224, 1223, or 1 2.5 2.5 4.")

    end

    v_float[is_not_nan_] .= v_good_normalize

    return v_float

end


export normalize


end
