using Statistics
using StatsBase

function normalize(f_::Vector{Float64}, method::String)::Vector{Float64}

    f_ = copy(f_)

    is_good_ = .!isnan.(f_)

    if !any(is_good_)

        return f_

    end

    good_ = f_[is_good_]

    if method == "-0-"

        normalized_ = (good_ .- mean(good_)) / std(good_)

    elseif method == "0-1"

        mi = minimum(good_)

        normalized_ = (good_ .- mi) / (maximum(good_) - mi)

    elseif method == "sum"

        if any(good_ .< 0.0)

            error("method=sum can not normalize a vector containing any negative number.")

        end

        normalized_ = good_ / sum(good_)

    elseif method == "1234"

        normalized_ = ordinalrank(good_)

    elseif method == "1224"

        normalized_ = competerank(good_)

    elseif method == "1223"

        normalized_ = denserank(good_)

    elseif method == "1 2.5 2.5 4"

        normalized_ = tiedrank(good_)

    else

        error("method is not -0-, 0-1, sum, 1234, 1224, 1223, or 1 2.5 2.5 4.")

    end

    f_[is_good_] .= normalized_

    return f_

end

export normalize
