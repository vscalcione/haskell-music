import qualified Data.ByteString.Lazy as B
import qualified Data.ByteString.Builder as B
import Data.Foldable
import System.Process
import Text.Printf

outputFilePath :: FilePath
outputFilePath = "output.bin"


volume :: Float
volume = 0.5

sampleRate :: Float
sampleRate = 48000

wave :: [Float]
wave = map (* volume) $ map sin $ map  (* step) [0.0 .. sampleRate]
    where step = 0.02

save :: FilePath -> IO()
save filePath = B.writeFile "output.bin" $ B.toLazyByteString $ fold $ map B.floatLE wave

play :: IO()
play = do
    save outputFilePath
    _ <- runCommand $ printf "ffplay -showmode 1 -f f32le -ar %f %s" sampleRate outputFilePath
    return ()