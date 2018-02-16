Return-Path: virtio-return-2905-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Fri, 16 Feb 2018 17:45:03 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180216174503.75b1634f.cohuck@redhat.com>
In-Reply-To: <20180216092540-mutt-send-email-mst@kernel.org>
References: <1518765602-8739-1-git-send-email-mst@redhat.com>
	<20180216092540-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio] Re: [PATCH v8 12/16] makediff: update to show diff from master
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Halil Pasic <pasic@linux.vnet.ibm.com>, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, 16 Feb 2018 09:25:40 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  makediff.sh | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/makediff.sh b/makediff.sh
> index 1dd75d4..2ef92fc 100755
> --- a/makediff.sh
> +++ b/makediff.sh
> @@ -9,7 +9,7 @@ export DATESTR=${DATESTR:-`cat REVISION-DATE`}
>  MAIN=$1
>  PATH=.:${PATH}
>  cur="$PWD"
> -oldrev=`git rev-list -1 origin/tags/v1.0-cs03`
> +oldrev=`git rev-list -1 origin/master`
>  newrev=`git rev-list -1 HEAD`
>  rm -fr old new
>  git clone $PWD old
> @@ -19,7 +19,6 @@ while read -r rev; do
>  	echo "Applying $rev"
>  	git cherry-pick `git rev-list -1 -F --grep "$rev" $newrev` || exit 1
>  done << 'EOF'
> -headerfile: rename virtio_ring to virtio queue
>  EOF
>  
>  #mv specvars.tex specvars-orig.tex

So, this script is now always supposed to be run on a branch to get the
diff to master?

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

