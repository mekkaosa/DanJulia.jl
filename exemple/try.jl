using GLMakie
using LinearAlgebra
include("../src/DanJulia.jl")
using .DanJulia
errors = []
S_values = 1.0:1.0:10.0
for S in S_values
    theta_estime = DanJulia.p2(DanJulia.X, DanJulia.y, S)
    error = norm(theta_estime - DanJulia.theta_true, 1)
    push!(errors, error)
end 

fig = Figure()
ax = Axis(fig[1, 1], xlabel="S", ylabel="Erreur (norme 1)", title="Erreur entre theta_estime et theta_vraie en fonction de S")
lines!(ax, S_values, errors)
fig