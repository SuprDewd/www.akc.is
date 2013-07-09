module Papers (Paper(..), papers) where

data Status = Preprint | Accepted | Published

data Paper = Paper
    { stage     :: Status
    , authors   :: String
    , title     :: String
    , journal   :: String
    , volume    :: String
    , pages     :: String
    , year      :: String
    , note      :: String
    , url       :: String
    , unixtime  :: Int
    }

papers =
  [ Paper
    { stage    = Preprint
    , authors  = "Anders Claesson, Sergey Kitaev, Anna de Mier"
    , title    = "An involution on bicubic maps and β(0,1)-trees"
    , journal  = ""
    , volume   = ""
    , pages    = ""
    , year     = "2012"
    , note     = ""
    , url      = "http://arxiv.org/abs/1210.3219"
    , unixtime = 1372708800
    }
  , Paper
    { stage    = Accepted
    , authors  = "Anders Claesson, Sergey Kitaev, Einar Steingrímsson"
    , title    = "An involution on β(1,0)-trees"
    , journal  = "Advances in Applied Mathematics"
    , volume   = ""
    , pages    = ""
    , year     = "2012"
    , note     = ""
    , url      = "http://arxiv.org/abs/1210.1608"
    , unixtime = 1372708800
    }
  , Paper
    { stage    = Published
    , authors  = "Anders Claesson, Henning Úlfarsson"
    , title    = "Sorting and preimages of pattern classes"
    , journal  = "DMTCS Proceedings, 24th International Conference on Formal Power Series and Algebraic Combinatorics (FPSAC 2012)"
    , volume   = ""
    , pages    = ""
    , year     = "2012"
    , note     = ""
    , url      = "http://arxiv.org/abs/1203.2437"
    , unixtime = 1372708800
    }
  , Paper
    { stage    = Published
    , authors  = "Anders Claesson, Vít Jelínek, Einar Steingrímsson"
    , title    = "Upper bounds for the Stanley-Wilf limit of 1324 and other layered patterns"
    , journal  = "Journal of Combinatorial Theory Series A"
    , volume   = "119(8)"
    , pages    = "1680--1691"
    , year     = "2012"
    , note     = ""
    , url      = "http://arxiv.org/abs/1111.5736"
    , unixtime = 1372708800
    }
  , Paper
    { stage    = Published
    , authors  = "Petter Brändén, Anders Claesson"
    , title    = "Mesh patterns and the expansion of permutation statistics as sums of permutation patterns"
    , journal  = "The Electronic Journal of Combinatorics"
    , volume   = "18(2)"
    , pages    = ""
    , year     = "2011"
    , note     = ""
    , url      = "http://www.combinatorics.org/Volume_18/Abstracts/v18i2p5.html"
    , unixtime = 1372708800
    }
  , Paper
    { stage    = Published
    , authors  = "Michael H. Albert, M. D. Atkinson, Mathilde Bouvel, Anders Claesson, Mark Dukes"
    , title    = "On the inverse image of pattern classes under bubble sort"
    , journal  = "Journal of Combinatorics"
    , volume   = "2"
    , pages    = "231--243"
    , year     = "2011"
    , note     = ""
    , url      = "http://arxiv.org/abs/1008.5299"
    , unixtime = 1372708800
    }
  , Paper
    { stage    = Published
    , authors  = "Anders Claesson, Mark Dukes, Martina Kubitzke"
    , title    = "Partition and composition matrices"
    , journal  = "Journal of Combinatorial Theory Series A"
    , volume   = "118(5)"
    , pages    = "1624--1637"
    , year     = "2011"
    , note     = ""
    , url      = "http://arxiv.org/abs/1006.1312"
    , unixtime = 1372708800
    }
  , Paper
    { stage    = Published
    , authors  = "Anders Claesson, Vít Jelínek, Eva Jelinkova, Sergey Kitaev"
    , title    = "Pattern avoidance in partial permutations"
    , journal  = "The Electronic Journal of Combinatorics"
    , volume   = "18(1)"
    , pages    = "P25"
    , year     = "2011"
    , note     = ""
    , url      = "http://www.combinatorics.org/Volume_18/Abstracts/v18i1p25.html"
    , unixtime = 1372708800
    }
  , Paper
    { stage    = Published
    , authors  = "Anders Claesson, Svante Linusson"
    , title    = "n! matchings, n! posets"
    , journal  = "Proceedings of the American Mathematical Society"
    , volume   = "139"
    , pages    = "435--449"
    , year     = "2011"
    , note     = ""
    , url      = "http://arxiv.org/abs/1003.4728"
    , unixtime = 1372708800
    }
  , Paper
    { stage    = Published
    , authors  = "Anders Claesson, Mark Dukes, Sergey Kitaev"
    , title    = "A direct encoding of Stoimenow's matchings as ascent sequences"
    , journal  = "The Australasian Journal of Combinatorics"
    , volume   = "49"
    , pages    = "47--59"
    , year     = "2011"
    , note     = ""
    , url      = "http://arxiv.org/abs/0910.1619"
    , unixtime = 1372708800
    }
  , Paper
    { stage    = Published
    , authors  = "Fan Chung, Anders Claesson, Mark Dukes, Ronald Graham"
    , title    = "Descent polynomials for permutations with bounded drop size"
    , journal  = "European Journal of Combinatorics"
    , volume   = "31"
    , pages    = "1853--1867"
    , year     = "2010"
    , note     = "Extended abstract appeared at FPSAC 2010"
    , url      = "http://arxiv.org/abs/0908.2456"
    , unixtime = 1372708800
    }
  , Paper
    { stage    = Published
    , authors  = "Anders Claesson, Sergey Kitaev, Einar Steingrímsson"
    , title    = "Decompositions and statistics for β(1,0)-trees and nonseparable permutations"
    , journal  = "Advances in Applied Mathematics"
    , volume   = "42"
    , pages    = "313--328"
    , year     = "2009"
    , note     = "doi:10.1016/j.aam.2008.09.001"
    , url      = "http://arxiv.org/abs/0801.4037"
    , unixtime = 1372708800
    }
  , Paper
    { stage    = Published
    , authors  = "Anders Claesson"
    , title    = "Generalized Pattern Avoidance"
    , journal  = "European Journal of Combinatorics"
    , volume   = "22"
    , pages    = "961--971"
    , year     = "2001"
    , note     = ""
    , url      = "http://combinatorics.cis.strath.ac.uk/download/Cl01__Generalized_Pattern.pdf"
    , unixtime = 1372708800
    }
  , Paper
    { stage    = Published
    , authors  = "Anders Claesson, Toufik Mansour"
    , title    = "Enumerating permutations avoiding a pair of Babson-Steingrímsson patterns"
    , journal  = "Ars Combinatoria"
    , volume   = "77"
    , pages    = "17--31"
    , year     = "2005"
    , note     = ""
    , url      = "http://combinatorics.cis.strath.ac.uk/download/ClMa05__Enumerating_permutations.pdf"
    , unixtime = 1372708800
    }
  , Paper
    { stage    = Published
    , authors  = "Anders Claesson, T. Kyle Petersen"
    , title    = "Conway's napkin problem"
    , journal  = "American Mathematical Monthly"
    , volume   = "114"
    , pages    = "217--231"
    , year     = "2007"
    , note     = ""
    , url      = "http://combinatorics.cis.strath.ac.uk/download/ClPe07__Conways_napkin.pdf"
    , unixtime = 1372708800
    }
  , Paper
    { stage    = Published
    , authors  = "Anders Claesson"
    , title    = "Counting segmented permutations using bicoloured Dyck paths"
    , journal  = "The Electronic Journal of Combinatorics"
    , volume   = "12"
    , pages    = ""
    , year     = "2005"
    , note     = ""
    , url      = "http://combinatorics.cis.strath.ac.uk/download/Cl05__Counting_segmented.pdf"
    , unixtime = 1372708800
    }
  , Paper
    { stage    = Published
    , authors  = "Mireille Bousquet-Mélou, Anders Claesson, Mark Dukes, Sergey Kitaev"
    , title    = "(2+2)-free posets, ascent sequences and pattern avoiding permutations"
    , journal  = "Journal of Combinatorial Theory Series A"
    , volume   = "117"
    , pages    = "884--909"
    , year     = "2010"
    , note     = "Extended abstract appeared at FPSAC 2009"
    , url      = "http://arxiv.org/abs/0806.0666"
    , unixtime = 1372708800
    }
  , Paper
    { stage    = Published
    , authors  = "Anders Claesson, Sergey Kitaev, Kari Ragnarsson, Bridget Eileen Tenner"
    , title    = "Boolean complexes for Ferrers graphs"
    , journal  = "The Australasian Journal of Combinatorics"
    , volume   = "48"
    , pages    = "159--173"
    , year     = "2010"
    , note     = ""
    , url      = "http://arxiv.org/abs/0808.2307"
    , unixtime = 1372708800
    }
  , Paper
    { stage    = Published
    , authors  = "Petter Brändén, Anders Claesson, Einar Steingrímsson"
    , title    = "Catalan Continued Fractions and Increasing Subsequences in Permutations"
    , journal  = "Discrete Mathematics"
    , volume   = "258"
    , pages    = "275--287"
    , year     = "2002"
    , note     = ""
    , url      = "http://combinatorics.cis.strath.ac.uk/download/BrClSt02__Catalan_Continued.pdf"
    , unixtime = 1372708800
    }
  , Paper
    { stage    = Published
    , authors  = "Anders Claesson, Toufik Mansour"
    , title    = "Counting Occurrences of a Pattern of Type (1,2) or (2,1) in Permutations"
    , journal  = "Advances in Applied Mathematics"
    , volume   = "29"
    , pages    = "293--310"
    , year     = "2002"
    , note     = ""
    , url      = "http://combinatorics.cis.strath.ac.uk/download/ClMa02__Counting_Occurrences.pdf"
    , unixtime = 1372708800
    }
  , Paper
    { stage    = Published
    , authors  = "Anders Claesson, Chris D. Godsil, David G. Wagner"
    , title    = "A Permutation Group Determined by an Ordered Set"
    , journal  = "Discrete Mathematics"
    , volume   = "269"
    , pages    = "273--279"
    , year     = "2003"
    , note     = ""
    , url      = "http://combinatorics.cis.strath.ac.uk/download/ClGoWa03__A_Permutation.pdf"
    , unixtime = 1372708800
    }
  , Paper
    { stage    = Published
    , authors  = "Anders Claesson, Mark Dukes, Einar Steingrímsson"
    , title    = "Permutations sortable by n-4 passes through a stack"
    , journal  = "Annals of Combinatorics"
    , volume   = "14"
    , pages    = "45--51"
    , year     = "2010"
    , note     = ""
    , url      = "http://arxiv.org/abs/0812.0143"
    , unixtime = 1372708800
    }
  , Paper
    { stage    = Published
    , authors  = "Anders Claesson, Sergey Kitaev"
    , title    = "Classification of bijections between 321- and 132-avoiding permutations"
    , journal  = "Séminaire Lotharingien de Combinatoire"
    , volume   = "B60d"
    , pages    = "30pp"
    , year     = "2008"
    , note     = "Extended abstract appeared at FPSAC 2008"
    , url      = "http://www.emis.de/journals/SLC/wpapers/s60claekit.html"
    , unixtime = 1372708800
    }
  ]
