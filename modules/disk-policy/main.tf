# This resource defines a Google Compute Engine resource policy for disk snapshots.
resource "google_compute_resource_policy" "default" {
  name    = var.name           # The name of the resource policy.
  region  = var.region         # The region where the policy will be applied.
  project = var.project_id     # The Google Cloud project ID for the policy.

  # Configures the snapshot schedule policy.
  snapshot_schedule_policy {
    schedule {
      daily_schedule {
        days_in_cycle = var.days_in_cycle # Frequency of the backup cycle in days.
        start_time    = var.start_time    # Start time for daily backups.
      }
    }

    # Sets the retention policy for snapshots.
    retention_policy {
      max_retention_days    = var.retention_days # Maximum number of days to retain snapshots.
      on_source_disk_delete = "KEEP_AUTO_SNAPSHOTS" # Retention behavior on source disk deletion.
    }
  }
}