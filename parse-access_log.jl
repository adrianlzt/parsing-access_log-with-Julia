lineas = readdlm("LOG",'"')
ip_fecha,request,code_bytes,url,NULL,browser,NULL = lineas[1,1:end]
ip,fecha = split(ip_fecha,' ')[[1,4]]
code,bytes = split(code_bytes,' ')[[2,3]]

type Peticion
  ip
  fecha
  request
  code::Int64
  bytes::Int64
  url
  browser
end

function parseentrada!(filename)
  entradas = Peticion[]
  fichero = open(filename)
  while !eof(fichero)
    ip_fecha,request,code_bytes,url,NULL,browser,NULL = split(readline(fichero),'"')
    ip,fecha = split(ip_fecha,' ')[[1,4]]
    code,bytes = split(code_bytes,' ')[[2,3]]
    p = Peticion(ip,fecha,request,int64(code),int64(bytes),url,browser)
    push!(entradas,p)
  end
  return entradas
end

sol = parseentrada!("LOG")

sol[1].ip
"1.2.4.5
