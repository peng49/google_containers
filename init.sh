#/bin/bash
pwd=${pwd}
for image in `kubeadm config images list`;do
        # get name and version
        name_version=${image//k8s.*\//}
        # echo $name_version
        name=${name_version//\:*/}
        version=${name_version//*:/}
        if [ ! -d `pwd`/${name} ];then
                mkdir $name
        fi
        # echo $name
        cat <<EOF > `pwd`/$name/Dockerfile
FROM $image
EOF
        echo "build ${image} Dockerfile"
done
