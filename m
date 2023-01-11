Return-Path: <mst@redhat.com>
Date: Wed, 11 Jan 2023 09:55:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] [PATCH v3 06/20] virtio-mem-balloon: Maintain mem
 balloon device spec in separate directory
Message-ID: <20230111095538-mutt-send-email-mst@kernel.org>
References: <20230110230358.528098-1-parav@nvidia.com>
 <20230110230358.528098-7-parav@nvidia.com>
 <b95d3aab-21c0-8256-a8bd-09e5b45cd206@redhat.com>
MIME-Version: 1.0
In-Reply-To: <b95d3aab-21c0-8256-a8bd-09e5b45cd206@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: David Hildenbrand <david@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, virtio-comment@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 11, 2023 at 03:14:10PM +0100, David Hildenbrand wrote:
> On 11.01.23 00:03, Parav Pandit wrote:
> > Move virtio memory balloon device specification to its own file
> > similar to recent virtio devices.
> > While at it, place device specification, its driver and device
> > conformance into its own directory to have self contained device
> > specification.
> > 
> > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/153
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > 
> 
> There is virtio-mem and there is virtio-balloon. Calling virtio-balloon
> "virtio-mem-balloon" can easily lead to quite some confusion. Any particular
> reason why not to stick to "virtio-balloon" ?

Yea, virtio-balloon scans better.

> -- 
> Thanks,
> 
> David / dhildenb

