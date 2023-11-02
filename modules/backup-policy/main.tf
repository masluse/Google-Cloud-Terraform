resource "google_compute_resource_policy" "snapshot_schedule" {
  name      = var.bp_name
  region    = var.region
  project   = var.project_id
  snapshot_schedule_policy {
    schedule {
      daily_schedule {
        days_in_cycle = 1
        start_time    = var.bp_start_time
      }
    }
    retention_policy {
      max_retention_days    = var.bp_retention_days
      on_source_disk_delete = "KEEP_AUTO_SNAPSHOTS"
    }
  }
}