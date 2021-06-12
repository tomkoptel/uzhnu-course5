set container=%1
set path_to_dyplom=%2
echo "Args passed"
echo %container%
echo "Removing previous copy from container"
winpty docker exec -it %container% sh -c "rm -r /root/dyplom"
echo "Copying papers/dyplom container"
docker cp papers/dyplom %container%:/root
echo "Building paper"
winpty docker exec -it %container% sh -c "(cd /root/dyplom && ./build.sh)"
IF EXIST dyplom.pdf (
  echo "Found previous build result. Removing it..."
  del dyplom.pdf
) ELSE (
  echo "No previous build"
)
echo "Copying result of build..."
docker cp %container%:/root/dyplom/dyplom.pdf .
