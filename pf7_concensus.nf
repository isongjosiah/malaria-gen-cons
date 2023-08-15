projectDir = "$params.wd"
println "$projectDir"
process getAccensionNumbers {
  input:
  path params.in

  output:
  val accensionNumbers
  script:
  """
  python $projectDir/parse_excel.py $params.in
  """
}

process generateConsensus {
  input:
  path x
  output:
  stdout
  script:
  """
  sh generate_consensus.sh -r x
  """
}

workflow {
    accensionNumbers = getAccensionNumbers(params.in) | generateConsensus
}