Return-Path: <mst@redhat.com>
Date: Wed, 15 Feb 2023 19:20:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] content.tex Fix Driver notifications label
Message-ID: <20230215191830-mutt-send-email-mst@kernel.org>
References: <20230203183532.90685-1-parav@nvidia.com>
 <87k00p9331.fsf@redhat.com>
 <20230215061424-mutt-send-email-mst@kernel.org>
 <871qmrdstu.fsf@redhat.com>
 <20230215075915-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481A47EF49115D98E310521DCA39@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481A47EF49115D98E310521DCA39@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 15, 2023 at 09:53:55PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, February 15, 2023 8:00 AM
> > 
> > btw did you try to generate a diff pdf? when changing labels it is sometimes
> > necessary to keep old ones around too as diff needs old and new links to work.
> 
> I generated the new pdf before pushing the patch. 
> I couldn't generate the diff pdf using ./makediffpdf.sh
> 
> I get error on running makediff.sh virtio.tex
> 
> Warning: command \@chapapp containing @ found in
> Warning: virtio.tex.
> Warning: consider using --makeatletter if the result is not compilable.
> Warning: command \@chapapp containing @ found in
> Warning: ./main.tex.
> Warning: consider using --makeatletter if the result is not compilable.
> Submodule path 'latexdiff' not initialized
> Maybe you want to use 'update --init'?
> make: Entering directory '/images/parav/upstream/virtio-spec/latexdiff'
> make: *** No rule to make target 'mkdirs'.  Stop.
> make: Leaving directory '/images/parav/upstream/virtio-spec/latexdiff'
> ./makediff.sh: line 51: ./latexdiff-fast: No such file or directory


Hmm. does this help:


diff --git a/makediff.sh b/makediff.sh
index c925c5f..f65a2b4 100755
--- a/makediff.sh
+++ b/makediff.sh
@@ -44,7 +44,7 @@ latexpand $MAIN -o flat.tex
 cd "${cur}"
 #wget http://mirror.math.ku.edu/tex-archive/support/latexdiff/latexdiff-fast
 #chmod +x latexdiff-fast
-git submodule update latexdiff
+git submodule update --init latexdiff
 make -C latexdiff mkdirs dist/latexdiff-fast
 ln -fs ./latexdiff/dist/latexdiff-fast ./latexdiff-fast
 ./latexdiff-fast \

