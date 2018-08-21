
Pod::Spec.new do |s|
    s.name             = 'XCLabelListView'
    s.version          = '0.0.1'
    s.summary          = 'XCLabelListView.'
    
    s.description      = <<-DESC
    XCLabelListView，列表标签视图
    DESC
    
    s.homepage         = 'https://github.com/fanxiaocong/XCLabelListView'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'fanxiaocong' => '1016697223@qq.com' }
    s.source           = { :git => 'https://github.com/fanxiaocong/XCLabelListView.git', :tag => s.version.to_s }
    
    s.ios.deployment_target = '8.3'
    
    s.source_files = 'XCLabelListView/Classes/**/*'
    
end

