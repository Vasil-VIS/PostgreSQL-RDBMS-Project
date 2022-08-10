SELECT ep.*
FROM Director as dir, AssistantDirectorOf as adir, TVShowEpisode as ep
WHERE dir.DirectorId = 2790847 AND dir.DirectorId = adir.DirectorId AND adir.TVShowEpisodeId = ep.TVShowEpisodeId;