export async function cleanLocation (location) {
  return {
    id: location.id,
    latitude: location.latitude,
    longitude: location.longitude,
    type: location.type.name ? location.type.name : location.type
  }
}
