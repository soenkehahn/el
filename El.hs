{-# LANGUAGE TemplateHaskell #-}

import           Control.Concurrent
import           Data.Foldable
import           Language.Haskell.TH
import           System.Process
import System.Exit

main :: IO ()
main = do
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
  files <- runIO $ mapM readFile $
    "elephant-01.txt" :
    "elephant-02.txt" :
    []
  return $ ListE $ map (LitE . StringL) files)
