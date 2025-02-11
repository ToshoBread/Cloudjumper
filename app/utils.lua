utils = {}

function utils:ternary(condition, trueValue, falseValue)
    if condition then
        return trueValue
    else
        return falseValue
    end
end

function utils:switch(value)
    return function(cases)
        if cases[value] then
            cases[value]()
        elseif cases.default then
            cases.default()
        end
    end
end

return utils
