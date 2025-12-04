using Convex,SCS
using LinearAlgebra


# Define the optimization variable
function p1(X, y)
    n = size(X, 2)
    theta = Variable(n)
    L = sumsquares(X * theta - y)
    problem = minimize(L, [theta >= 0])
    solve!(problem, SCS.Optimizer; silent_solver=true)
    return theta.value
end



# Define another optimization variable but thiss time with constraints
# la contraintes est que theta>=0 et sum(theta)<=S
function p2(X, y, S)
    n = size(X, 2)
    theta = Variable(n)
    L = sumsquares(X * theta - y)
    problem = minimize(L, [theta >= 0, sum(theta) <= S])
    solve!(problem, SCS.Optimizer; silent_solver=true)
    return theta.value
end


   

# faire varier S

# calculer lerreur valeur absolue entre theta_estime et theta_vraie
# et trace cette erreur en fct de S 


# tracer cette erreur en fct de S


# Trouver le S optimal qui minimise l'erreur
function S_optimal(X, y, theta_true)
    S_vals = 4.0:0.01:8.0
    errors = Float64[]
    for S in S_vals
        theta_est = p2(X, y, S)
        push!(errors, norm(theta_est - theta_true, 1))
    end
    S_opt = S_vals[argmin(errors)]
    return S_opt, minimum(errors)
end

# ajouter une fonction qyu va venir retourner une list des erreurs theta_estime - theta_vraie en fct de S
function compute_errors(X, y, theta_true, S_values)
    errors = []
    for S in S_values
        theta_estime = p2(X, y, S)
        error = norm(theta_estime - theta_true, 1)
        push!(errors, error)
    end
    return errors
end