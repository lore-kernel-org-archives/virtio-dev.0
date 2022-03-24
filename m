Return-Path: <mst@redhat.com>
Date: Thu, 24 Mar 2022 08:02:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] [PATCH] packed-ring: fix some typos
Message-ID: <20220324080218-mutt-send-email-mst@kernel.org>
References: <20220324103412.2740-1-mst@redhat.com>
 <87y20z61ck.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87y20z61ck.fsf@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Mar 24, 2022 at 12:23:23PM +0100, Cornelia Huck wrote:
> On Thu, Mar 24 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > flag is misnamed in a couple of places.
> 
> s//The VIRTQ_DESC_F_INDIRECT_FLAG /

You mean VIRTQ_DESC_F_INDIRECT don't you?

> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  packed-ring.tex | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

