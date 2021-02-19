using Plots
using SpecialFunctions

default(
    xlabel = "Tempo [s]", 
    ylabel = "Intesità",
    size = (800,500),
    framestyle=:origin
);

# Un segnale sonoro
f(x) = sin(6.28x); 
plot( f, 0, 1, label = "Segnale");

# Diapason: La 440Hz
f(x) = sin(440*6.28x); 
plot( f, 0, 1, label = "La 440Hz");
plot( f, 0, 1/110, label = "La 440Hz",  lw = 2 );

# Accordo di La M
g(x) = sin(440*6.28x) + sin(554*6.28x) + sin(659*6.28x); 
plot( g, 0, 1/110, label = "Accordo di La Maggiore");
plot!( f, 0, 1/110, label = "La 440Hz");

f1(x) = sin(440*6.28x);
f2(x) = sin(554*6.28x);
f3(x) = sin(659*6.28x);

p1 = plot( f1, 0, 1/110, label = "La 440Hz");
p2 = plot( f2, 0, 1/110, label = "Do# 554Hz");
p3 = plot( f3, 0, 1/110, label = "Mi 660Hz");
p4 = plot( g, 0, 1/110, label = "Accordo di LA");

plot(p1, p2, p3, layout = (3,1))

plot( f1, 0, 1/110, label = "La 440Hz");
plot!( f2, 0, 1/110, label = "Do# 554Hz");
plot!( f3, 0, 1/110, label = "Mi 440Hz");
plot!( g, 0, 1/110, label = "Accordo di LA");



# Campionamento

# Prendo il segnale e lo campiono con 10 punti
f(x) = sin(440*6.28x); 
plot( f, 0, 1/220, label = "La 440Hz");
x_sampling = 0:1/2200:1/220;
plot!(x_sampling, f,  seriestype = :scatter, label = "Campionamento", lw = 2)

# Ricostruisco il segnale
plot!(x_sampling, f, label = "Ricostruzione", lw = 2)

# Prendo il segnale e lo campiono con 100 punti
x_sampling = 0:1/4400:1/220;
plot( f, 0, 1/220, label = "La 440Hz", lw = 2 );
plot!(x_sampling, f,  seriestype = :scatter, label = "Campionamento", lw = 2)

# Ricostruisco il segnale
plot!(x_sampling, f, label = "Ricostruzione", lw = 2)


# Teorema
x_sampling = 0:1/2200:1/220;
y_sampling = map( x -> sin(440*6.28x), x_sampling );
y_sampling = map( x -> sin(440*6.28x), x_sampling );

plot( x_sampling, y_sampling, seriestype = :scatter, label = "Campionamento", lw = 2 );
plot!( f, 0, 1/220, label = "La 440Hz", lw = 2 );

y_sampling = map( x -> round( sin(440*6.28x), digits=1), x_sampling );
plot( x_sampling, y_sampling, seriestype = :scatter, label = "Campionamento", lw = 2 );
plot!( f, 0, 1/220, label = "La 440Hz", lw = 2 );

g(x) = sin(440*6.28x) + sin(554*6.28x) + sin(659*6.28x);
x_sampling = 0.0004:1/1320:1/220;
plot(g, 0, 1/220, label = "Accordo La M", lw = 2)
plot!(x_sampling, g,  seriestype = :scatter, label = "Campionamento", lw = 2)

# Composizione risposta in frequenza
default(
    xlabel = "", 
    ylabel = "",
    size = (800,500),
    framestyle=:origin
);
f(x) = (erf( (x - 3000)/1000 ) + 1)/2;
p1 = plot( f, 0, 22000, label = "Bassi");
g(x) = (erfc( (x - 19000)/1000 ))/2;
p2 = plot( g, 0, 22000, label = "Medi");
h(x) = (erf( (x - 12000)/1000 ) + 1)/2 + (erfc( (x - 10000)/1000 ))/2;
p3 = plot(h, 0, 22000, label = "Alti");
i(x) = f(x) * g(x) * h(x);
p4 = plot( i, 0, 22000, xlabel = "Frequenze", label = "Totale");

plot(p1, p2, p3, p4, layout = (4,1))