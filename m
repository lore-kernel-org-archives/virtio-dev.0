Return-Path: <mst@redhat.com>
Date: Thu, 20 Jan 2022 11:52:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-comment] Re: [virtio] [PATCH] virtio: clarify feature
 negotiation
Message-ID: <20220120114856-mutt-send-email-mst@kernel.org>
References: <20220114225032.290762-1-mst@redhat.com>
 <20220119132319.5ee3821d.pasic@linux.ibm.com>
 <20220119112059-mutt-send-email-mst@kernel.org>
 <87k0eud0bi.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87k0eud0bi.fsf@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jan 20, 2022 at 02:05:37PM +0100, Cornelia Huck wrote:
> Do we know anything about the state of e.g. hardware implementations?

One I'm aware of is LE and just does not work on BE
platforms in legacy mode. But generally hardware has a standard MTU
so does not need it ...

-- 
MST

