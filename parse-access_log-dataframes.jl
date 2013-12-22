using DataFrames, GoogleCharts

df = readtable("minilog",separator=' ',header=false,colnames=["host","na","na2","date","timezone","request","status","bytes","url","browser"])
ips = df["host"]
tips = table(ips)
hosts = collect(keys(tips))
numpet = collect(values(tips))


############
# TREECHAR #
############

# Parenting
# Tenemos que hacer este truco para que nos deje meter objetos de tipo ASCIIString al array
# Si no lo hacemos, es un array de nothing y no podemos meter otra cosa
parents = Any[]
parents = append!(parents,rep("hosts",length(hosts)))

# Titulo necesario para el GoogleCharts
# No me deja usar unshift porque no es un array, aunque ahora se convierte a array puro
hosts = append!(["hosts"],hosts)

# Curioso que aqui tengo que hacerlo con unshift porque con append no me deja
unshift!(parents,nothing)

# Asignamos un color disinto a cada ip
color = [0:length(hosts)-1]

tree_data = DataFrame(quote
Nombres = $hosts
Parent = $parents
"number" = $numpet
"color" = $color
end)

tree_chart(tree_data)


################
# STATUS CODES #
################

