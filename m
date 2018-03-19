Return-Path: virtio-return-3022-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Mon, 19 Mar 2018 17:38:09 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180319173730-mutt-send-email-mst@kernel.org>
References: <20180314154618.13069-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314154618.13069-1-stefanha@redhat.com>
Subject: [virtio] Re: [PATCH 0/7] Packed ring layout wording and typo fixes
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Tiwei Bie <tiwei.bie@intel.com>, Cornelia Huck <cohuck@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Mar 14, 2018 at 03:46:11PM +0000, Stefan Hajnoczi wrote:
> These patches tweak the wording and fix typos in v10 of the packed ring layout
> spec.
> 
> Michael: Feel free to squash this into your patch series if you agree with the
> changes.  I don't mind if my authorship disappears.

Now that v10 of the patches has been voted in, we can apply these.
Ballot started:

https://www.oasis-open.org/apps/org/workgroup/virtio/ballot.php?id=3184

> Stefan Hajnoczi (7):
>   packed-ring: add missing articles to sentences
>   packed-ring: add missing comma
>   packed-ring: fix 'contigious' typo
>   packed-ring: fix capitalization of names
>   packed-ring: fix plurals
>   packed-ring: fix "the descriptor flags +field+ is updated"
>   packed-ring: rephrase "an example driver code"
> 
>  packed-ring.tex | 110 ++++++++++++++++++++++++++++----------------------------
>  1 file changed, 55 insertions(+), 55 deletions(-)
> 
> -- 
> 2.14.3

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

