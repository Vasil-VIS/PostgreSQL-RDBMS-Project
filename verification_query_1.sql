SELECT ep.*, show.TVShowName, show.TVShowSummary, net.*, dir.*
FROM TVShowEpisode as ep, TVShow as show, Network as net, Director as dir, MainDirectorOf as mdir
WHERE ep.TVShowEpisodeId = 1 AND show.TVShowId = ep.TVShowId AND show.NetworkId = net.NetworkId AND dir.DirectorId = mdir.DirectorId AND ep.TVShowEpisodeId = mdir.TVShowEpisodeId;