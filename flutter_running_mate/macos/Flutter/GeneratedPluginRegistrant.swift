//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

<<<<<<< Updated upstream

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
=======
import device_info_plus
import geolocator_apple

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  DeviceInfoPlusMacosPlugin.register(with: registry.registrar(forPlugin: "DeviceInfoPlusMacosPlugin"))
  GeolocatorPlugin.register(with: registry.registrar(forPlugin: "GeolocatorPlugin"))
>>>>>>> Stashed changes
}
