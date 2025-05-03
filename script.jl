using CSV, DataFrames, Statistics
using InferCausalGraph
using InferCausalGraph: get_model_params, get_sampling_params                   # import the functions from the module

expr = CSV.read("expression.csv", DataFrame)

expr.donor = string.(expr.donor)          # Int64 → String

graph         = interventionGraph(expr)
model_pars    = get_model_params(false, 1.0, 0.01)   # defaults from README
sampling_pars = get_sampling_params(false)
model         = fit_cyclic_model(graph, false, model_pars, sampling_pars)
edges         = get_cyclic_matrices(graph, false)[3]
parsed_chain  = parse_cyclic_chain(model[1], model[2], edges)