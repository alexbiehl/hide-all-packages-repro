
import Distribution.PackageDescription (PackageDescription(..))
import Distribution.Simple.Setup ( BuildFlags(..), buildVerbosity, fromFlagOrDefault )
import Distribution.Simple ( defaultMainWithHooks, simpleUserHooks, UserHooks(..) )
import Distribution.Simple.LocalBuildInfo ( LocalBuildInfo(..) )
import Distribution.Simple.Program
import Distribution.Verbosity ( normal )


main = defaultMainWithHooks simpleUserHooks { postBuild = myPostBuild }

myPostBuild _ flags _ lbi = do
  let runProgram prog =
        rawSystemProgramConf
        (fromFlagOrDefault normal (buildVerbosity flags))
        prog
        (withPrograms lbi)

  runProgram ghcProgram ["-o", "temp", "temp.hs"]