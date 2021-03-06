package OrthoMCLWorkflow::Main::WorkflowSteps::AddNumberMembers;

@ISA = (ApiCommonWorkflow::Main::WorkflowSteps::WorkflowStep);

use strict;
use ApiCommonWorkflow::Main::WorkflowSteps::WorkflowStep;


sub run {
  my ($self, $test, $undo) = @_;

  my $groupTypesCPR = $self->getParamValue('groupTypesCPR');

  my $args = " --groupTypesCPR $groupTypesCPR";

  $self->runPlugin($test, $undo, "OrthoMCLData::Load::Plugin::AddNumberOfMembers", $args);

}
