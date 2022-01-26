# /bin/bash
echo "start build k8s images"
# login dockerhub
echo "${DOCKER_PASSWORD}" | docker login -u "${DOCKER_USERNAME}" --password-stdin

for file in `ls .`
do
        if [[ -d $file && -f $file/Dockerfile ]];then
                # 读取dockerfile第一行内容
                first_row=`head -n +1 $file/Dockerfile`
                # 获取标签
                tag=${first_row//*\//}
                # 构建镜像
                docker build -t peng49/${tag} $file/

                # push镜像到dockerhub
                docker push peng49/${tag}

                echo "push image peng49/${tag} to dockerhub"
        fi
done