#!/bin/bash
set -e
set -o pipefail

# For backwards compatibility
if [[ -n "$TOKEN" ]]; then
    GITHUB_TOKEN=$TOKEN
fi

if [[ -z "$PAGES_BRANCH" ]]; then
    PAGES_BRANCH="gh-pages"
fi

if [[ -z "$BUILD_DIR" ]]; then
    BUILD_DIR="."
fi

if [[ -n "$REPOSITORY" ]]; then
    TARGET_REPOSITORY=$REPOSITORY
else
    if [[ -z "$GITHUB_REPOSITORY" ]]; then
        echo "Set the GITHUB_REPOSITORY env variable."
        exit 1
    fi
    TARGET_REPOSITORY=${GITHUB_REPOSITORY}
fi

if [[ -z "$BUILD_ONLY" ]]; then
    BUILD_ONLY=false
fi

if [[ -z "$GITHUB_TOKEN" ]] && [[ "$BUILD_ONLY" == false ]]; then
    echo "Set the GITHUB_TOKEN or TOKEN env variables."
    exit 1
fi

if [[ -z "$GITHUB_HOSTNAME" ]]; then
    GITHUB_HOSTNAME="github.com"
fi

main() {
    echo "Starting deploy..."

    git config --global url."https://".insteadOf git://
    ## $GITHUB_SERVER_URL is set as a default environment variable in all workflows, default is https://github.com
    git config --global url."$GITHUB_SERVER_URL/".insteadOf "git@${GITHUB_HOSTNAME}":

    version=$(zola --version)
    remote_repo="https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@${GITHUB_HOSTNAME}/${TARGET_REPOSITORY}.git"
    remote_branch=$PAGES_BRANCH

    echo "Using $version"

    echo "Building in $BUILD_DIR directory"
    cd $BUILD_DIR

    echo Building with flags: ${BUILD_FLAGS:+"$BUILD_FLAGS"}
    zola build ${BUILD_FLAGS:+$BUILD_FLAGS}

    echo "building docs"
    ls
    mkdir -p public/docs/
    
    git clone https://github.com/orientechnologies/orientdb-docs.git orientdb-docs
    cd orientdb-docs
    
    echo "building docs for 3.0.x"    
    git switch 3.0.x
    mdbook build
    rm orientdb-book/.git -rf 
    mv orientdb-book/ ../public/docs/3.0.x/

    echo "building docs for 3.1.x"    
    git switch 3.1.x
    mdbook build
    rm orientdb-book/.git -rf 
    mv orientdb-book/ ../public/docs/3.1.x/

    echo "building docs for 3.2.x"    
    git switch 3.2.x
    mdbook build
    rm orientdb-book/.git -rf 
    mv orientdb-book/ ../public/docs/3.2.x/

    cd ../
    export JAVA_HOME=/usr/lib/jvm/default-java/

    mkdir -p public/javadocs/
    git clone https://github.com/orientechnologies/orientdb.git orientdb
    cd orientdb

    echo "building javadocs for 3.2.x"    
    git checkout 3.2.31
    mvn clean javadoc:aggregate
    mv target/site/apidocs/ ../public/javadocs/3.2.x/

    cd ../

    if ${BUILD_ONLY}; then
        echo "Build complete. Deployment skipped by request"
        exit 0
    else
        echo "Pushing artifacts to ${TARGET_REPOSITORY}:$remote_branch"

        cd public
        git init
        git config user.name "GitHub Actions"
        git config user.email "github-actions-bot@users.noreply.${GITHUB_HOSTNAME}"
        touch .nojekyll
        git add .

        git commit -m "Deploy ${TARGET_REPOSITORY} to ${TARGET_REPOSITORY}:$remote_branch"
        git push --force "${remote_repo}" master:${remote_branch}

        echo "Deploy complete"
    fi
}

main "$@"
