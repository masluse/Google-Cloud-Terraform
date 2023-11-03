resource "google_compute_resource_policy" "snapshot_schedule" {
  name    = var.name
  region  = var.region
  project = var.project_id
  snapshot_schedule_policy {
    schedule {
      daily_schedule {
        days_in_cycle = var.days_in_cycle
        start_time    = var.start_time
      }
    }
    retention_policy {
      max_retention_days    = var.retention_days
      on_source_disk_delete = "KEEP_AUTO_SNAPSHOTS"
    }
  }
}