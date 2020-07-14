import qualified Data.ByteString.Lazy as B
import qualified Data.ByteString.Builder as B
import Data.Foldable
import System.Process
import Text.Printf

type Seconds = Float
type Samples = Float
type Hz = Float

outputFilePath :: FilePath
outputFilePath = "output.bin"

volume :: Float
volume = 0.5

sampleRate :: Samples
sampleRate = 48000

wave :: [Float]
wave = map (* volume) $ map sin $ map  (* step) [0.0 .. sampleRate * duration]
    where step = 0.02
        duration :: Seconds
        duration = 0.5
        hz :: Float
        hz = 440.0

save :: FilePath -> IO()
save filePath = B.writeFile "output.bin" $ B.toLazyByteString $ fold $ map B.floatLE wave

play :: IO()
play = do
    save outputFilePath
    _ <- runCommand $ printf "ffplay -showmode 1 -f f32le -ar %f %s" sampleRate outputFilePath
    return ()