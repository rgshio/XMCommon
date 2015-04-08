/*
1.更新gem
    sudo gem update --system
2.更换ruby源,因为ruby源使用的是亚马逊的云服务，所以被屏蔽掉了，要更换为国内的ruby源
gem sources --remove https://rubygems.org/
gem sources -a http://ruby.taobao.org/
gem sources -l


3.下载和安装cocoaPods
sudo gem install cocoapods


4.替换cocospods索引，因为国外的服务器下载很慢，替换国内的会很快
pod repo remove master
pod repo add master https://gitcafe.com/akuandev/Specs.git
pod repo update

5.cd到项目根目录，创建名为Podfile的文件
cd 项目路径
vim Podfile

6.查找所需要依赖库的版本
pod search 依赖库


7.在Podfile文件中输入所需要的依赖库
platform :ios
pod 'AFNetworking', '~> 2.5.1'

8.下载第三方库
pod install

9.更新依赖库版本
pod update

10.在项目中导入头文件需要设置
search Paths里的User Header Search Paths里输入${SRCROOT}  后面选上recursive，弄好后就可以在项目中import如依赖库的头文件了
*/