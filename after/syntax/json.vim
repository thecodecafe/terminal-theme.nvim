" Vim includes the colon in jsonKeywordMatch without allowing jsonNoise inside it.
syntax match jsonNoise /:/ contained containedin=jsonKeywordMatch
