provider "google" {
  credentials   = file ("cloud-2024-418004-0558f8df9059.json")
  project 	= "cloud-2024-418004"
  region  	= "us-west1"
}
# Create VPC
resource "google_compute_network" "my_vpc" {
  name = "lopes-vpc"
  auto_create_subnetworks = false
}

# Create Public Subnet
resource "google_compute_subnetwork" "public_subnet" {
  name = "lopes-public-subnet"
  network = google_compute_network.my_vpc.id
  ip_cidr_range = "10.0.2.0/24"
  region = "us-central1"
}
# Create Private Subnet
resource "google_compute_subnetwork" "private_subnet" {
  name = "lopes-private-subnet"
  network = google_compute_network.my_vpc.self_link
  ip_cidr_range= "10.0.1.0/24"
  region = "us-west1"
  private_ip_google_access = true
}
