package OrthoMCLWorkflow::Main::WorkflowSteps::ExtractFilesForMsa;

@ISA = (ApiCommonWorkflow::Main::WorkflowSteps::WorkflowStep);

use strict;
use ApiCommonWorkflow::Main::WorkflowSteps::WorkflowStep;


sub run {
    my ($self, $test, $undo) = @_;

    my $workflowDataDir = $self->getWorkflowDataDir();

    my $outputDir = $self->getParamValue('outputDir');
    my $tarSize = $self->getParamValue('proteinsPerTarFile');
    my $maxGroupSize = $self->getParamValue('maxGroupSize');
    my $groupTypesCPR = $self->getParamValue('groupTypesCPR');
    my $samplingOfSeqs = $self->getParamValue('samplingOfSeqs');

    if ($undo) {
	$self->runCmd($test, "rm $workflowDataDir/$outputDir/*");
	$self->runCmd($test, "rm -r $workflowDataDir/$outputDir");
    } else{
      if ($test) {
	$self->runCmd(0, "mkdir $workflowDataDir/$outputDir");
      } else {
	$self->runCmd($test, "extractGroupFastaFiles --outputDir $workflowDataDir/$outputDir --samplingOfSeqs $samplingOfSeqs --groupTypesCPR $groupTypesCPR --tarBall $tarSize --maxGroupSize $maxGroupSize");
      }
    }
}
