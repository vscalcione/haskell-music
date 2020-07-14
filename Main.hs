import qualified Data.ByteString.Lazy as B
import qualified Data.ByteString.Builder as B
import Data.Foldable

wave :: [Float]
wave = map sin $ map  (* step) [0.0 .. 48000]
    where step = 0.01
