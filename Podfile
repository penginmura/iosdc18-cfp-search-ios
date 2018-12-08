# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

# Tools
pod 'SwiftFormat/CLI'
pod 'SwiftLint'
pod 'R.swift', '5.0.0.alpha.2'

target 'Konosuba' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Rx
  pod 'RxSwift', '~> 4.0'
  pod 'RxCocoa', '~> 4.0'

  #
  # script phases
  #
  script_phase :name => '1. SwiftFormat',
               :script => '"${PODS_ROOT}/SwiftFormat/CommandLineTool/swiftformat" "${SRCROOT}"',
               :execution_position => :before_compile

  script_phase :name => '2. R.swift',
               :script => '"$PODS_ROOT/R.swift/rswift" generate "$SRCROOT"',
               :execution_position => :before_compile

  script_phase :name => '3. SwiftLint',
               :script => '"${PODS_ROOT}/SwiftLint/swiftlint"',
               :execution_position => :before_compile

  target 'KonosubaTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'KonosubaUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
