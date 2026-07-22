// Aggregating entry point for the generated per-entity SDK tests. Drives
// every <Entity>EntityTest / <Entity>DirectTest object through one shared
// SdkTestReport and exits non-zero on any failure.
// Run: scala-cli run . --main-class SdkEntityTestMain

object SdkEntityTestMain {

  def main(args: Array[String]): Unit = {
    val rep = new SdkTestReport()

    BatchEntityTest.run(rep)
    BatchDirectTest.run(rep)
    BatchMessageEntityTest.run(rep)
    CreditEntityTest.run(rep)
    CreditDirectTest.run(rep)
    FlashEntityTest.run(rep)
    MessageEntityTest.run(rep)
    MessageDirectTest.run(rep)
    OneTimePasswordEntityTest.run(rep)
    OneTimePasswordDirectTest.run(rep)
    ScheduleEntityTest.run(rep)
    SwaggerEntityTest.run(rep)
    UtilEntityTest.run(rep)
    UtilDirectTest.run(rep)

    ReadmeExamplesTest.run(rep)

    rep.finish("ENTITY")
  }
}
