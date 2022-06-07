resource "aws_config_configuration_recorder" "configuration_recorder_with_all_supported_true_with_connection_to_staus_enabled_passed" {
  name     = "configuration_recorder_with_all_supported_true_with_connection_to_staus_enabled_passed"
  recording_group ={
    all_supported = true
  }
}

resource "aws_config_configuration_recorder_status" "configuration_recorder_status_enabled" {
  name       = aws_config_configuration_recorder.configuration_recorder_with_all_supported_true_with_connection_to_staus_enabled_passed.name
  is_enabled = true
}
