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

2. 実行中のファイルシステムへの書き込みを禁止[2]

		sudo cp　./config/rosconfig.cmake ${ROS_ROOT}/
		sudo rm ${ROS_ROOT}/config/python_logging.conf

※Start with 'rosmaster --core' instead of 'roscore'. This avoids firing up rosout.



<参考文献>  
[1]http://wiki.ros.org/ja/kinetic/Installation/Ubuntu  
[2]https://answers.ros.org/question/9627/how-can-i-completely-disable-writing-logs-to-filesystem/  
