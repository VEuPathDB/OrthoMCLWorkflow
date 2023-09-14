package OrthoMCLWorkflow::Main::WorkflowSteps::MakeOrthoFinderNextflowConfig;

@ISA = (ApiCommonWorkflow::Main::WorkflowSteps::WorkflowStep);

use strict;
use warnings;
use ApiCommonWorkflow::Main::WorkflowSteps::WorkflowStep;

sub run {
  my ($self, $test, $undo) = @_;

  my $clusterWorkflowDataDir = $self->getClusterWorkflowDataDir();
  my $previousBlasts = $self->getConfig('previousBlasts');
  my $outdated = $self->getConfig('outdated');
  my $inputFile = join("/", $clusterWorkflowDataDir, $self->getParamValue("inputFile"));
  my $analysisDir = $self->getParamValue("analysisDir");
  my $pValCutoff  = $self->getParamValue("pValCutoff");
  my $lengthCutoff  = $self->getParamValue("lengthCutoff");
  my $percentCutoff  = $self->getParamValue("percentCutoff");
  my $adjustMatchLength   = $self->getParamValue("adjustMatchLength");

  my $clusterResultDir = join("/", $clusterWorkflowDataDir, $self->getParamValue("clusterResultDir"));
  my $configPath = join("/", $self->getWorkflowDataDir(),  $self->getParamValue("analysisDir"), $self->getParamValue("configFileName"));

  my $executor = $self->getClusterExecutor();
  my $queue = $self->getClusterQueue();

  if ($undo) {
    $self->runCmd(0,"rm -rf $configPath");
  } else {
    open(F, ">", $configPath) or die "$! :Can't open config file '$configPath' for writing";

    print F
"
params {
  inputFile = \"$inputFile\"
  outputDir = \"$clusterResultDir\"
  pValCutoff  = $pValCutoff
  lengthCutoff  = $lengthCutoff
  percentCutoff  = $percentCutoff
  adjustMatchLength   = $adjustMatchLength
  outdated = \"$outdated\"
}

process {
  executor = \'$executor\'
  queue = \'$queue\'
}

singularity {
  enabled = true
  autoMounts = true
  runOptions = \"--bind $previousBlasts:/previousBlasts\"
}
";
  close(F);
 }
}

1;

