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

	- [catkin_clang_format](https://github.com/nyxrobotics/catkin_clang_format)を導入する
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