import qualified Data.ByteString.Lazy as B
import qualified Data.ByteString.Builder as B
import Data.Foldable

volume :: Float
volume = 0.5

wave :: [Float]
wave = map (* volume) $ map sin $ map  (* step) [0.0 .. 48000]
    where step = 0.05

save :: IO()
save = B.writeFile "output.bin" $ B.toLazyByteString $ fold $ map B.floatLE wave