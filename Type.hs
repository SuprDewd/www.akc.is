data Status = Preprint | Accepted | Published

data Article = Article
    { Stage     :: Status
    , Authors   :: String
    , Title     :: String
    , Journal   :: String
    , Volume    :: String
    , Pages     :: String
    , Year      :: String
    , Note      :: String
    , URL       :: String
    , Timestamp :: Int
    }
