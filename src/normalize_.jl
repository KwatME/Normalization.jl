using Statistics
using StatsBase

function normalize(v::Vector{<:Real}, method::String)::Vector{Float64}

    v_float = Vector{Float64}(v)

    is_good_ = .!isnan.(v_float)

    if !any(is_good_)

        return v_float

    end

    v_good = v_float[is_good_]

    if method == "-0-"

        v_good_normalize = (v_good .- mean(v_good)) / std(v_good)

    elseif method == "0-1"

        v_good_minimum = minimum(v_good)

        v_good_normalize = (v_good .- v_good_minimum) / (maximum(v_good) - v_good_minimum)

    elseif method == "sum"

        if any(v_good .< 0)

            error("method=sum can not normalize a vector containing any negative number.")

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

        error("method is not -0-, 0-1, sum, 1234, 1224, 1223, or 1 2.5 2.5 4.")

    end

    v_float[is_good_] .= v_good_normalize

    return v_float

end

export normalize
