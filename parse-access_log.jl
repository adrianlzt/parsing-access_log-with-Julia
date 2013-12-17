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
    linea = split(readline(fichero),'"')
    if !(length(linea) == 7)
      error("Error, la linea no tiene 7 campos\n$linea")
      continue
    end
    ip,fecha = split(linea[1],' ')[[1,4]]
    code,bytes = split(linea[3],' ')[[2,3]]

    # Algunas peticiones no tiene valor de bytes
    bytes = (bytes == "-") ? 0 : bytes

    # Resto de datos
    request = linea[2]
    url = linea[4]
    browser = linea[6]

    try
      p = Peticion(ip,fecha,request,int64(code),int64(bytes),url,browser)
      push!(entradas,p)
    catch e
      println("Error:")
      println("Peticion:\n\tip: $ip\n\tfecha: $fecha\n\trequest: $request\n\tcode: $code\n\tbytes: $bytes\n\turl: $url\n\tbrowser: $browser")
      println(e)
    end
  end
  return entradas
end

#sol = parseentrada!("LOG")
sol = parseentrada!("access_log");

sol[1].ip
