module Main where
import           Control.Monad      (when)
import           Data.List          (intercalate)
import           System.Directory   (getCurrentDirectory)
import           System.Environment (getArgs)
import           System.IO.Error    (catchIOError)
import           System.Process     (callProcess)

topdal :: String
topdal = "https://www.toptal.com/developers/gitignore/api/"

main :: IO ()
main = do
  callProcess "curl" ["--version"] `catchIOError`
    (\_ -> error "curl is not installed or not in PATH (https://curl.se/download.html)\nTested with 'curl --version'")
  args <- getArgs
  when ("-h" `elem` args || "--help" `elem` args || null args)
    (error "Usage: gitignore [args]\n\
           \If you give --raw it   \n\
           \will print the output  \n\
           \to stdout              \n\
           \                       \n\
           \substitutions:         \n\
           \allos | os =           \n\
           \ windows,linux,macos   \n")
  let newArgs = filter (/= "--raw") if "allos" `elem` args || "os" `elem` args
                  then ["windows", "linux", "macos"] <> filter (\e -> e /= "os" && e /= "allos") args
                  else args
  if "--raw" `elem` args
    then callProcess "curl" [topdal <> intercalate "," newArgs]
    else do
      cwd <- getCurrentDirectory
      callProcess "curl" [topdal <> intercalate "," newArgs, "-o", cwd ++ "/.gitignore"]
