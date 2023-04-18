{-# LANGUAGE TemplateHaskell #-}

import           Control.Concurrent
import           Control.Exception
import           Control.Monad
import           Data.Foldable
import           GHC.IO.Encoding
import           Language.Haskell.TH
import           System.Exit
import           System.IO
import           Prelude hiding (readFile)

main :: IO ()
main = do
  setLocaleEncoding utf8
  loop elephants

loop (elephant : rest) = do
  mapM_ putStrLn (replicate 100 "")
  putStrLn elephant
  if all null (lines elephant)
    then return ()
    else do
      threadDelay 150000
      loop $ map moveLeft (rest ++ [elephant])

moveLeft :: String -> String
moveLeft = unlines . map (drop 1) . lines

elephants :: [String]
elephants = $(do
  let files =
        "elephant-01.txt" :
        "elephant-02.txt" :
        []
  contents <- runIO $ forM files $ \ file -> do
    handle <- openFile file ReadMode
    hSetEncoding handle utf8_bom
    contents <- hGetContents handle
    evaluate $ length contents
    hClose handle
    return contents
  return $ ListE $ map (LitE . StringL) contents)
