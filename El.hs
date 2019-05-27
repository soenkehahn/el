{-# LANGUAGE TemplateHaskell #-}

import Language.Haskell.TH
import System.Environment

main :: IO ()
main = putStrLn "\8211"

foo :: ()
foo = $(do
  runIO (getEnv "LANGUAGE" >>= print)
  return $ TupE [])
