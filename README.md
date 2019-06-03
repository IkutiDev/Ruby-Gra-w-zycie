[![Travis](https://travis-ci.com/TestowanieRubyUG20182019/projektsemestralny-misie.svg?token=zfdnyWxniFXJmUEvgo2F&branch=master)](https://travis-ci.com/TestowanieRubyUG20182019/projektsemestralny-misie)
# Gra w życie
Projekt symulacji obiektów wchodzących w interakcje między sobą. Typy obiektów to owca, wilk, trawa, jezioro.
# Zasady gry
* Kolejnosc akcji jest wedlug najstarszego obiektu do najnowszego. Gdy mapa jest tworzona z pliku to najstarsze obiekty sa blizej koordynat 0,0, czym dalej tym sa mlodsze.
* Owca moze zjesc trawe(odrazu potym jak owca wejdzie na trawe trawa znika z mapy), gdy wejdzie na pole jeziora to odrazu umiera, nie moze wejsc na wilka.
* Owce moge sie rozmnazac jezeli po turze ruchow dwie bede obok siebie(nie liczymy owiec po ukosie). Kazda owca w danej parze moze tylko raz sprobowac sie rozmnozyc na ture(owca ktora zaczyna kopulacje i partner nie moga sie juz kopulowac na danej turze po jednej probie). Szansa na kopulacje to 60%, Jednak jezeli nie ma wolnego pola wokol pierwszej i drugiej owcy to nie powstanie nowa owca.
* Trawa ma co ture szanse 60% na rozmnozenie jezeli w danej turze wybrane miejsce jest puste. Po stworzeniu trawa ma zycie losowe od 1 do 20 i co ture traci 1 zycie(starzeje sie).
* Jezeli wilk wejdzie na owce to owca znika. Jezeli wilk wejdzie na jezioro to on znika. Wilk nie moze wejsc na wilka. Jezeli wilk wejdzie na trawe to trawa dalej istnieje jak zejdzie(dwa obiekt w tym samym miejscu).
# Projekt stworzony z pomocą
* Minitest
* Rspec
* Simplecov
* Travis
# Skład drużyny:
* Magdalena Ordowska
* Gabriel Sidorek
* Michał Olkiewicz


