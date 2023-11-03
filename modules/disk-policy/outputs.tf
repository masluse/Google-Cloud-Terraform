output "snapshot_schedule_id" {
  description = "The ID of the snapshot schedule"
  value       = google_compute_resource_policy.snapshot_schedule.name
}

output "snapshot_schedule_self_link" {
  description = "The self link of the snapshot schedule"
  value       = google_compute_resource_policy.snapshot_schedule.self_link
}