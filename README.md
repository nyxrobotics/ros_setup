# ros_setup  
Ubuntu16.04にROS kineticを導入するための手順  
kernel:4.15.0-64-generic

1. ROSをインストール[1]

		sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
		sudo apt-key adv --keyserver 'hkp://ha.pool.sks-keyservers.net:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
		sudo apt update
		sudo apt install ros-kinetic-desktop-full
		sudo rosdep init
		rosdep update
		echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
		ource ~/.bashrc
		sudo apt install python-rosinstall

1. 実行中のファイルシステムへの書き込みを禁止[2]

		sudo cp　./config/rosconfig.cmake ${ROS_ROOT}/
		sudo rm ${ROS_ROOT}/config/python_logging.conf

    ※Start with 'rosmaster --core' instead of 'roscore'. This avoids firing up rosout.

1. clang-formatとclang-tidyを使用してコード整形[3]（.clang-format[4], .clang-tidy[5]）

	- 必要なパッケージをインストール
	
        sudo apt install clang-8 clang-format-8 clang-tidy-8 clang-tools-8

    - このリポジトリの、clangフォルダ内(cmake, .clang-format, .clang-tidy)をCMakeLists.txtと同階層にコピー
    - CMakeLists.txtの最初に以下を追記

			#cmake_minimum_required(VERSION 2.8.3)
			#cmake_policy(SET CMP0054 NEW)
			#project(何かしらのROSパッケージ名)
			# ここから下
			set(CMAKE_CXX_FLAGS "-std=c++11 ${CMAKE_CXX_FLAGS}")
			option(ENABLE_CLANG_BUILD "Enable Clang Build Tools" ON)
			option(ENABLE_CLANG_FORMAT_FIX "Perform fixes for Clang-Format" OFF)
			option(ENABLE_CLANG_TIDY_FIX "Perform fixes for Clang-Tidy" OFF)
			include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/ClangFormatMacros.cmake)
			if(ENABLE_CLANG_BUILD)
				enable_clang_build()
			endif()
			if(ENABLE_CLANG_FORMAT_FIX)
				clang_format_fix()
			endif()
			if(ENABLE_CLANG_TIDY_FIX)
				clang_tidy_fix()
			endif()
			# ここまで

	- 上記のファイルにて、ENABLE_CLANG_FORMAT_FIXおよびENABLE_CLANG_TIDY_FIXをONにしてcatkin btすると整形される

	- 以下補足
	    - clang : warningやerrorが少し見やすいコンパイラ。速さはgccと大差なし（clangの方が少し早いかも）
	    - clang-format : インデント・改行を修正する。
	    - clang-tidy : 変数名・関数名を修正する。コンパイル時、自動修正が発生した場合は一度エラーメッセージとして通知・中断してくるため、２回コンパイルしないと通らない点に注意。
	    - clang-formatおよびclang-tidyは、コンパイルのたびに毎回実行すると重いのでデフォルトで無効・コミット前に一時的に有効にする等が良いと思われる。



 







<参考文献>  
[1]http://wiki.ros.org/ja/kinetic/Installation/Ubuntu  
[2]https://answers.ros.org/question/9627/how-can-i-completely-disable-writing-logs-to-filesystem/  
[3]https://qiita.com/tenmyo/items/f8548ee9bab78f18cd25    
[4]https://github.com/davetcoleman/roscpp_code_format  
[5]https://github.com/ros-planning/moveit/blob/master/.clang-tidy