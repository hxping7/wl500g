#!/bin/sh
set -e

pkg_dir=$1

if [ -z $pkg_dir ] || [ ! -d $pkg_dir ]; then
        echo "Usage: ipkg-make-index <package_directory>"
        exit 1
fi

which md5sum 2>&1 >/dev/null || alias md5sum=md5

pkg_list=$pkg_dir/Packages
rm -f ${pkg_list}.tmp

for pkg in `find $pkg_dir -name '*.ipk' | sort`; do
        echo "Generating index for package $pkg" >&2
        file_size=$(ls -l $pkg | awk '{print $5}')
        md5sum=$(md5sum $pkg | awk '{print $1}')
        # Take pains to make variable value sed-safe
        sed_safe_pkg=`basename $pkg | sed -e 's/^\.\///g' -e 's/\\//\\\\\\//g'`
        tar --wildcards -xzOf $pkg '*control.tar.gz' | tar --wildcards -xzOf - '*control' | sed -e "s/^Description:/Filename: $sed_safe_pkg\\
Size: $file_size\\
MD5Sum: $md5sum\\
Description:/"  >>${pkg_list}.tmp
        echo "" >>${pkg_list}.tmp
done

mv ${pkg_list}.tmp ${pkg_list}
